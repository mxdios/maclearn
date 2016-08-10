//
//  rootViewController.m
//  maclearn
//
//  Created by inspiry on 16/6/22.
//  Copyright © 2016年 inspiry. All rights reserved.
//

#import "rootViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor redColor].CGColor;
}

@end
