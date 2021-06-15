# Cells
<details>
	<summary>LDInputSegmentTableCell</summary>

### Description:
Segment cell allowing users to input a custom value. Generally used for inputting custom integers.

### Usage:
```xml
<dict>
		<key>cell</key>
		<string>PSSegmentCell</string>
		<key>cellClass</key>
		<string>LDInputSegmentTableCell</string>
		<key>inputTitle</key>
		<string>Input alert title</string>
		<key>inputMessage</string>
		<string>Message to be displayed in the input alert./string>
		<key>defaults</key>
		<string>com.company.tweak</string>
		<key>key</key>
		<string>key</string>
		<key>default</key>
		<string>2</string>
		<key>validTitles</key>
		<array>
			<string>One</string>
			<string>Two</string>
		</array>
		<key>validValues</key>
		<array>
			<integer>1</integer>
			<integer>2</integer>
		</array>
		<key>PostNotification</key>
		<string>com.company.tweak/ReloadPrefs</string>
</dict>
```

### Keys:
| Key | Type | Description | Default |
| --- | :--: | ----------- | :-----: |
| inputTitle | _string_ | Title for the input alert view. | If `nil`, the label for the segment cell is used |
| inputMessage | _string_ | Message for the input alert view. | "No input message provided for this cell." |

---
</details>

# Views

<details>
	<summary>LDAnimatedTitleView</summary>
	
### Description:
A animated title in the navigation bar that slides up when the user has scrolled down.

### Declaration:
```objc
-(instancetype)initWithTitle:(NSString *)title textColor:(UIColor *)color minimumScrollOffsetRequired:(CGFloat)minimumOffset;
```

### Parameters:
* **title**
	- String used for the label in the navigation bar.
* **color**
	- Color of the label.
* **minimumOffset**
	- Minimum scroll view offset before the label animates.

### Usage:
```objc
-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	if(!self.navigationItem.titleView) {
		LDAnimatedTitleView *animatedTitleView = [[LDAnimatedTitleView alloc] initWithTitle:@"Flashlight Indicator" textColor:[UIColor cyanColor] minimumScrollOffsetRequired:20];
		self.navigationItem.titleView = animatedTitleView;
	}
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if([self.navigationItem.titleView respondsToSelector:@selector(adjustLabelPositionToScrollOffset:)]) {
		[(LDAnimatedTitleView *)self.navigationItem.titleView adjustLabelPositionToScrollOffset:scrollView.contentOffset.y];
	}
}
```

---
</details>

<details>
	<summary>LDHeaderView</summary>
	
### Description:
A header view allow for a large icon, title, and subtitle. Also has interpolating motion and blurred background options.

### Declaration:
```objc
-(instancetype)initWithTitle:(NSString *)title subtitles:(NSArray<NSString *> *)subtitles bundle:(NSBundle *)bundle options:(NSDictionary<NSString *, id> *)options
```

### Parameters:
* **title**
	- String used for the header's title label.
* **subtitles**
	- Array of strings randomly selected to be used as for the header's subtitle.
* **bundle**
	- Bundle that will be used to retreive the icon if the `LDHeaderOptionIconFileName` is set in the **options**.
* **options**
	- Dictionary of strings and corresponding values containg options used for the header. A list of [LDHeaderOptionKeys](https://github.com/LacertosusRepo/libDeusPrefs/blob/main/README.md#ldheaderoptionkeys) can be found below.

### Usage:
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

### LDHeaderOptionKeys:
| Key | Type | Description | Default |
| --- | :--: | ----------- | :-----: |
| LDHeaderOptionIconFileName | _string_ | Name of the large icon file (should be 225 x 225px), ignore if no icon is wanted | nil |
| LDHeaderOptionTitleFontSize | _float_ | Font size of the title. | 35 |
| LDHeaderOptionSubtitleFontSize | _float_ | Font size of the subtitles | 13 |
| LDHeaderOptionAddInterpolatingMotion | _bool_ | Adds slight interpolating motion when the device is moved | NO |
| LDHeaderOptionAddMaterialBackground | _bool_ | Adds a blurred background to header, also using the user's wallpaper. | NO |

---
</details>
