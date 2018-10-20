//
//  InformationViewController.m
//  Foreigner
//
//  Created by dydwns628 on 2015. 1. 7..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "InformationViewController.h"
#import "SWRevealViewController.h"


#define LABEL_HEIGHT 30

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    
    /* TabView */
    // TabView 생성 - 하단배치
    FlickTabView* tabView = [[FlickTabView alloc] initWithFrame:CGRectMake(0.0f, winsize.height-43.0f, winsize.width, 43.0f)];//크기
    // 데이터 호출 메서드 위치 지정.
    tabView.delegate = self;
    tabView.dataSource = self;
    // 화면에 적용
    [self.view addSubview:tabView];
    /* TabView End */

    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.informationView = [[UIView alloc] init];
    [self.informationView setFrame:CGRectMake(0, 0,winsize.width,winsize.height-tabView.bounds.size.height)];
    self.informationView.backgroundColor = [UIColor whiteColor];
    
    UILabel* credit = [[UILabel alloc] init];
    NSString* creditName = [NSString stringWithFormat:@"CREDIT"];
    
    credit.text = creditName;
    credit.textColor = [UIColor blueColor];
    credit.textAlignment = NSTextAlignmentLeft;
    
    [credit setFrame:CGRectMake(20, 80, winsize.width, LABEL_HEIGHT)];
    
    [self.informationView addSubview:credit];
    
    UILabel* team = [[UILabel alloc] init];
    NSString* teamName = [NSString stringWithFormat:@"Onwing Team(온나래)"];
    
    team.text = teamName;
    team.textColor = [UIColor grayColor];
    team.textAlignment = NSTextAlignmentLeft;
    
    [team setFrame:CGRectMake(20, credit.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
    [team setFont:[UIFont systemFontOfSize:14.5]];
    
    [self.informationView addSubview:team];
    
    UILabel* cafeLink1 = [[UILabel alloc] init];
    NSString* cafeLinkName1 = [[NSString stringWithFormat:@"http://cafe.naver.com/texttour"] init];
    
    cafeLink1.text = cafeLinkName1;
    cafeLink1.textColor = [UIColor lightGrayColor];
    
    
    [cafeLink1 setFont:[UIFont systemFontOfSize:13]];
    [cafeLink1 setFrame:CGRectMake(20, team.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
    
    UITapGestureRecognizer* link = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linktap:)];
    cafeLink1.userInteractionEnabled = YES;
    link.numberOfTapsRequired = 1;
    [cafeLink1 addGestureRecognizer:link];
    
    [self.informationView addSubview:cafeLink1];
    
    UILabel* developerAndDesigner = [[UILabel alloc] init];
    NSString* developerAndDesignerName = [NSString stringWithFormat:@"DEVELOPER & DESIGNER"];
    
    developerAndDesigner.text = developerAndDesignerName;
    developerAndDesigner.textColor = [UIColor blueColor];
    developerAndDesigner.textAlignment = NSTextAlignmentLeft;
    
    [developerAndDesigner setFrame:CGRectMake(20, cafeLink1.frame.origin.y+50, winsize.width, LABEL_HEIGHT)];
    
    [self.informationView addSubview:developerAndDesigner];
    
    UILabel* me = [[UILabel alloc] init];
    NSString* meName = [NSString stringWithFormat:@"Oh Yong Joon"];
    
    me.text = meName;
    me.textColor = [UIColor grayColor];
    me.textAlignment = NSTextAlignmentLeft;
    
    [me setFrame:CGRectMake(20, developerAndDesigner.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
    [me setFont:[UIFont systemFontOfSize:14.5]];
    
    [self.informationView addSubview:me];
    
    UILabel* support = [[UILabel alloc] init];
    NSString* supportName = [NSString stringWithFormat:@"SUPPORT"];
    
    support.text = supportName;
    support.textColor = [UIColor blueColor];
    support.textAlignment = NSTextAlignmentLeft;
    
    [support setFrame:CGRectMake(20, me.frame.origin.y+50, winsize.width, LABEL_HEIGHT)];
    
    [self.informationView addSubview:support];
    
    UILabel* worldCityBook = [[UILabel alloc] init];
    NSString* worldCityBookName = [NSString stringWithFormat:@"World City Book"];
    
    worldCityBook.text = worldCityBookName;
    worldCityBook.textColor = [UIColor grayColor];
    worldCityBook.textAlignment = NSTextAlignmentLeft;
    
    [worldCityBook setFrame:CGRectMake(20, support.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
    [worldCityBook setFont:[UIFont systemFontOfSize:14.5]];
    
    [self.informationView addSubview:worldCityBook];
    
    UILabel* bookLink = [[UILabel alloc] init];
    NSString* bookLinkName = [[NSString stringWithFormat:@"http://blog.naver.com/web2010"] init];
    
    bookLink.text = bookLinkName;
    bookLink.textColor = [UIColor lightGrayColor];
    
    
    [bookLink setFont:[UIFont systemFontOfSize:13]];
    [bookLink setFrame:CGRectMake(20, worldCityBook.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
    
    UITapGestureRecognizer* link1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linktap1:)];
    bookLink.userInteractionEnabled = YES;
    link1.numberOfTapsRequired = 1;
    [bookLink addGestureRecognizer:link1];
    
    [self.informationView addSubview:bookLink];
    

    
    [self.view addSubview:self.informationView];
    
    
    self.updateView = [[UIView alloc] init];
    [self.updateView setFrame:CGRectMake(0, 0, winsize.width, winsize.height-tabView.bounds.size.height)];
    self.updateView.backgroundColor = [UIColor whiteColor];
    
        UILabel* version = [[UILabel alloc] init];
        NSString* versionName = [NSString stringWithFormat:@"Version 0.8"];
    
        version.text = versionName;
        version.textColor = [UIColor blackColor];
        version.textAlignment = NSTextAlignmentLeft;
    
        [version setFrame:CGRectMake(20, 80, winsize.width, LABEL_HEIGHT)];
    
        [self.updateView addSubview:version];
    
        UILabel* version1 = [[UILabel alloc] init];
        NSString* version1Name = [NSString stringWithFormat:@"- 첫 공개 버전"];
    
        version1.text = version1Name;
        version1.textColor = [UIColor grayColor];
        version1.textAlignment = NSTextAlignmentLeft;
    
        [version1 setFont:[UIFont systemFontOfSize:14.5]];
        [version1 setFrame:CGRectMake(20, version.frame.origin.y+20, winsize.width, LABEL_HEIGHT)];
        
        [self.updateView addSubview:version1];
    
        [self.view addSubview:self.updateView];
        [self.updateView setHidden:true];
}

/* TabView Method */
- (void)scrollTabView:(FlickTabView*)scrollTabView didSelectedTabAtIndex:(NSInteger)index {
    if (index==0) {
        [self.updateView setHidden:true];
        [self.informationView setHidden:false];
    }
    else{
        [self.informationView setHidden:true];
        [self.updateView setHidden:false];
    }
}

- (NSInteger)numberOfTabsInScrollTabView:(FlickTabView*)scrollTabView {
    return 2;
}

- (NSString*)scrollTabView:(FlickTabView*)scrollTabView titleForTabAtIndex:(NSInteger)index {
    NSString *tabName[] = {@"정보", @"업데이트"};
    return tabName[index];
}
/* TabView Method */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)linktap:(UITapGestureRecognizer *)count{
    NSString* link = [NSString stringWithFormat:@"http://cafe.naver.com/texttour"];
    NSURL* url =[NSURL URLWithString:link];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)linktap1:(UITapGestureRecognizer *)count{
    NSString* link = [NSString stringWithFormat:@"http://blog.naver.com/web2010"];
    NSURL* url =[NSURL URLWithString:link];
    [[UIApplication sharedApplication] openURL:url];
}

@end
