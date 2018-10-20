//
//  EducationDetailCell.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 2. 1..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "EducationDetailCell.h"

@implementation EducationDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGSize winsize = [UIScreen mainScreen].bounds.size;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, winsize.width-20, 30)];
        [_title setFont:[UIFont systemFontOfSize:15]];
        _title.textColor = [UIColor blueColor];
        _title.text = @"TEXT";
        [self.contentView addSubview:_title];
        
        _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, _title.frame.origin.y+25, winsize.width-30, 0)];
//        [_subTitle setNumberOfLines:0];
        _subTitle.text = @"SUBTITLE";
        [_subTitle setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:_subTitle];
        
        
        
    }
    return self;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//    [self.contentView setNeedsLayout];
//    [self.contentView layoutIfNeeded];
//    
//    self.subTitle.preferredMaxLayoutWidth = CGRectGetWidth(self.subTitle.frame);
//}

@end
