#! Declaration
```objc
-(instancetype)initWithTitle:(NSString *)title subtitles:(NSArray<NSString *> *)subtitles bundle:(NSBundle *)bundle options:(NSDictionary<NSString *, id> *)options;
```

#! Example Usage
```objc
-(void)viewDidLoad {
	[super viewDidLoad];

	NSArray *subtitles = @[@"Array of subtitles", @"A random one will be selected"];
	NSDictionary *options @{LDHeaderOptionIconFileName : @"largeIcon", LDHeaderOptionTitleFontSize : @25};

	LDHeaderView *header = [[LDHeaderView alloc] initWithTitle:@"Example Title" subtitles:subtitles bundle:[self bundle] options:options];
	header.frame = CGRectMake(0, 0, header.bounds.size.width, 135);
	self.table.tableHeaderView = header;
}
```
