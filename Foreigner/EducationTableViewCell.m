//
//  EducationTableViewCell.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 25..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "EducationTableViewCell.h"

@implementation EducationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGSize winsize = [UIScreen mainScreen].bounds.size;
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, winsize.width-20, 20)];
        _title.text = @"건국대학교 한국어교육부";
//        self.title.backgroundColor = [UIColor blackColor];
        _title.textColor = [UIColor blueColor];
//        _title.textAlignment = NSTextAlignmentLeft;
        [_title setFont:[UIFont systemFontOfSize:17]];
        [self addSubview:_title];
        
        
        _subTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, self.title.frame.origin.y+22, winsize.width-20, 20)];
//        _subTitle.text = @"Konkuk University Language Institute";
//        self.subTitle.backgroundColor= [UIColor blackColor];
//        _subTitle.textAlignment = NSTextAlignmentLeft;
//        [_subTitle setNumberOfLines:0];
        [_subTitle setFont: [UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_subTitle];
        
        _category = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, winsize.width-5, 20)];
        _category.text = @"[한국어]";
        _category.textAlignment = NSTextAlignmentRight;
        _category.textColor = [UIColor brownColor];
        [_category setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_category];
        
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
