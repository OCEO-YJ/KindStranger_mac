//
//  DataBase.m
//  Foreigner
//
//  Created by Kim Daehyun on 2015. 1. 16..
//  Copyright (c) 2015년 dydwns628. All rights reserved.
//

#import "DataBase.h"
#import "FMDB.h"
#import "PhoneViewController.h"
#import "PhoneData.h"
#import "PhoneJson.h"

@interface DataBase ()
@property NSString *dbpath;

@end
@implementation DataBase

+(DataBase *)sharedDatabase{
    
    static DataBase *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //프로그램에서 딱 한번만 수행한다
        db = [[DataBase alloc] init];
        [db createTables];
        
//        PhoneJson* json = [[PhoneJson alloc] init];
//        [json phoneJson];
        
        
    });
    return db;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
        
        self.dbpath = [((NSString *)dirs[0])
                       stringByAppendingPathComponent:@"database.sqlite"];
        NSLog(@"%@",self.dbpath);
    }
    return self;
}



- (FMDatabase *)opendatabase{
    FMDatabase* db =[FMDatabase databaseWithPath:self.dbpath];
    if ([db open]==false) {
        NSLog(@"DataBase 로딩 실패");
        [db close];
        return NULL;
    }
    NSLog(@"DataBase 로딩 성공");
    return db;
}

-(void)createTables{
    FMDatabase *db = [self opendatabase]; if(db == nil) return;
    NSError* err;
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS phone (idx INTEGER PRIMARY KEY, state TEXT, title TEXT, subtitle TEXT, phone_number TEXT, category TEXT, content_idx INTEGER, last_update DATETIME)" withErrorAndBindings:&err];
    NSLog(@"Create Tables Error : %@",err);
    [db close];
}

-(void)idx:(long)idx state:(int)state phoneName:(NSString *)name subTitle:(NSString *)subName phoneNumber:(NSString *)number category:(NSString *)category updateTime:(NSString *)time{
    FMDatabase *db = [self opendatabase]; if(db == nil) return;
    
    NSError *err;
    NSLog(@"Insert Tables Error : %@",err);
    
    [db executeUpdate:@"INSERT OR REPLACE INTO phone (idx, state, title, subtitle, phone_number, category, last_update) VALUES (?,?,?,?,?,?,?)" withErrorAndBindings:&err,[NSNumber numberWithLong:idx],[NSNumber numberWithInt:state],name,subName,number,category,time];

    [db executeUpdate:@"DELETE FROM phone WHERE state = 0"];

    [db close];
    
}
-(NSString *)lastdate{
    FMDatabase* db = [self opendatabase]; if(db == nil) return nil;
    PhoneData* data = [[PhoneData alloc] init];
    FMResultSet* result = [db executeQuery:@"SELECT last_update FROM phone ORDER BY last_update DESC"];
    
    if ([result next]) {
        data.lastupdate = [result stringForColumn:@"last_update"];
    }
    return data.lastupdate;
}

-(NSArray *)phoneDataBaseLiving:(int)category {
    
    //FMDatabase를 db라 선언 하고 opendatabase 라는 자신의 함수를 초기화 한다. 만약에 db가 없다면 없다고 return 해라.
    FMDatabase *db = [self opendatabase]; if (db == nil) return nil;
    
    //이 MutableArray를 만들어서 데이터 베이스에서 불러온 값들을 여기다 밀어 넣을 것이다. 왜냐하면 나중의 while문이 한차례 끝나면 그 안에 있는 그릇들을 다시 사용할 수 없기 때문에 그 값들을 사용할려고 이 Array에 집어 넣어 그 값들을 Array로 이용해 사용할라고 만든다.
    NSMutableArray *list = [NSMutableArray array];
    
    //FMResultSet이라는 클래스를 result라 선언 하도 db의 쿼리 명령중 SELECT를 통해 ids, title, subtitle, phone_number, category, last_update를 phone이라는 데이터 베이스에서 불러온다.
    NSString *strCategory[] = {@"생활", @"긴급", @"교통"};
    FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT idx, title, subtitle, phone_number, category, last_update FROM phone Where category = '%@' ", strCategory[category]]];
    //만약 데이터 베이스를 잘 불러가지고 왔다면 계속 실행 시키자.(데이터 베이스의 값을 한줄 단위로 가지고 오기 때문에 while문으로 데이터베이스가 끝날때 까지 가지고 온다)

    while ([result next]) {
        
        NSLog(@"loading complete");
        PhoneData* data = [[PhoneData alloc] init];
        //굳이 전역으로 뺄 필요가 없다. (실적용)
        //데이터 베이스의 idx의 값이 전역으로 뺀 _idx의 그릇안에 집어 넣는다.(데이터베이스의 idx값을 바로 불러올 수 없으니 그 값을 _idx에 넣어 이것을 어레이에 집어 넣어 나중에 사용할려고 한다)
        //데이터 베이스의 title 값을 전역으로 뺀 _phoneName의 그릇 안에 집어 넣는다.
        data.phoneTitle = [result stringForColumn:@"title"];
        //데이터 베이스의 subtitle 값을 전역으로 뺀 _subTitle의 그릇 안에 집어 넣는다.
        data.phoneSubTitle = [result stringForColumn:@"subtitle"];
        //데이터 베이스의 phone_number 값을 전역으로 뺀 _phoneNumber의 그릇 안에 집어 넣는다.
        data.phoneNumber = [result stringForColumn:@"phone_number"];
        //데이터 베이스의 category 값을 전역으로 뺀 _category의 그릇 안에 집어 넣는다.
        data.phoneCategory = [result stringForColumn:@"category"];
        //데이터 베이스의 last_update 값을 전역으로 뺀 _updateTime의 그릇 안에 집어 넣는다.
        //        NSString *updateTime = [result stringForColumn:@"last_update"];
        //아까 만든 어레이에 위에 만든 그릇들의 값을 집어 넣는다. 왜냐하면 while문이 한번 끝나면 그 값들의 그릇을 다시 사용못해 값들을 제어 할 수 없기 때문에 list라는 어레이에 집어넣어서 그 값들을 나중에 제어 할려고 밀어 넣는다. 넣을때는 NSDictionary로 그 값들이 들어가는 공간의 이름을 붙여주면서 넣고 있다.
        [list addObject:data];
    }
    //While문이 끝나면 db를 닫는다.
    [db close];
    // 이 리턴 값은 _phoneArray 한테 던져 줄려고 리턴을 하는 것이다.
    return [NSArray arrayWithArray:list];
}
@end
