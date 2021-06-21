#! Declaration
```objc
@interface LDTimeIntervalPickerCell : PSTableCell
@end
```

#! Example Usage
```xml
<dict>
	<key>cell</key>
	<string>PSButtonCell</string>
	<key>cellClass</key>
	<string>LDTimeIntervalPickerCell</string>
	<key>defaults</key>
	<string>com.company.tweak</string>
	<key>key</key>
	<string>key</string>
	<key>label</key>
	<string>Set Time Interval</string>
	<key>default</key>
	<integer>120</integer>
	<key>PostNotification</key>
	<string>com.company.tweak/ReloadPrefs</string>
</dict>
```
