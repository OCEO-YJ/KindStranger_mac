//
//  ViewController.m
//  Foreigner
//
//  Created by dydwns628 on 2015. 1. 7..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

// "ViewController.h"를 참조
// [ViewController.h 파일에  _barButton을 선언 하였으므로 _barButton을 사용하기 위해서 ViewController.h 를 참조했어]
#import "ViewController.h"

// "SWRevealViewController.h"를 참조
// [다른 사람이 만늠 페이스북 메뉴를 내 어플에다가 사용할려고 "SWRevealViewController.h"을 참조한거야 헤더 파일을 통해 메서드 명령을 내릴려고]
#import "SWRevealViewController.h"

// "PhoneJson.h" 를 참조
// [처음 앱을 실행 시켰을때 Phone 데이터를 가져오기 위해서 PhoneJson.h를 참조 햇어 그래야 서버에 있는 데이터 베이스의 데이터 들을 가져올 수 있기 때문이야.]
#import "PhoneJson.h"

// "EducationJson.h" 를 참조
// [처음 앱을 실행 시켰을때 Education 데이터를 가져오기 위해서 EducationJson.h를 참조 헀어 그래야 서버에 있는 데이터 베이스의 데이터 들을 가져 올 수 있기 때문이야.]
#import "EducationJson.h"

//// "EducationDatabase.h" 를 참조
//#import "EducationDatabase.h"

// LABEL_HEIGHT이라는 이름으로 메크로를 생성 [30 사이즈]
// [메크로를 통해 라벨을 조금더 쉽게 사이즈를 정할려고 만든거야. 그리고 라벨 사이즈가 바뀌면 한번에 수정 할 수 있기 때문에 사용했어]
#define LABEL_HEIGHT 30

@interface ViewController ()

@end

@implementation ViewController

// 화면이 로딩되는 시점
- (void)viewDidLoad {
    
//    NSLog(@"여기 먼저 탄다");
    
    // 부모 뷰를 가져 온다. 일종의 클래스 메서드
    [super viewDidLoad];
    
    // 화면의 배경화면 색을 흰색으로 설정한다.
    // [바탕화면의 색을 흰색으로 해서 깔끔하게 했어]
    self.view.backgroundColor = [UIColor whiteColor];
    
    // ViewController.h에서 선언한 _barButton의 타켓을 revealViewController로 설정함
    // [_barButton의 타켓을 설정해야지 _barButton을 눌렀을때 어떤 뷰를 가져올지 알 수 있으니깐 설정한거야. 저 버튼을 눌렀으면 revealViewController를 참조하라는거지 즉 revealViewController를 불러오는 거지.
    _barButton.target = self.revealViewController;
    /*근데  revealViewController를 생성 및 할당을 안했는데 어떻개 불러 올 수 있는거지? 저게 메서드 인가? */
  
    //_barButton의 action을 revealToggle로 연결함.
    // [이렇게 액션을 연결해야 _barButton을 눌렀을 때 화면이 옆으로 나오는 Animation효과를 볼 수 있어
    _barButton.action = @selector(revealToggle:);
    
    // revealViewController의panGestureRecognizer를 현재 view의 제스쳐에 추가함.
    //[?]
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // main이라는 메서드 호출
    // [앱 화면에 불러올 각종 객체들을 따로 모아놔서 한번만 실핼 할려고 다 따로 모아뒀어. 그리고 보기 쉽잖아.]
    [self main];
    
    // EducationJson을 생성 및 할당
    // [EducationJson을 생성 및 할당 해야지 edicationJson 메서드를 실행 시킬 수 있으므로 생성 및 할당 한거야.]
    EducationJson* ed = [[EducationJson alloc] init];
    
    // educationJson 메서드를 실행 시킴
    // [그래야 education의 데이터를 불러 올 수 있어]
    [ed educationJson];

    // PhoneJson을 생성 및 할당
    // [PhoneJson을 생성 및 할당 해야지 PhoneJson 메서드를 실행 시킬 수 있으므로 생성 및 할당 한거야.]
    PhoneJson* json = [[PhoneJson alloc] init];
    
    // phoneJson 메서드를 실행 시킴
    // [그래야 phone의 데이터를 불러 올 수 있어]
    [json phoneJson];

    // 현재 바의 제목을 '친절한 이방인'이라고 해놨어.
    self.title = @"친절한 이방인";
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)main{
    
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    
    
    UILabel* appIntro = [[UILabel alloc] init];
    NSString* appIntroName = [NSString stringWithFormat:@"앱소개"];
    
    appIntro.text = appIntroName;
    appIntro.textColor = [UIColor blueColor];
    appIntro.textAlignment = NSTextAlignmentLeft;
    
    [appIntro setFrame:CGRectMake(20, 80, winsize.width, LABEL_HEIGHT)];
    
    [self.view addSubview:appIntro];
    
    UILabel* appIntro1 = [[UILabel alloc] init];
    NSString* appIntroName1 = [NSString stringWithFormat:@"한국에 사는 외국인 분들을 위한 앱입니다"];
    
    appIntro1.text = appIntroName1;
    appIntro1.textColor = [UIColor blackColor];
    appIntro1.textAlignment = NSTextAlignmentLeft;
    
    
    
    [appIntro1 setFrame:CGRectMake(20, appIntro.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
    [appIntro1 setFont:[UIFont systemFontOfSize:13]];
    
    [self.view addSubview:appIntro1];
    //////////////////////////////////////////////////////////////////////
    
    UILabel* appNotice = [[UILabel alloc] init];
    NSString* appNoticeName = [NSString stringWithFormat:@"공지사항"];
    
    appNotice.text = appNoticeName;
    appNotice.textColor = [UIColor blueColor];
    appNotice.textAlignment = NSTextAlignmentLeft;
    
    [appNotice setFrame:CGRectMake(20, appIntro1.frame.origin.y+50, winsize.width, LABEL_HEIGHT)];
    
    [self.view addSubview:appNotice];
    
    UILabel* appNotice1 =[[UILabel alloc] init];
    [appNotice1 setNumberOfLines:0];
    NSString* appNoticeName1 = [NSString stringWithFormat:@"상단 좌축메뉴를 눌러서 다양한 정보를 이용할 수 있습니다."];
    
    appNotice1.text = appNoticeName1;
    appNotice1.textColor = [UIColor blackColor];
    appNotice1.textAlignment = NSTextAlignmentLeft;
    
    [appNotice1 setFrame:CGRectMake(20, appNotice.frame.origin.y+20, winsize.width-45, LABEL_HEIGHT)];
    [appNotice1 sizeToFit];

    [appNotice1 setFont:[UIFont systemFontOfSize:13]];
    
    [self.view addSubview:appNotice1];
    //////////////////////////////////////////////////////////////////////
    
    UILabel* cafeLink = [[UILabel alloc] init];
    NSString* cafeLinkName = [NSString stringWithFormat:@"친절한 이방인 네이버카페"];
    
    cafeLink.text = cafeLinkName;
    cafeLink.textColor = [UIColor blueColor];
    cafeLink.textAlignment = NSTextAlignmentLeft;
    
    [cafeLink setFrame:CGRectMake(20, appNotice1.frame.origin.y+50, winsize.width, LABEL_HEIGHT)];
    
    [self.view addSubview:cafeLink];
    
    UILabel* cafeLink1 = [[UILabel alloc] init];
    NSString* cafeLinkName1 = [[NSString stringWithFormat:@"http://cafe.naver.com/texttour"] init];
    
    cafeLink1.text = cafeLinkName1;
    cafeLink1.textColor = [UIColor grayColor];
    
    
    [cafeLink1 setFont:[UIFont systemFontOfSize:13]];
    [cafeLink1 setFrame:CGRectMake(20, cafeLink.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
    
    UITapGestureRecognizer* link = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linktap:)];
    cafeLink1.userInteractionEnabled = YES;
    link.numberOfTapsRequired = 1;
    [cafeLink1 addGestureRecognizer:link];
    
    [self.view addSubview:cafeLink1];
}

- (void)linktap:(UITapGestureRecognizer *)count{
    NSString* link = [NSString stringWithFormat:@"http://cafe.naver.com/texttour"];
    NSURL* url =[NSURL URLWithString:link];
    [[UIApplication sharedApplication] openURL:url];
}

@end
