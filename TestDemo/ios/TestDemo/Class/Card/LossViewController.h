/**  挂失、解挂 */
#import "RJBaseViewController.h"

@interface LossViewController : RJBaseViewController

/**
 @param type 1- 挂失 2-解挂  3-转账  4-修改密码
 */
- (instancetype)initWithType:(NSInteger)type;
@end
