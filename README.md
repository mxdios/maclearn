# maclearn
mac应用开发学习-oc

## 第一个mac应用开发学习记录

## xcode开发Mac应用时一些特殊设置

1. .xib中window窗口 的属性栏，title字段标识window的标题， Appearance 里面的Title Bar取消选择，window窗口则不显示标题了

2. 同样属性栏里的 Appearance 里面的Visible At Launch 取消选中，应用启动窗口不显示，只有顶部菜单。手动代码显示
	
	```Objective-C
	- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	    // Insert code here to initialize your application 
	    [self.window makeKeyAndOrderFront:self];
	}
	```

3. targets -> General 里的Identity 比iOS开发多了Application Category， 这个额是应用的分类，提交到MacAppStore必须要选择这个分类

4. targets -> Capabilities 里面 App Sandbox 沙盒，app上家必须使用沙盒，必须打开。 如果要访问服务器api接口必须勾选Outgoing Connections， Hardware里面必须勾线Printing，否则不能通过审核。 如果要访问本地文件，User Selected File 需要选择读写权限

5. Info -> Document Types 设置应用跟文件的关联，指定格式文件用此应用打开，鼠标右键出现此应用

6. 使用里非系统的第三方framework， Build Setting -> Other Code Signing Flags 必须设置为 --deep, 否则无法打包发布应用


## 窗口视图编辑

1. 窗口通知
		
	```Objective-C
	NSWindowDidBecomeKeyNotification //窗口成为keyWindow
	NSWindowDidResignKeyNotification //窗口不再是keyWindow
	NSWindowDidBecomeMainNotification //窗口成为mainWindow
	NSWindowDidResignMainNotification //窗口不再是mainWindow
	NSWindowWillMoveNotification //窗口移动
	NSWindowDidResizeNotification //窗口大小改变
	NSWindowWillCloseNotification //关闭窗口
	```
2. NSWindow的contentView 是window的根视图，自定义view添加到window上时，要添加到contentView上。类似iOS中的UITableviewCell

3. NSView的属性设置：视图没有提供背景色、边框等属性，需要在layer层面上设置。设置之前必须将wantsLayer设置为yes
	
	```Objective-C	
	self.wantsLayer = YES;
	```

## 基本控件

### NSTextField

1. 普通输入框 NSTextField    密码输入框 NSSecureTextField

2. NSTextField 的内容的读写两个属性：普通文本信息 stringValue 和 富文本信息 attributedStringValue。 例如：获取输入框内的内容 self.textfield.stringValue

3. NSTextField的几个代理方法

	```Objective-C
	/** 开始编辑 */
	- (void)controlTextDidBeginEditing:(NSNotification *)obj
	/** 编辑中 */
	- (void)controlTextDidChange:(NSNotification *)obj
	/** 结束编辑 */
	- (void)controlTextDidEndEditing:(NSNotification *)obj
	```
### NSTextView

1. 控件拖NSTextView的时候，拖进去的有三层，最外层是ScrollView， 里面是ClipView，再里面才是TextView

2. 获取textview的内容，self.textview.string

### NSSearchField

1. 搜索输入框添加事件响应，用户在输入框中输入时，就会响应方法
		
	```Objective-C
	//代码添加响应方法, button控件也是这样添加的
	self.searchField.target = self;
	self.searchField.action = @selector(searchFieldChange:);
	
	- (void)searchFieldChange:(NSSearchField *)searchField {
		NSLog(@"开始搜索 = %@", searchField.stringValue);
	}
	```
		
2. 手动添加搜索输入框里的放大镜和清空按钮的点击事件。
	
	```Objective-C
	NSButtonCell *searchBtn = [[self.searchField cell] searchButtonCell];
	searchBtn.target = self;
	searchBtn.action = @selector(searchBtnCikck:);
	NSButtonCell *cancelBtn = [[self.searchField cell] cancelButtonCell];
	cancelBtn.target = self;
	cancelBtn.action = @selector(cancelBtnClick:);
	    
	- (void)searchBtnCikck:(NSButtonCell *)buttonCell
	{
	    NSLog(@"搜索");
	}
	- (void)cancelBtnClick:(NSButtonCell *)buttonCell
	{
	    NSLog(@"清空");  
	}
	```
### NSButton

1. button的样式风格有很多



### NSDatePicker

1. 时间选择器

	```Objective-C
	//设置时间选择器的样式，
	NSTextFieldAndStepperDatePickerStyle    = 0, //可输入文本+上下选择样式
	NSClockAndCalendarDatePickerStyle       = 1,//日期选择器+钟表时间选择器
	NSTextFieldDatePickerStyle              = 2 //单纯可输入文本
	datePicker.datePickerStyle = NSClockAndCalendarDatePickerStyle;
	```

2. 设置当前时间
		
	```Objective-C
	datePicker.dateValue = [NSDate date];
	```

### NSProgressIndicator

1. 进度条

	```Objective-C
	//设置进度条格式
	_progress.style = NSProgressIndicatorBarStyle; 
	//设置进度条的数值，改变数据可以控制进度条进度
  _progress.doubleValue = 0;
  //进度条的最小值
  _progress.minValue = 0;
  //进度条的最大值
  _progress.maxValue = 100;
  //NO显示进度条百分比，YES不显示进度条百分比,是一个渐变动画
  _progress.indeterminate = NO;
	```
	



