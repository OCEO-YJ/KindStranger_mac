//
//  PhoneViewController.h
//  Foreigner
//
//  Created by dydwns628 on 2015. 1. 7..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickTabView.h"
#import "PhoneData.h"
#import "PhoneTableViewCell.h"
#import "DataBase.h"

@interface PhoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,FlickTabViewDataSource, FlickTabViewDelegate>


@property (weak,nonatomic) IBOutlet UIBarButtonItem* barButton;


@property IBOutlet UITableView* tableView;
@property PhoneData* phoneData;
@property NSArray* phoneArray;
@property DataBase *db;
@property FlickTabView* tabView;

@end
