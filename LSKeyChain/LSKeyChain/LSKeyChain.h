//
//  LSKeyChain.h
//  LSKeyChain
//
//  Created by 李小帅 on 2017/6/26.
//  Copyright © 2017年 美好午后. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface LSKeyChain : NSObject

+(void)save:(NSString*)service data:(id)data;

+(id)load:(NSString*)service;

+(void)delete:(NSString*)service;

@end
