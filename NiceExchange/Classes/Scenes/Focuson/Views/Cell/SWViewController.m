//
//  SWViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/25.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWViewController.h"
#import "SWcommentsViewController.h"

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"写评论";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"发送纸飞机.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(valueofAction:)];
}


- (void)valueofAction:(UIBarButtonItem *)sender {
    NSLog(@"发送");
#warning Blokc传值 第二步:返回要传递的内容
    SWComment *mment = [SWComment object];
    
    AVQuery *aQ = [AVQuery queryWithClassName:@"_User"];
    //        [aQ includeKey:@"userImage"];
    [aQ whereKey:@"objectId" equalTo:[SWLcAvUSer currentUser].objectId];
    [aQ findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        SWLcAvUSer *user = (SWLcAvUSer *)objects[0];
        
    mment.commentContent = self.textViewL.text;
    mment.commentBy = user;
        
             self.SecondBlock(mment);
    [self.navigationController popViewControllerAnimated:YES];
        
        }];
  
  [LCManager lcToCommentingWithComment: self.comment commentString:self.textViewL.text completion:^(NSArray *mArray) {
      
 
   }];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
