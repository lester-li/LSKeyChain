//
//  LSKeyChain.m
//  LSKeyChain
//
//  Created by 李小帅 on 2017/6/26.
//  Copyright © 2017年 美好午后. All rights reserved.
//

#import "LSKeyChain.h"

@implementation LSKeyChain

+(NSMutableDictionary*)getKeyChainQuery:(NSString*)service{
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(id)kSecClassGenericPassword,(id)kSecClass,service,(id)kSecAttrService , service , (id)kSecAttrAccount , (id)kSecAttrAccessibleAfterFirstUnlock , (id)kSecAttrAccessible, nil];
}

+(void)save:(NSString*)service data:(id)data{
    //获取要存储的字典
    NSMutableDictionary *keyChainDic = [self getKeyChainQuery:service];

    SecItemDelete((CFDictionaryRef)keyChainDic);
    
    [keyChainDic setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    SecItemAdd((CFDictionaryRef) keyChainDic, NULL);
}

+(id)load:(NSString*)service{
    id ret = nil;
    
    NSMutableDictionary *keyChainDic = [self getKeyChainQuery:service];
    [keyChainDic setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChainDic setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((CFDictionaryRef)keyChainDic, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
            
        }
    }
    if (keyData)
        CFRelease(keyData);
    
    return ret;
}

+(void)delete:(NSString*)service{
    NSMutableDictionary *keyChainDic = [self getKeyChainQuery:service];
    
    SecItemDelete((CFDictionaryRef)keyChainDic);
}

@end
