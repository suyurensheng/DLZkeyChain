//
//  DLZKeyChain.m
//  Test
//
//  Created by 董力祯 on 15/5/5.
//  Copyright (c) 2015年 董力祯. All rights reserved.
//

#import "DLZKeyChain.h"

@implementation DLZKeyChain

+(NSMutableDictionary*)getKeyChainWithName:(NSString*)keyName{

    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,keyName,(__bridge_transfer id)kSecAttrService,keyName,(__bridge_transfer id)kSecAttrAccount,(__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible, nil];

}
+(void)saveData:(id)data forName:(NSString *)keyNmae{

    NSMutableDictionary *keyChainQuery=[self getKeyChainWithName:keyNmae];
    SecItemDelete((__bridge_retained CFDictionaryRef)keyChainQuery);
    [keyChainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    SecItemAdd((__bridge_retained CFDictionaryRef)keyChainQuery, NULL);
}
+(id)readDataWithName:(NSString *)keyName{

    id data=nil;
    NSMutableDictionary *keyChainQuery=[self getKeyChainWithName:keyName];
    [keyChainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keyChainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData=NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keyChainQuery,(CFTypeRef*)&keyData)==noErr) {
        @try {
            data=[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData*)keyData];
        }
        @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@",keyName,exception);
        }
        @finally {
        }
    }
    return data;
}
+(void)deleteDataWithName:(NSString *)keyName{

    NSMutableDictionary *keychainQuery=[self getKeyChainWithName:keyName];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}
@end
