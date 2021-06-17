@interface LDStylePickerCell : PSTableCell <LDStyleOptionViewDelegate>
-(LDStyleOptionView *)optionViewForID:(NSString *)identifier;
@end

@interface PSSpecifier (PrivateMethods)
-(void)performSetterWithValue:(id)value;
-(id)performGetter;
@end
