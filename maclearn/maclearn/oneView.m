//
//  oneView.m
//  maclearn
//
//  Created by inspiry on 16/6/22.
//  Copyright © 2016年 inspiry. All rights reserved.
//

#import "oneView.h"

@implementation oneView
- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor blueColor] setFill];
    NSBezierPath *rounded = [NSBezierPath bezierPath];
    [rounded appendBezierPathWithRoundedRect:self.bounds xRadius:self.frame.size.width * 0.5 yRadius:self.frame.size.width * 0.5];
    [rounded fill];
}

@end
