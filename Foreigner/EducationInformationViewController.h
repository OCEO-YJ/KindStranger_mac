//
//  EducationInformationViewController.h
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 18..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FlickTabView.h"
#import "EducationData.h"
#import "EducationDatabase.h"
#import "FXLabel.h"
@interface EducationInformationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FlickTabViewDataSource, FlickTabViewDelegate>


@property (weak,nonatomic) IBOutlet UIBarButtonItem* barButton;

@property NSArray* educationArray; //교육정보 Array
@property NSMutableArray* nameArray; // 처음 FlickTabView 이름 및 Count
@property FlickTabView* tabView;
@property EducationData* data;
@property EducationDatabase* db;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
