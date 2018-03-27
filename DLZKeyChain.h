//
//  DLZKeyChain.h
//  Test
//
//  Created by 董力祯 on 15/5/5.
//  Copyright (c) 2015年 董力祯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLZKeyChain : NSObject

+(void)saveData:(id)data forName:(NSString*)keyNmae;

+(id)readDataWithName:(NSString*)keyName;

+(void)deleteDataWithName:(NSString*)keyName;
@end
