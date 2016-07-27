//
//  SWAboutMeViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/22.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWAboutMeViewController.h"

@interface SWAboutMeViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UITextField *displayNameTF;
@property (strong, nonatomic) UITextField *genderTF;
@property (strong, nonatomic) UITextField *infoTF;
@property (strong, nonatomic) UITextField *textF;

@end

@implementation SWAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    [self addView];
    
    self.displayNameTF.delegate = self;
    self.displayNameTF.returnKeyType = UIReturnKeyNext;
    self.genderTF.delegate = self;
    self.genderTF.returnKeyType = UIReturnKeyNext;
    self.infoTF.delegate = self;
    
    self.textF.delegate = self;
    
#warning --------- 修改self.currentUser
    if ([SWLcAvUSer currentUser].displayName) {
        self.displayNameTF.text = [SWLcAvUSer currentUser].displayName;
    }else {
        
    }
    
#warning --------- 添加属性
    //    if ([SWLcAvUSer currentUser].gender) {
    //
    //    }
    
    //    if ([SWLcAvUSer currentUser].info) {
    //
    //    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)addView {
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 3, kScreenWidth / 3)];
    self.imgView.center = CGPointMake(kScreenWidth / 2, kScreenWidth / 3 + 20);
    self.imgView.layer.cornerRadius = kScreenWidth / 6;
    self.imgView.layer.masksToBounds = YES;
    self.imgView.backgroundColor = kImageColor;
    if ([SWLcAvUSer currentUser].userImage) {
        [self.imgView setImageWithURL:[NSURL URLWithString:[SWLcAvUSer currentUser].userImage.url]];
    }else {
        [self.imgView setImageWithURL:[NSURL URLWithString:@"http://ac-8nI1eCRt.clouddn.com/XJT3FKPr096iVDIpDUfVJtA.jpg"]];
    }
    
    self.imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer * top = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topInfoLabel:)];
    [self.imgView addGestureRecognizer:top];
    
    [self.view addSubview:self.imgView];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 135, 15)];
    infoLabel.font = [UIFont systemFontOfSize:15.0];
    infoLabel.text = @"点击头像可重新设置";
    infoLabel.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(self.imgView.frame) + 25);
    
    [self.view addSubview:infoLabel];
    
    SWCertificationView *infoView = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoLabel.frame) + 10, kScreenWidth, kScreenWidth)];
    //    infoView.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(infoLabel.frame) + 10);
    
    infoView.userNameTextField.placeholder = @"昵称";
    infoView.passwordTextField.placeholder = @"性别";
    self.displayNameTF = infoView.userNameTextField;
    self.genderTF = infoView.passwordTextField;
    
    SWCertificationView *infoViewS = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    infoViewS.userNameTextField.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(self.genderTF.frame) + CGRectGetMaxY(infoLabel.frame) + 40);
    infoViewS.userNameTextField.placeholder = @"介绍";
    self.infoTF = infoViewS.userNameTextField;
    
    [self.view addSubview:infoView];
    [self.view addSubview:self.infoTF];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    
}
- (void)saveAction:(UIBarButtonItem *)barButtonItem {
    SWLogFunc;
    
    // 个人信息设置
    SWLcAvUSer * user = [SWLcAvUSer currentUser];
    user.displayName = self.displayNameTF.text;
    
    NSData *data = UIImageJPEGRepresentation(self.imgView.image, 0.5);
    AVFile *imageFile = [AVFile fileWithName:@"userImage" data:data];
    user.userImage = imageFile;
    
    [user saveInBackground];
}
// 头像点击方法
- (void)topInfoLabel:(UITapGestureRecognizer *)tapGestureRecongnizer {
    
    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.view.frame.origin.y == 0.0f) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        self.view.frame = CGRectMake(0.0f, -252.0f, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.textF) {
        NSTimeInterval animationDuration = 0.03f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.displayNameTF) {
        [self.genderTF becomeFirstResponder];
    }else if (textField == self.genderTF)  {
        [self.infoTF becomeFirstResponder];
    }else if(textField == self.infoTF) {
        [textField resignFirstResponder];
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        
    }
    return YES;
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.displayNameTF resignFirstResponder];
//    [self.genderTF resignFirstResponder];
//    [self.infoTF resignFirstResponder];
//}
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
