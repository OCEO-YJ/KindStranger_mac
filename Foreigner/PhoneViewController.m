//
//  PhoneViewController.m
//  Foreigner
//
//  Created by dydwns628 on 2015. 1. 7..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "PhoneViewController.h"
#import "SWRevealViewController.h"
#import "PhoneTableViewCell.h"
#import "DataBase.h"
@interface PhoneViewController ()

@end

@implementation PhoneViewController

/*화면 붙이기 전*/
- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor blackColor];
    _db =[DataBase sharedDatabase];
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Do any additional setup after loading the view.
    
    _tabView = [[FlickTabView alloc] initWithFrame:CGRectMake(0.0f, winsize.height-43.0f, winsize.width, 43.0f)];//크기
    _tabView.delegate =self;
    _tabView.dataSource =self;
    [self.view addSubview:_tabView];
    _phoneArray = [_db phoneDataBaseLiving:0];
    _tableView.rowHeight = 53;
    
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(tabView.frame), 0.0f);


    
    //데이터 베이스의 값을 함수를 통해 결과 값을 배열로 내가 받을 수 있게 phoneDataase를 만들었는데 그 함수 안의 값들을 사용하기 위해 배열형태로 만들었으므로 그 값들을 제어 하기 위해서는 새로운 어레이로 받고 있다. 또한 이 함수를 직접 사용 할 수 없기 때문에 가공 한것이다? 그리고 이렇게 배열안에 넣어서 셀의 갯수, 배열 안에 있는 값들을 사용할려고 만든것이다.
    
}

/*화면 붙인 후*/
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"ds");
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    _tableView.frame = CGRectMake(0, 0, winsize.width,_tabView.frame.origin.y);

}

-(void)scrollTabView:(FlickTabView *)scrollTabView didSelectedTabAtIndex:(NSInteger)index{
    // 카테고리 index 번호를 보내 해당 카테고리의 데이터를 가져오도록 합니다.
    _phoneArray = [_db phoneDataBaseLiving:(int)index];
    // 가져온 카테고리 데이터를 새롭게 화면에 출력하도록 갱신합니다.
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _phoneArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //*** static으로 함수가 끝나도 죽지 않는 NSString으로 phoneIdentifier를 선언 및 초기화를 한다.
    // item 이라는 NSString을 만들어서 나중에 테이블 셀이 만들어져 있냐라고 테이블뷰가 식별 할때 사용할려고 만듬.
    static NSString* phoneIdentifier = @"item";
    
    //*** PhoneTableViewCell이라는 클래스를 cell이라고 만들어 Table에 붙이기 전 PhoneIdentifier이라는 아이덴티를 선언한다.
    
    // phoneIdentifier이라는 식별을 가지고 있는 셀이 만들어져 있는지 없는지 식별할려고 한다.
    PhoneTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:phoneIdentifier];
    
    //만약에 Table Cell이 없다면 이 if문을 탄다.
    // 위에서 만약에 셀이 없다면 셀을 만들려고 해.
    if (cell == nil) {
        
        //*** 아까 선언한 cell을 테이블에 붙이는 과정이다. (아까 만든 아이덴티랑 동일하게 해서 만든다.)
        // 셀이 없는 경우에 이 if문을 탔으니 셀을 만들어야 한다. 그래서 셀이 없을때 셀을 만들려고 이 코드를 작성했다.
       cell = [[PhoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:phoneIdentifier];
    }
    
//    NSLog(@"COUNT :%lu",(unsigned long)_phoneArray.count);

    PhoneData* data =_phoneArray[indexPath.row];
//    NSLog(@"phone %@",data.phoneTitle);

//
////    NSIndexPath* path = [[NSIndexPath alloc] initWithIndex:indexPath.row];
//    _data =_phoneArray[path.row];
//
        cell.title.text =data.phoneTitle;
        cell.subTitle.text = data.phoneSubTitle;
        cell.phoneNumber.text = data.phoneNumber;
        cell.phoneCategory.text = data.phoneCategory;




//    //*** cell클래스 안에 있는 title의 텍스트 = _phoneArray에 Table의 줄 번호 방의 PhoneName의 방이름 안에 있는 텍스트
//    /*셀 안에 데이터 베이스의 전화번호 제목을 셀안에 표기할려고 한다. 그래서 미리 셀클래스에 타이틀이라는 녀석을 만들어 위치를 선정해 준다음 그 제목안에
//     데이터 베이스의 전화번호 제목을 넣어 주는것이다. */
//    cell.title.text =data.phoneTitle;
//    //*** cell클래스 안에 있는 subTitle의 텍스트 = _phoneArray에 Table의 줄 번호 방의 SubTitle의 방이름 안에 있는 텍스트
///
//    //*** cell클래스 안에 있는 phoneNumber의 텍스트 = _phoneArray에 Table의 줄 번호 방의 PhoneNumber의 방이름 안에 있는 텍스트
//    cell.phoneNumber.text = data.phoneNumber;
//
//    cell.phoneCategory.text = data.phoneCategory;
    //*** 함수에 (UITableViewCell*)을 리턴해달라고 해서 아까 만든 테이블 뷰 셀을 리턴해준다.
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhoneData* data =_phoneArray[indexPath.row];
    
    NSString* phoneStr = [[NSString alloc] initWithFormat:@"tel://%@",data.phoneNumber];
    NSURL* url =[NSURL URLWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:url];

 }

-(NSInteger)numberOfTabsInScrollTabView:(FlickTabView *)scrollTabView{
    
    return 3;
}

-(NSString *)scrollTabView:(FlickTabView *)scrollTabView titleForTabAtIndex:(NSInteger)index{
    
    NSString* title[] ={@"생활", @"긴급", @"교통"};
    return title[index];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
