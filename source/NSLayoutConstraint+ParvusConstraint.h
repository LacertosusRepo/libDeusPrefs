struct LDLayoutConstants {
  CGFloat width;
  CGFloat height;
  CGFloat x;
  CGFloat y;
  CGFloat top;
  CGFloat bottom;
  CGFloat leading;
  CGFloat trailing;
};

typedef struct LDLayoutConstants LDLayoutConstants;

  LDLayoutConstants LDLayoutConstantsMake(CGFloat width, CGFloat height, CGFloat x, CGFloat y, CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing);
  LDLayoutConstants LDSelectConstantsMake(NSDictionary <NSString *, NSNumber *>*constantsDict);
  LDLayoutConstants LDSizeConstantsMake(CGFloat width, CGFloat height);
  LDLayoutConstants LDEdgeConstantsMake(CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing);

@interface NSLayoutConstraint (ParvusConstraint)
+(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors constants:(LDLayoutConstants)constants;
+(NSArray <NSLayoutConstraint *>*)ld_constrainView:(UIView *)primaryView toView:(UIView *)secondaryView anchors:(NSString *)anchors;
+(NSArray <NSLayoutConstraint *>*)ld_centerView:(UIView *)primaryView inView:(UIView *)secondaryView constants:(LDLayoutConstants)constants;
+(NSArray <NSLayoutConstraint *>*)ld_sizeView:(UIView *)primaryView constants:(LDLayoutConstants)constants;
@end
