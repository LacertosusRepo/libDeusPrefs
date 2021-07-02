#! Declaration
```objc
@interface LDInputSegmentTableCell : PSSegmentTableCell
@end
```

#! Example Usage
```xml
<dict>
	<key>cell</key>
	<string>PSSegmentCell</string>
	<key>cellClass</key>
	<string>LDInputSegmentTableCell</string>
	<key>inputTitle</key>
	<string>Input Alert Title</string>
	<key>inputMessage</key>
	<string>Your input message here!</string>
	<key>defaults</key>
	<string>com.company.tweak</string>
	<key>key</key>
	<string>key</string>
	<key>default</key>
	<string>2</string>
	<key>validTitles</key>
	<array>
		<string>One Option</string>
		<string>Two Option</string>
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
