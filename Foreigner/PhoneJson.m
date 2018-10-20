//
//  PhoneJson.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 18..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "PhoneJson.h"

@implementation PhoneJson


- (void)phoneJson{
    DataBase* db = [DataBase sharedDatabase];

    int date;
    if (!([db lastdate]==nil)) {
        date = 0;
    }
    else{
        date = 1;
    }
    NSString* lastDate = [db lastdate];
    
    // 1. NSDate로 변경하기
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date2 = [dateFormat dateFromString:lastDate];
    
    // 2. 원하는 문자열 얻기
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    lastDate = [dateFormat stringFromDate:date2];
    
    // 서버에서 가져올 API(데이터)의 주소
    NSString *strUrl[2] = {[NSString stringWithFormat:@"http://stranger.onwing.co.kr/api/?m=phone&d=%@",lastDate],@"http://stranger.onwing.co.kr/api/?m=phone"};

    
    // 서버에서 가져올 API(데이터)의 주소
//    NSString *strUrl = @"http://stranger.onwing.co.kr/api/?m=phone";
    
    // 문자열로 되어있는 주소를 객체로 전환
    NSURL *urlJson = [NSURL URLWithString:strUrl[date]];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:urlJson];
    
    [request setTimeoutInterval:30];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (data != nil && error == nil)
        {
            
            // data
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSLog(@"Json : %@",json);
            
            NSArray* jsonPhoneData = json[@"items"];
            
            
            for (int i = 0; i<jsonPhoneData.count; i++) {
                NSDictionary* item = jsonPhoneData[i];
                
                [db idx:((NSNumber*)item[@"idx"]).intValue state:((NSNumber*)item[@"state"]).intValue phoneName:item[@"title"] subTitle:item[@"subtitle"] phoneNumber:item[@"phone_number"] category:item[@"category"] updateTime:item[@"last_update"]];
                
                
                
            }

            
        }
        else
        {
            NSLog(@"%@",error);
        }
        
    }];
}
@end
