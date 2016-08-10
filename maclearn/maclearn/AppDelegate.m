//
//  AppDelegate.m
//  maclearn
//
//  Created by inspiry on 16/6/22.
//  Copyright © 2016年 inspiry. All rights reserved.
//

#import "AppDelegate.h"
#import "rootViewController.h"
#import "oneView.h"
#import "MyWindow.h"
@interface AppDelegate ()<NSTextFieldDelegate, NSTextViewDelegate>
{
    NSTimer *_timer;
    NSProgressIndicator *_progress;
}
@property (weak) IBOutlet NSTextField *username;
@property (weak) IBOutlet NSSecureTextField *password;
@property (unsafe_unretained) IBOutlet NSTextView *textview;
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSButton *cancelBtn;

@property (weak) IBOutlet NSWindow *window;

@property (strong, nonatomic) MyWindow *mywindow;

@property (strong, nonatomic) NSWindowController *myWindowController;
@end

@implementation AppDelegate
- (MyWindow *)mywindow
{
    if (!_mywindow) {
        NSRect frame = CGRectMake(0, 0, 200, 200);
        NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
        _mywindow = [[MyWindow alloc] initWithContentRect:frame styleMask:style backing:NSBackingStoreBuffered defer:YES];
        _mywindow.title = @"第二个window";
    }
    return _mywindow;
}
- (NSWindowController *)myWindowController
{
    if (!_myWindowController) {
        _myWindowController = [[NSWindowController alloc] init];
        self.mywindow.windowController = _myWindowController;
        _myWindowController.window = self.mywindow;
    }
    return _myWindowController;
}
/**
 *  启动前的初始化处理
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [[self.window standardWindowButton:NSWindowDocumentIconButton] setImage:[NSImage imageNamed:@"Image"]];

    oneView *oneV = [[oneView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    oneV.wantsLayer = YES;
    oneV.layer.backgroundColor = [NSColor greenColor].CGColor;
    [self.window.contentView addSubview:oneV];
    
    self.username.delegate = self;
    self.password.delegate = self;
    self.textview.delegate = self;
    self.textview.textColor = [NSColor redColor];
    self.textview.font = [NSFont systemFontOfSize:30];
    self.searchField.target = self;
    self.searchField.action = @selector(searchFieldChange:);
    
    self.cancelBtn.target = self;
    self.cancelBtn.action = @selector(cancelBtnClick:);
    
    NSButtonCell *searchBtn = [[self.searchField cell] searchButtonCell];
    searchBtn.target = self;
    searchBtn.action = @selector(searchBtnCikck:);
    NSButtonCell *cancelBtn = [[self.searchField cell] cancelButtonCell];
    cancelBtn.target = self;
    cancelBtn.action = @selector(cancelSearchBtnCikck:);
    
    
    NSTextField *label = [[NSTextField alloc] initWithFrame:CGRectMake(200, 0, 100, 20)];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setEditable:NO];
    label.stringValue = @"阿斯顿发烧级";
    [self.window.contentView addSubview:label];
    
//    rootViewController *root = [[rootViewController alloc] init];
//    self.window.contentViewController = root;
    
    NSButton *btn = [[NSButton alloc] initWithFrame:CGRectMake(200, 200, 100, 40)];
    btn.title = @"显示window";
    btn.bezelStyle = NSRoundedBezelStyle;
    [btn setButtonType:NSMomentaryLightButton];
    btn.target = self;
    btn.action = @selector(btnClick:);
    [self.window.contentView addSubview:btn];
    
    
    NSSegmentedControl *seg = [[NSSegmentedControl alloc] initWithFrame:CGRectMake(200, 100, 300, 40)];
    seg.segmentCount = 3;
    seg.selectedSegment = 0;
    [seg setLabel:@"第一个" forSegment:0];
    [seg setLabel:@"第二个" forSegment:1];
    [seg setLabel:@"第三个" forSegment:2];
    [self.window.contentView addSubview:seg];
    
    NSPopUpButton *pop = [[NSPopUpButton alloc] initWithFrame:CGRectMake(200, 150, 150, 40) pullsDown:YES];
//    pop
    [pop addItemsWithTitles:@[@"item1", @"item2",@"item3",@"item4"]];
    [self.window.contentView addSubview:pop];
    
    
    NSDatePicker *datePicker = [[NSDatePicker alloc] initWithFrame:CGRectMake(400, 100, 400, 200)];
    datePicker.datePickerStyle = NSTextFieldDatePickerStyle;
    datePicker.backgroundColor = [NSColor redColor];
    datePicker.target = self;
    datePicker.action = @selector(datePickerChange:);
    datePicker.dateValue = [NSDate date];
    [self.window.contentView addSubview:datePicker];
    
    
    _progress = [[NSProgressIndicator alloc] initWithFrame:CGRectMake(400, 200, 400, 40)];
    _progress.style = NSProgressIndicatorBarStyle;
    _progress.doubleValue = 0;
    _progress.minValue = 0;
    _progress.maxValue = 100;
    _progress.indeterminate = NO;
    [_progress startAnimation:self];
    [self.window.contentView addSubview:_progress];
    
    
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    }
}
- (void)progressChange
{
    _progress.doubleValue += 1;
    if (_progress.doubleValue == 100) {
        [_timer invalidate];
        [_progress stopAnimation:self];
        
    }
    NSLog(@"timer");
}
- (void)datePickerChange:(NSDatePicker *)datePicker
{
    NSLog(@"时间变化 = %@", datePicker.dateValue);
}
- (void)btnClick:(NSButton *)btn
{
//    [self.mywindow makeKeyAndOrderFront:self];
    [self.myWindowController showWindow:nil];
}
- (void)searchBtnCikck:(NSButtonCell *)buttonCell
{
    NSLog(@"搜索");
}
- (void)cancelSearchBtnCikck:(NSButtonCell *)buttonCell
{
    NSLog(@"清空");
    
}

- (void)searchFieldChange:(NSSearchField *)searchField
{
    NSLog(@"开始搜索 = %@", searchField.stringValue);
}
- (void)cancelBtnClick:(NSButton *)btn
{
    NSLog(@"点击事件");
}

- (IBAction)okBtnCilck:(NSButton *)sender {
    NSLog(@"点击ok = %@ = %@", self.username.stringValue, self.password.stringValue);
    NSLog(@"textview = %@", self.textview.string);
}
/**
 *  开始编辑
 */
- (void)controlTextDidBeginEditing:(NSNotification *)obj
{
    id tex = obj.object;
    if (tex == self.username) {
        NSLog(@"username= %@",self.username.stringValue);
    } else if (tex == self.password) {
        NSLog(@"password= %@",self.password.stringValue);
    }
}
/**
 *  编辑中
 */
- (void)controlTextDidChange:(NSNotification *)obj
{
    id tex = obj.object;
    if (tex == self.username) {
        NSLog(@"change username= %@",self.username.stringValue);
    } else if (tex == self.password) {
        NSLog(@"change password= %@",self.password.stringValue);
    }
}
/**
 *  结束编辑
 */
- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    id tex = obj.object;
    if (tex == self.username) {
        NSLog(@"end username= %@",self.username.stringValue);
    } else if (tex == self.password) {
        NSLog(@"end password= %@",self.password.stringValue);
    }
}
- (BOOL)textShouldBeginEditing:(NSText *)textObject
{
    NSLog(@"%@", textObject.string);
    return YES;
}

/**
 *  退出前做出数据处理
 */
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    NSLog(@"关闭");
}

@end
