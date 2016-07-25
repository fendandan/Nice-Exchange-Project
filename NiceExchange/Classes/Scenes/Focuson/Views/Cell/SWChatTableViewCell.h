//
//  SWChatTableViewCell.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/25.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWChatTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property(nonatomic,copy)NSString *content;
@property (nonatomic, assign) CGFloat cellHeight;
@end
