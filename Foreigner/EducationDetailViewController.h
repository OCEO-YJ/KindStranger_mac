//
//  EducationDetailViewController.h
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 2. 1..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EducationData.h"
#import "FlickTabView.h"
#import "EducationDetailCell.h"
#import "EducationInformationViewController.h"
@interface EducationDetailViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,FlickTabViewDelegate,FlickTabViewDataSource,MKMapViewDelegate>

@property NSMutableArray* tabBarArray;
@property NSMutableArray* detailArray;
@property NSMutableArray* detailNameArray;
@property UITableView* tableView;
@property UIView* mapView;
@property MKMapView* map;



-(instancetype)initWithData:(EducationData *)data;

@end
