//
//  SWRSPViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/26.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWRSPViewController.h"

@interface SWRSPViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *oldPasswordTF;
@property (strong, nonatomic) UITextField *npTF;
@property (strong, nonatomic) UITextField *infoTF;
@property (strong, nonatomic) UIButton *overB;

@end

@implementation SWRSPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addView];
    self.oldPasswordTF.delegate = self;
    self.npTF.delegate = self;
    self.infoTF.delegate = self;
}

- (void)addView {
    
    
    SWCertificationView *infoView = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, 79, kScreenWidth, kScreenWidth)];
    //    infoView.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(infoLabel.frame) + 10);
    
    infoView.userNameTextField.placeholder = @"当前密码";
    infoView.passwordTextField.placeholder = @"新密码";
    self.oldPasswordTF = infoView.userNameTextField;
    self.oldPasswordTF.returnKeyType = UIReturnKeyNext;
    self.npTF = infoView.passwordTextField;
    self.npTF.returnKeyType = UIReturnKeyNext;
    
    SWCertificationView *infoViewS = [[SWCertificationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    infoViewS.userNameTextField.center = CGPointMake(kScreenWidth / 2, CGRectGetMaxY(self.npTF.frame) + 79 + 40);
    infoViewS.userNameTextField.placeholder = @"确认密码";
    self.infoTF = infoViewS.userNameTextField;
    
    [self.view addSubview:infoView];
    [self.view addSubview:self.infoTF];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, kScreenHeight - 100, kScreenWidth - 40, 30);
    
    button.backgroundColor = [UIColor cyanColor];
    
    button.titleLabel.font = [UIFont systemFontOfSize:28.0];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    button.layer.borderColor = kBorderCGColor;
    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.overB = button;
}
- (void)saveAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //键盘高度216
    
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.overB.frame = CGRectMake(20, kScreenHeight - 100 - 252.0f, kScreenWidth - 40, 30); //64-216
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    //滑动效果
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复屏幕
    self.overB.frame = CGRectMake(20, kScreenHeight - 100, kScreenWidth - 40, 30); //64-216
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.oldPasswordTF) {
        [self.npTF becomeFirstResponder];
    }else if (textField == self.npTF){
        [self.infoTF becomeFirstResponder];
    }else {
        [self.infoTF resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.oldPasswordTF resignFirstResponder];
    [self.npTF resignFirstResponder];
    [self.infoTF resignFirstResponder];
    
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
