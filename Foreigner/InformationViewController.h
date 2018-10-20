//
//  InformationViewController.h
//  Foreigner
//
//  Created by dydwns628 on 2015. 1. 7..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickTabView.h"

@interface InformationViewController : UIViewController <FlickTabViewDataSource, FlickTabViewDelegate>

@property (weak,nonatomic) IBOutlet UIBarButtonItem* barButton;
@property UIView* informationView;
@property UIView* updateView;
@property UIView* vcvc;
@end
