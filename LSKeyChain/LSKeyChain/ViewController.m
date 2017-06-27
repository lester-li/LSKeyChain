//
//  ViewController.m
//  LSKeyChain
//
//  Created by 李小帅 on 2017/6/26.
//  Copyright © 2017年 美好午后. All rights reserved.
//

#import "ViewController.h"
#import "LSKeyChain.h"

#define PASSWORD @"password"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *password = @"这是一个密码";
    [LSKeyChain save:PASSWORD data:@{@"key":password}];
    
    NSLog(@" -----%@------",[((NSDictionary*)[LSKeyChain load:PASSWORD]) objectForKey:@"key"]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
