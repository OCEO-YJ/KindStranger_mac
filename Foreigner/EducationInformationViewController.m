
//
//  EducationInformationViewController.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 18..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "EducationInformationViewController.h"
#import "SWRevealViewController.h"
#import "EducationTableViewCell.h"
#import "EducationDatabase.h"
#import "EducationData.h"
#import "EducationDetailViewController.h"

@interface EducationInformationViewController ()
@end

@implementation EducationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*현재 Iphone Screen 사이즈 가지고 오기*/
    CGSize winsize = [UIScreen mainScreen].bounds.size;


    /*Education_DB 생성*/
    _db = [EducationDatabase sharedDatabase];
    
    /*BarButton Target & Action reveal이랑 연동*/
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    /*Flick_Tab 생성 및 delegate, datasource (self)로 맞추고 화면에 붙힘*/
    _tabView = [[FlickTabView alloc] initWithFrame:CGRectMake(0.0f, winsize.height-43.0f, winsize.width, 43.0f)];
//    _tabView.delegate = self;
//    _tabView.dataSource = self;
//    [self.view addSubview:_tabView];
    
    /*Table View의 줄 높이 설정*/
    self.tableView.rowHeight = 53;
    
    /*_educationArray(NSArray)에 0번(한국어)정보를 담는다*/
    _educationArray = [_db educationData:0];
    
    /*Flick_Tab에서 Tab내의 제목, 타이틀 갯수를 설정 / 처음 Flick_Tab에 나타낼 정보*/
    _nameArray = [[NSMutableArray alloc] initWithObjects:@"한국어",@"한식",nil];
    /*Flick_Tab 시점을 처음에 위의 메뉴가 보이도록 reload*/
    [_tabView reloadData];


}
-(void)viewDidAppear:(BOOL)animated{
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    _tableView.frame = CGRectMake(0, 0, winsize.width, _tabView.frame.origin.y);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewDidLayoutSubviews{
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    _tableView.frame = CGRectMake(0, 0, winsize.width, _tabView.frame.origin.y);

}

/*Table View의 줄 갯수 설정 = _educatoinArray안의 내용물 만큼*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _educationArray.count;
    
}


/*Table View의 내의 셀 생성 및 샐 처음 내용 설정*/
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSString* educationIdentifier =@"Education";
    
    EducationTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Education"];
    
    if (cell == nil) {
        cell = [[EducationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Education"];
    }
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    
    _data = _educationArray[indexPath.row];
    cell.title.text = _data.title;

    cell.subTitle.frame = CGRectMake(20, cell.title.frame.origin.y+22, winsize.width-20, 20);
    
        [cell.subTitle setNumberOfLines:0];

        cell.subTitle.text = _data.subtitle;
        [cell.subTitle sizeToFit];
    
        cell.category.text = _data.category;

    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EducationTableViewCell* cell = [[EducationTableViewCell alloc] init];
    _data = _educationArray[indexPath.row];
    

    cell.title.text = _data.title;
    [cell.subTitle setNumberOfLines:0];
    cell.subTitle.text = _data.subtitle;
    [cell.subTitle sizeToFit];
    
    cell.category.text = _data.category;

    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell.title.frame.size.height + cell.subTitle.frame.size.height + 7 * 2;
}

/*Flick_Tab의 Tab안에 Title을 표현할 갯수 설정*/
-(NSInteger)numberOfTabsInScrollTabView:(FlickTabView *)scrollTabView{

    return _nameArray.count;
    
}


/*Flick_Tab의 Tab안에 Title을 설정*/
-(NSString *)scrollTabView:(FlickTabView *)scrollTabView titleForTabAtIndex:(NSInteger)index{
    
    return _nameArray[index];
    
}


/*Flick_Tab의 Tab을 클릭 했을때의 변화 설정(Title의 index로 Database정보 다르게 가져옴)*/
-(void)scrollTabView:(FlickTabView *)scrollTabView didSelectedTabAtIndex:(NSInteger)index{
    
        _educationArray = [_db educationData:(int)index];
    [self viewDidAppear:false];
    
        [_tableView reloadData];

}


/*Table View안의 Cell을 클릭시 변화 설정(각 Cell의 정보를 보여줌)*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _data = _educationArray[indexPath.row];
    _data =[_db detail:_data.idx];


    EducationDetailViewController* detail = [[EducationDetailViewController alloc] initWithData:_data];
    
//    EducationDetailViewController* detail = [storyboard instantiateViewControllerWithIdentifier:@"EducationDetailViewController"];

    
    [self.navigationController pushViewController:detail animated:false];
//    [self detailView:true];


}

@end
