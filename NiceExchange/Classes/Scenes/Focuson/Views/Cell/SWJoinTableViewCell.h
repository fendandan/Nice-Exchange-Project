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
@property (strong, nonatomic) IBOutlet UIView *unView;
@property (strong, nonatomic) IBOutlet UIButton *jionImg;

@property (strong, nonatomic) IBOutlet UILabel *activityL;
@property (strong, nonatomic) IBOutlet UILabel *ioinCountL;
@property (strong, nonatomic) IBOutlet UILabel *detailL;
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;
@property (strong, nonatomic) IBOutlet UILabel *UdetailL;
@property (strong, nonatomic) IBOutlet UILabel *goodPL;
@property (strong, nonatomic) IBOutlet UILabel *badPL;
@property (strong, nonatomic) id<JoinDelegate>joinDelegate;
@end
