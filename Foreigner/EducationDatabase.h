//
//  EducationDatabase.h
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 25..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"EducationData.h"

@interface EducationDatabase : NSObject

+(EducationDatabase *)sharedDatabase;
-(void)createTables;
-(void)idx:(long)idx state:(int)state title:(NSString*)title subTitle:(NSString*)subTitle category:(NSString*)category summary:(NSString*)summary phoneNumber:(NSString*)phonNumber faxNumber:(NSString*)faxNumber email:(NSString*)email site:(NSString*)site address:(NSString*)adress latlng:(NSString*)latlng lastUpdate:(NSString*)lastupdate;
-(NSArray*)educationData:(int)category;
- (EducationData *)detail:(long)idx;
-(NSString*)lastdate;

@end
