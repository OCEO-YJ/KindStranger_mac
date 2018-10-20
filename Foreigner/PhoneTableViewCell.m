//
//  PhoneTableViewCell.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 14..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "PhoneTableViewCell.h"

@implementation PhoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        NSLog(@"1");
        CGSize winsize = [UIScreen mainScreen].bounds.size;
        
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, winsize.width-_phoneNumber.frame.origin.x, 20)];
        [_title setText:@"Title"];
        [_title setFont:[UIFont systemFontOfSize:17]];
//        [_title sizeToFit];
        [_title setTextAlignment:NSTextAlignmentLeft];
        [_title setTextColor:[UIColor blueColor]];
//        [_title setBackgroundColor:[UIColor blackColor]];
        [self addSubview:_title];
        
        
        _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, _title.frame.origin.y +20, winsize.width-10, 20)];
        [_subTitle setText:@"subTitle"];
        [_subTitle setFont:[UIFont systemFontOfSize:14]];
//        [_subTitle sizeToFit];
        [_subTitle setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_subTitle];
        

        
        _phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, winsize.width-15, 10)];
        [_phoneNumber setText:@"010-9670-0456"];
        [_phoneNumber setTextColor:[UIColor redColor]];
        [_phoneNumber setFont:[UIFont systemFontOfSize:12]];
        [_phoneNumber setTextAlignment:NSTextAlignmentRight];
//        [_phoneNumber setBackgroundColor:[UIColor blackColor]];
        [self addSubview:_phoneNumber];
        
        _phoneCategory = [[UILabel alloc] initWithFrame:CGRectMake(10, _phoneNumber.frame.origin.y+20, winsize.width-15, 15)];
        [_phoneCategory setText:@"Category"];
        [_phoneCategory setTextColor:[UIColor brownColor]];
        [_phoneCategory setFont:[UIFont systemFontOfSize:12]];
        [_phoneCategory setTextAlignment:NSTextAlignmentRight];
        [self addSubview:_phoneCategory];
        
        
        
        
    }
    return self;
}
- (IBAction)infoClicked:(UIButton *)sender {
    NSLog(@"Clicked");
}


- (void)bt{
    NSLog(@"Clicked");

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
