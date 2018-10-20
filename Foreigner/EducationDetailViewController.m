//
//  EducationDetailViewController.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 2. 1..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "EducationDetailViewController.h"
#import "EducationData.h"
#import "EducationDetailCell.h"

@interface EducationDetailViewController ()
@property EducationInformationViewController* inv;


@end



@implementation EducationDetailViewController

- (instancetype)initWithData:(EducationData *)data
{
    self = [super init];
    if (self) {

        self.view.backgroundColor = [UIColor whiteColor];
//        NSLog(@"latlng : %@",data.latlng);
        CGSize winsize = [UIScreen mainScreen].bounds.size;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height-43) style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        _tabBarArray = [NSMutableArray arrayWithObjects:@"개요", nil];

        

        /*Flick_Tab 생성 및 delegate, datasource (self)로 맞추고 화면에 붙힘*/
        FlickTabView* tabBar = [[FlickTabView alloc] initWithFrame:CGRectMake(0.0f, winsize.height-43.0f, winsize.width, 43.0f)];
        tabBar.delegate = self;
        tabBar.dataSource = self;
        [self.view addSubview:tabBar];
        
        _detailArray = [[NSMutableArray alloc] init];
        _detailNameArray = [[NSMutableArray alloc] init];

        if (!(data.title == nil)) {
            [_detailNameArray addObject:data.title];
        }
        if (!(data.subtitle == nil)) {
            [_detailArray addObject:data.subtitle];
        }
        if (!(data.summary == nil)) {
            [_detailNameArray addObject:@"설명"];
            [_detailArray addObject:data.summary];
        }
        if (!(data.phoneNumber == nil)) {
            [_detailNameArray addObject:@"전화번호"];
            [_detailArray addObject:data.phoneNumber];
        }
        if (!(data.faxNumber == nil)) {
            [_detailNameArray addObject:@"팩스번호"];
            [_detailArray addObject:data.faxNumber];
        }
        if (!(data.email == nil)) {
            [_detailNameArray addObject:@"이메일"];
            [_detailArray addObject:data.email];
        }
        if (!(data.site == nil)) {
            [_detailNameArray addObject:@"사이트"];
            [_detailArray addObject:data.site];
        }
        if (!(data.address == nil)) {
            [_detailNameArray addObject:@"주소"];
            [_detailArray addObject:data.address];
        }
        if (!(data.latlng == nil)) {
            [_tabBarArray addObject:@"위치"];
            [tabBar reloadData];
        }


        NSLog(@"latlng : %@",data.latlng);
        
        _mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height-43)];
        _mapView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_mapView];
        _map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height-43)];
        _map.showsUserLocation = YES;
        _map.delegate = self;
        
        
        NSArray* latlng =[data.latlng componentsSeparatedByString:@","];
        CLLocationCoordinate2D region = {[latlng[0] doubleValue],[latlng[1] doubleValue]};
        MKCoordinateRegion realRegion =MKCoordinateRegionMakeWithDistance(region, 500, 500);
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = region;
        point.title = data.title;
        point.subtitle = data.subtitle;
        [_map addAnnotation:point];
        [_map setRegion:realRegion animated:YES];
        [_map selectAnnotation:point animated:NO];
        
        [_mapView addSubview:_map];
        [_mapView setHidden:true];


    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _detailNameArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString* educationIdentifier =@"Education";
    
    EducationDetailCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Education"];
    
    if (cell == nil) {
        cell = [[EducationDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Education"];
    }
    CGSize winsize = [UIScreen mainScreen].bounds.size;

    cell.title.text = _detailNameArray[indexPath.row];
    
    [cell.subTitle setNumberOfLines:0];
    cell.title.frame = CGRectMake(20, 5, winsize.width-20, 30);
    
    cell.subTitle.frame =CGRectMake(20, cell.title.frame.origin.y+25, winsize.width-30, 0);

    cell.subTitle.text = _detailArray[indexPath.row];
    [cell.subTitle sizeToFit];
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    CGSize winsize = [UIScreen mainScreen].bounds.size;
    EducationDetailCell* cell =[[EducationDetailCell alloc] init];
    cell.title.text = _detailNameArray[indexPath.row];
    [cell.subTitle setNumberOfLines:0];
    
//    cell.title.frame = CGRectMake(20, 5, winsize.width-20, 30);
//
//    cell.subTitle.frame =CGRectMake(20, cell.title.frame.origin.y+25, winsize.width-30, 0);

    cell.subTitle.text = _detailArray[indexPath.row];
    [cell.subTitle setNumberOfLines:0];

    [cell.subTitle sizeToFit];
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    
    return cell.subTitle.frame.size.height + cell.title.frame.size.height + 7 * 2;
        
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_detailNameArray[indexPath.row] isEqual:@"전화번호"]) {
        NSLog(@"OK");
        NSString* phoneStr =[[NSString alloc] initWithFormat:@"tel://%@",_detailArray[indexPath.row]];
        NSLog(@"%@",phoneStr);
        NSURL* url =[NSURL URLWithString:phoneStr];
        [[UIApplication sharedApplication] openURL:url];
    }

    if ([_detailNameArray[indexPath.row] isEqual:@"사이트"]) {
        NSURL* url =[NSURL URLWithString:_detailArray[indexPath.row]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)scrollTabView:(FlickTabView *)scrollTabView didSelectedTabAtIndex:(NSInteger)index{
    if (index ==1) {
        [_tableView setHidden:true];
        [_mapView setHidden:false];
    }
    if (index == 0) {
        [_tableView setHidden:false];
        [_mapView setHidden:true];

    }
}


-(NSInteger)numberOfTabsInScrollTabView:(FlickTabView *)scrollTabView{
    
    return _tabBarArray.count;
}

-(NSString *)scrollTabView:(FlickTabView *)scrollTabView titleForTabAtIndex:(NSInteger)index{
    
    return _tabBarArray[index];
}

@end
