//
//  MyWindow.m
//  maclearn
//
//  Created by inspiry on 16/7/5.
//  Copyright © 2016年 inspiry. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    return [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
}

- (void)makeKeyWindow
{
    [super makeKeyWindow];
}

- (void)orderFront:(id)sender
{
    [super orderFront:sender];
}
- (void)dealloc
{
    NSLog(@"mywindow dealloc");
}
@end
