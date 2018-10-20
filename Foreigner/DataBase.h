//
//  DataBase.h
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 16..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBase : NSObject

@property NSNumber *idx;
@property NSString *phoneName;
@property NSString *subTitle;
@property NSString *phoneNumber;
@property NSString *category;
@property NSString *updateTime;

+(DataBase *)sharedDatabase;
-(NSArray *)phoneDataBaseLiving:(int)category;
-(void)createTables;
-(void)idx:(long)idx state:(int)state phoneName:(NSString *)name subTitle:(NSString *)subName phoneNumber:(NSString *)number category:(NSString *)category updateTime:(NSString *)time;
-(NSString*)lastdate;

@end
