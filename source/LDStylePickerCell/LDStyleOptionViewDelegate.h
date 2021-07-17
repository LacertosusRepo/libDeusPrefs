@class LDStyleOptionView;

@protocol LDStyleOptionViewDelegate <NSObject>
@required
-(void)selectedOption:(LDStyleOptionView *)option;
@end
