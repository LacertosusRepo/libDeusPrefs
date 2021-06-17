#! Declaration
```objc
-(instancetype)initWithTitle:(NSString *)title textColor:(UIColor *)color minimumScrollOffsetRequired:(CGFloat)minimumOffset;
```

#! Example Usage
```objc
-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	if(!self.navigationItem.titleView) {
		LDAnimatedTitleView *animatedTitleView = [[LDAnimatedTitleView alloc] initWithTitle:@"Your Title" textColor:[UIColor redColor] minimumScrollOffsetRequired:20];
		self.navigationItem.titleView = animatedTitleView;
	}
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if([self.navigationItem.titleView respondsToSelector:@selector(adjustLabelPositionToScrollOffset:)]) {
		[(LDAnimatedTitleView *)self.navigationItem.titleView adjustLabelPositionToScrollOffset:scrollView.contentOffset.y];
	}
}
```
