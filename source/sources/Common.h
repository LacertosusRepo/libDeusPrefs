#import <Preferences/PSSpecifier.h>
#import <Preferences/PSControlTableCell.h>
#import "HBLog.h"

@interface UIView (Private)
-(UIViewController *)_viewControllerForAncestor;
@end

@interface UIImage (Private)
+(instancetype)kitImageNamed:(id)arg1;
@end

@interface PSSpecifier (Private)
-(void)performSetterWithValue:(id)value;
-(id)performGetter;
@end

@interface PSSegmentTableCell : PSControlTableCell
@end
