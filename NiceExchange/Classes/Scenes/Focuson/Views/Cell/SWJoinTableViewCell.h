//
//  SWJoinTableViewCell.h
//  
//
//  Created by Spacewalk on 16/7/14.
//
//

#import <UIKit/UIKit.h>
@protocol JoinDelegate <NSObject>

-(void)onJoinClick;

@end
@interface SWJoinTableViewCell : UITableViewCell
/**
 *  用户名
 */
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIView *unView;
/**
 *  头像
 */
@property (strong, nonatomic) IBOutlet UIButton *jionImg;
/**
 *  标题
 */
@property (strong, nonatomic) IBOutlet UILabel *activityL;
/**
 *  参与数
 */
@property (strong, nonatomic) IBOutlet UILabel *ioinCountL;
/**
 *  内容
 */
@property (strong, nonatomic) IBOutlet UILabel *detailL;
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;
/**
 * 评论内容
 */
@property (strong, nonatomic) IBOutlet UILabel *UdetailL;
/**
 *  赞
 */
@property (strong, nonatomic) IBOutlet UILabel *goodPL;
/**
 *  呵呵
 */
@property (strong, nonatomic) IBOutlet UILabel *badPL;
@property (strong, nonatomic) id<JoinDelegate>joinDelegate;


@property (nonatomic ,strong)SWComment *comment;




@end
