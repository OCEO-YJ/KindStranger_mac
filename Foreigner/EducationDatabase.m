//
//  EducationDatabase.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 25..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "EducationDatabase.h"
#import "FMDB.h"

@interface EducationDatabase ()
@property NSString *dbpath;
@end

@implementation EducationDatabase


+(EducationDatabase *)sharedDatabase{
    
    static EducationDatabase *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[EducationDatabase alloc] init];
        [db createTables];
        
    });
    return db;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        
        self.dbpath = [((NSString *)dirs[0]) stringByAppendingPathComponent:@"database.sqlite"];
        
        NSLog(@"%@",self.dbpath);
    }
    return self;
}

- (FMDatabase *) opendatabase {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbpath];
    if ([db open] ==false) {
        NSLog(@"Database 로딩 실패");
        [db close];
        return NULL;
    }
    NSLog(@"Database 로딩 성공");
    return db;
}


-(void)createTables{
    FMDatabase *db = [self opendatabase]; if(db ==nil) return;
    NSError* err;
    
    
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS education (idx INTEGER PRIMARY KEY, state TEXT, title TEXT, subtitle TEXT, category TEXT, summary TEXT, phone_number TEXT, fax_number TEXT, email TEXT, site_url TEXT, address TEXT, latlng TEXT, last_update DATETIME)" withErrorAndBindings:&err];
    NSLog(@"OK");
    NSLog(@"Create Tables Error : %@",err);
    [db close];
    
}

-(void)idx:(long)idx state:(int)state title:(NSString*)title subTitle:(NSString*)subTitle category:(NSString*)category summary:(NSString*)summary phoneNumber:(NSString*)phonNumber faxNumber:(NSString*)faxNumber email:(NSString*)email site:(NSString*)site address:(NSString*)adress latlng:(NSString*)latlng lastUpdate:(NSString*)lastupdate{
    
    FMDatabase *db = [self opendatabase]; if(db == nil) return;
    
    NSError *err;
    
    
    [db executeUpdate:@"INSERT OR REPLACE INTO education (idx,state,title,subtitle,category,summary,phone_number,fax_number,email,site_url,address,latlng,last_update) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)" withErrorAndBindings:&err,[NSNumber numberWithLong:idx],[NSNumber numberWithInt:state],title,subTitle,category,summary,phonNumber,faxNumber,email,site,adress,latlng,lastupdate];
    
    [db executeUpdate:@"DELETE FROM education WHERE state = 0"];
    

    
    NSLog(@"Insert Tables Error : %@",err);
    [db close];
    
}
-(NSString *)lastdate{
    
    FMDatabase* db = [self opendatabase]; if(db == nil) return nil;
    EducationData* data = [[EducationData alloc] init];
    FMResultSet* result = [db executeQuery:@"SELECT last_update FROM education ORDER BY last_update DESC"];

    
    if ([result next]) {
        data.lastupdate = [result stringForColumn:@"last_update"];
    }
    
    return data.lastupdate;
    
    
}
-(NSArray*)educationData:(int)category {
    
    FMDatabase* db = [self opendatabase]; if(db == nil) return nil;
    
    NSMutableArray *list = [NSMutableArray array];
    NSString* categoryList[] = {@"한국어",@"한식",@"생활문화",@"전통문화",@"학교"};
    
    FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT idx,title,subtitle,category FROM education Where category = '%@'",categoryList[category]]];
    
    NSLog(@"OK NEXT: 1");

    while ([result next]) {
        NSLog(@"OK NEXT: 2");

        EducationData* data = [[EducationData alloc]  init];
        
        data.title = [result stringForColumn:@"title"];
        data.subtitle = [result stringForColumn:@"subtitle"];
        data.category = [result stringForColumn:@"category"];
        data.idx = [result longForColumn:@"idx"];

        [list addObject:data];
    }
    
    [db close];
    return [NSArray arrayWithArray:list];
}

-(EducationData *)detail:(long)idx{
    FMDatabase* db = [self opendatabase]; if(db == nil) return nil;

    FMResultSet *detailResult = [db executeQuery:[NSString stringWithFormat:@"SELECT title,subtitle,category,summary,phone_number,fax_number,email,site_url,address,latlng FROM education Where idx = '%ld'",idx]];
    EducationData* data = [[EducationData alloc] init];


    if ([detailResult next]) {
        
        data.title = [detailResult stringForColumn:@"title"];
        data.subtitle = [detailResult stringForColumn:@"subtitle"];
        data.category = [detailResult stringForColumn:@"category"];
        data.summary = [detailResult stringForColumn:@"summary"];
        data.phoneNumber = [detailResult stringForColumn:@"phone_number"];
        data.faxNumber = [detailResult stringForColumn:@"fax_number"];
        data.email = [detailResult stringForColumn:@"email"];
        data.site = [detailResult stringForColumn:@"site_url"];
        data.address = [detailResult stringForColumn:@"address"];
        data.latlng = [detailResult stringForColumn:@"latlng"];
    }
    
    return data;
    
}

@end
