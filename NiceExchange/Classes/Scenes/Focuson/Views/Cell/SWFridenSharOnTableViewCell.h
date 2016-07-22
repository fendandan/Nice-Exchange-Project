//
//  SWFridenSharOnTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendiconDelegate <NSObject>

-(void)onClick;

@end

@interface SWFridenSharOnTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *Friendicon;
@property (strong, nonatomic) IBOutlet UILabel *FriendName;
@property (strong, nonatomic) IBOutlet UIImageView *detailImv;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *collectNum;
@property (strong, nonatomic) IBOutlet UILabel *joinNum;
@property (strong, nonatomic) IBOutlet UIView *unView;


@property(nonatomic,weak)id<FriendiconDelegate>friendDelegate;

@end
