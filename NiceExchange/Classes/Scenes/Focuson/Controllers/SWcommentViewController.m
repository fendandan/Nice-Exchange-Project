//
//  SWcommentViewController.m
//  
//
//  Created by Spacewalk on 16/7/15.
//
//

#import "SWcommentViewController.h"

@interface SWcommentViewController ()<UITextViewDelegate,SWTabBarDelegate>

@end

@implementation SWcommentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //左上方返回按钮
    [self backButtonItem];
    //右上方发布评论按钮
    [self publishedItem];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView.delegate = self;
    self.title = @"参与沙龙";
    [self tollBar];
    self.view.backgroundColor = [UIColor whiteColor];
  
}



-(void)tollBar {
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    
    //设置style
    [topView setBarStyle:UIBarStyleBlackOpaque];
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:@"图片.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(addPhoto)];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
    
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
   
    [_textView setInputAccessoryView:topView];
    
    
}



-(void)resignKeyboard {
    [_textView resignFirstResponder];
}
//涂抹空白处隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_textView resignFirstResponder];
}
//添加图片
-(void)addPhoto {
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"进入编辑状态");
 
    
}
-(void)backButtonItem {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(backAction:)];
}



-(void)backAction:(UIBarButtonItem *)back {

  
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)publishedItem {

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:(UIBarButtonItemStylePlain) target:self action:@selector(publishedAction:)];

}


-(void)publishedAction:(UIBarButtonItem *)sender {

    //评论
    NSLog(@"发表评论");
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
