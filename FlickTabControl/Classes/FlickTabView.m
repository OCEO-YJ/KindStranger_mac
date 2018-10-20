//
//  FlickTabView.m
//  FlickTabControl
//
//  Created by Shaun Harrison on 12/12/08.
//  Copyright 2008 enormego. All rights reserved.
//

#import "FlickTabView.h"
#import "FlickTabButton.h"

@interface FlickTabView (Private)
- (void)setupCaps;
@end


@implementation FlickTabView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)setDataSource:(id<FlickTabViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self awakeFromNib];
}

- (void)awakeFromNib {
	_scrollView.scrollsToTop = NO;
	[self reloadData];
	
	if(_scrollView.subviews && _scrollView.subviews.count > 0) {
		[(FlickTabButton*)[_scrollView.subviews objectAtIndex:0] markSelected];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrientation) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)createView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = YES;
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);
    self.scrollView.delegate = self;
    
    self.backgroundColor = [UIColor colorWithHue:0.573816156f saturation:0.03f brightness:0.91f alpha:1.0f];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    imageView.image = [UIImage imageNamed:@"flick-tab-bck.png"];
    
    [self addSubview:imageView];
    
    
    
    [self addSubview:self.scrollView];

    self.leftCap = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flick-fade-lt.png"]];
    self.leftCap.frame = CGRectMake(0.0f, 0.0f, 39.0f, 43.0f);
    self.leftCap.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
    self.rightCap = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flick-fade-rt.png"]];
    self.rightCap.frame = CGRectMake(self.frame.size.width-39.0f, 0.0f, 39.0f, 43.0f);
    self.rightCap.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:self.leftCap];
    [self addSubview:self.rightCap];
}

- (void)reloadData {
	if(_scrollView.subviews && _scrollView.subviews.count > 0) {
		[_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	}
	
	if(!self.dataSource) {
		return;
	}
	
	int items;
	
	if((items = (int)[self.dataSource numberOfTabsInScrollTabView:self]) == 0) {
		return;
	}
	
	int x;
	
	float origin_x = 0;
	for(x=0;x<items;x++) {
		NSString* str = [self.dataSource scrollTabView:self titleForTabAtIndex:x];
		
		FlickTabButton* button = [[FlickTabButton alloc] initWithFrame:CGRectZero];
		[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		
//		CGSize size = [str sizeWithFont:button.font];
        
       CGSize size =  [str sizeWithAttributes:@{NSFontAttributeName:button.font}];
                                  
		button.frame = CGRectMake(origin_x, 0.0f, size.width+20.0f, 43.0f);
		origin_x += size.width + 3.0f + 20.0f;
		button.text = str;
		
		[_scrollView addSubview:button];
	}
	
	_scrollView.contentSize = CGSizeMake(origin_x, 43.0f);
	
	[self setupCaps];
}

- (void)buttonClicked:(FlickTabButton*)button {
	[_scrollView.subviews makeObjectsPerformSelector:@selector(markUnselected)];
	[button markSelected];
	
	if(self.delegate && [self.delegate respondsToSelector:@selector(scrollTabView:didSelectedTabAtIndex:)]) {
		[self.delegate scrollTabView:self didSelectedTabAtIndex:[_scrollView.subviews indexOfObject:button]];
	}
}

- (void)selectTabAtIndex:(NSInteger)index {
	[self selectTabAtIndex:index animated:NO];
}

- (void)selectTabAtIndex:(NSInteger)index animated:(BOOL)animated {
	if(!_scrollView.subviews || _scrollView.subviews.count < index+1) return;
	
	[_scrollView.subviews makeObjectsPerformSelector:@selector(markUnselected)];
	[(FlickTabButton*)[_scrollView.subviews objectAtIndex:index] markSelected];
	
	CGRect rect = ((FlickTabButton*)[_scrollView.subviews objectAtIndex:index]).frame;
	rect.size.width += 25.0f;
	
	[_scrollView scrollRectToVisible:rect animated:animated];
	
	[self setupCaps];
}

- (void)updateOrientation {
	[self performSelector:@selector(setupCaps) withObject:nil afterDelay:0.3];
}

- (void)setupCaps {
	if(_scrollView.contentSize.width <= _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right) {
		_leftCap.hidden = YES;
		_rightCap.hidden = YES;
	} else {
		if(_scrollView.contentOffset.x > (-_scrollView.contentInset.left)+10.0f) {
			_leftCap.hidden = NO;
		} else {
			_leftCap.hidden = YES;
		}
		
		if((_scrollView.frame.size.width+_scrollView.contentOffset.x)+10.0f >= _scrollView.contentSize.width) {
			_rightCap.hidden = YES;
		} else {
			_rightCap.hidden = NO;
		}
	}
	
}

- (void)scrollViewDidScroll:(UIScrollView *)inScrollView {
	[self setupCaps];
}

- (NSInteger)selectedTabIndex {
	int x = 0;
	
	for(FlickTabButton* tab in _scrollView.subviews) {
		if([tab isMemberOfClass:[FlickTabButton class]]) {
			if([tab isSelected]) return x;
		}
		
		x++;
	}
	
	return NSNotFound;
}

- (void)setButtonInsets:(UIEdgeInsets)insets {
	_buttonInsets = UIEdgeInsetsMake(0.0f, insets.left, 0.0f, insets.right);
	self.scrollView.contentInset = _buttonInsets;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


@end
