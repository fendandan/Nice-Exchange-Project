//
//  SWCreationViewController.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWCreationViewController.h"
#import "SWAddRule.h"
#import "SWMessViewController.h"
#import "SWLayoutTextView.h"

#import "SWBaiduAPIViewController.h"
@class SWAppDelegate;
@interface SWCreationViewController ()
<
UITextFieldDelegate,
SwLayoutTextViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate

>
@property(nonatomic,strong)UIImageView *imageview;//箭头
@property (nonatomic,strong)UITextField *titleTF;//标题
@property (nonatomic, strong)SWAddRule *addrule;
@property (strong, nonatomic)SWLayoutTextView *textView;
@property (nonatomic, strong)UIScrollView *scrollview;
@property(nonatomic,strong) UIImagePickerController *imagepicker;
@property (strong ,nonatomic) UIImageView *photoimageView;
@property (strong, nonatomic) UIView *Viewaddimage;
@property (strong, nonatomic) UIView *tageView;
@property (strong, nonatomic) UIButton *addtageButton;
@property (nonatomic,strong)UIWindow *window;
@end

@implementation SWCreationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self releaseAction];
    //[self.view addSubview:self.backgrandHeaderView];
    self.imagepicker = [[UIImagePickerController alloc]init];
    self.imagepicker.delegate = self;
    [self addImageview];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.scrollview addGestureRecognizer:tapGestureRecognizer];
    
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.titleTF resignFirstResponder];
    [self.textView.textView resignFirstResponder];
    [self.addrule.textfield resignFirstResponder];
}
-(void)releaseAction
{
    self.navigationItem.title = @"发布";
    //navgation 点击事件
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(itemRightAction:)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"存草稿" style:UIBarButtonItemStyleDone target:self action:@selector(itemRightsAction:)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
    //
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:scroll];
    self.scrollview = scroll;
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpeg"]];
    image.backgroundColor = [UIColor grayColor];
    [scroll addSubview:image];
    //上传图片
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 150, 100, 20, 20)];
    self.imageview.layer.masksToBounds = YES;
    self.imageview.layer.cornerRadius = self.imageview.bounds.size.width/2;
    self.imageview.image = [UIImage imageNamed:@"2.png"];
    self.imageview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageview];
    UIButton *uploadbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadbtn.frame = CGRectMake(self.view.bounds.size.width -130 , 100, 130, 20);
    // uploadbtn.backgroundColor = [UIColor orangeColor];
    [uploadbtn setTitle:@"上传封面图片"forState:UIControlStateNormal];
    [uploadbtn addTarget:self action:@selector(uploadAction:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:uploadbtn];
    //添加标签
    UIButton *addlabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addlabBtn.frame = CGRectMake(150,180 , 120, 30);
    addlabBtn.layer.masksToBounds = YES;
    addlabBtn.layer.cornerRadius = addlabBtn.bounds.size.height/4;
    [addlabBtn setTitle:@"娱乐" forState:UIControlStateNormal];
    [addlabBtn setBackgroundColor:[UIColor blackColor]];
    [addlabBtn addTarget:self action:@selector(addlabBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    addlabBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    [scroll addSubview:addlabBtn];
      self.addtageButton = addlabBtn;
    //活动标题
    self.titleTF.delegate = self;
    self.titleTF = [[UITextField alloc]initWithFrame:CGRectMake(20 , 220,self.view.bounds.size.width -40, 60)];
    self.titleTF.backgroundColor = [UIColor cyanColor];
    self.titleTF.layer.masksToBounds = YES;
    self.titleTF.layer.cornerRadius = self.titleTF.bounds.size.height/4;
    [self.titleTF setFont:[UIFont fontWithName:@"" size:20]];
    self.titleTF.placeholder = @"来个响亮的名字";
    [scroll addSubview:self.titleTF];
    //
    self.Viewaddimage = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleTF.frame) , CGRectGetMaxY(self.titleTF.frame)+10,self.titleTF.frame.size.width, 70)];
    self.Viewaddimage.backgroundColor= [UIColor whiteColor];
    self.Viewaddimage.layer.masksToBounds = YES;
    self.Viewaddimage.layer.cornerRadius = self.Viewaddimage.frame.size.height/4;
    self.Viewaddimage.alpha = 0.8;
    [scroll addSubview:self.Viewaddimage];
    //
    self.textView = [[SWLayoutTextView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.Viewaddimage.frame) , CGRectGetMaxY(self.Viewaddimage.frame)+10,self.Viewaddimage.frame.size.width, 100)];
    self.textView.placeholder = @"说点啥呢!";
    [scroll addSubview:self.textView];
    self.textView.delegate = self;
    //self.textview.frame = CGRectMake(CGRectGetMinX(self.titleTF.frame), CGRectGetMaxY(self.titleTF.frame)+10, self.titleTF.frame.size.width, self.textview.contentSize.height);
    //添加规则
    self.addrule = [[SWAddRule alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textView.frame),CGRectGetMaxY(self.textView.frame) +10,self.textView.frame.size.width,160 )];
    self.addrule.backgroundColor = [UIColor whiteColor];
    self.addrule.layer.masksToBounds = YES;
    self.addrule.layer.cornerRadius = self.addrule.frame.size.height/6;
    [scroll addSubview:self.addrule];
    self.addrule.alpha = 0.8;
}
-(void)changeLayoutView
{
    self.addrule.frame = CGRectMake(CGRectGetMinX(self.textView.textView.frame)+CGRectGetMinX(self.textView.frame),CGRectGetMaxY(self.textView.textView.frame)+CGRectGetMaxY(self.textView.frame)+10-self.textView.frame.size.height,self.textView.frame.size.width,160 );
    if (self.addrule.frame.origin.y + self.addrule.frame.size.height >= kScreenHeight ) {
        self.scrollview.contentSize = CGSizeMake(kScreenWidth, self.addrule.frame.origin.y +self.addrule.frame.size.height) ;
        self.scrollview.contentOffset = CGPointMake(0,self.scrollview.contentSize.height - kScreenHeight);
    }
}

//textFiled限制长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.titleTF) {
        if (self.titleTF.text.length > 20 )
            return NO;
    }
    return YES;
}
//
-(void)addImageview
{
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    imageview.backgroundColor = [UIColor grayColor];
    [self.Viewaddimage addSubview:imageview];
    self.photoimageView = imageview;
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview.frame)+10, CGRectGetMinY(imageview.frame), imageview.frame.size.width, imageview.frame.size.height)];
    imageview2.image = [UIImage imageNamed:@"Picture.png"];
    imageview2.userInteractionEnabled = YES;
    [self.Viewaddimage addSubview:imageview2];
    UITapGestureRecognizer *imagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(action:)];
    [imageview2 addGestureRecognizer:imagetap];
}

//调用系统相册
-(void)action:(UITapGestureRecognizer *)sender
{
    [self presentViewController:self.imagepicker animated:YES completion:^{
        
    } ];
}

//navgation
-(void)itemRightAction:(UIBarButtonItem *)sender{
    
    
    SWLog(@"嘿嘿");
    // 发布活动
    if (self.titleTF.text.length == 0) {
        [self aalertViewShowWithMessage:@"忘了写标题了？" title:@"哦" otherTitle:nil];
    }else if (self.textView.textView.text.length == 0) {
        [self aalertViewShowWithMessage:@"忘写内容了？" title:@"哦" otherTitle:nil];
    }else {
        SWActivityList *activity = [SWActivityList object];
        activity.title = self.titleTF.text;
        activity.content = self.textView.textView.text;
        activity.subhead = @"副标题"; // 副标题
        NSData *data = UIImageJPEGRepresentation(self.photoimageView.image, 0.5);
        AVFile *file = [AVFile fileWithName:@"title.jpg" data:data];
        [activity setObject:file forKey:@"titleImage"];
        activity.rule = self.addrule.string; // 规则
        activity.label = self.addtageButton.titleLabel.text; // 标签
        activity.point = [AVGeoPoint geoPointWithLatitude:39.6 longitude:40]; // 坐标
        activity.markC = @0; // 收藏数累计，默认0
        [activity setObject:[SWLcAvUSer currentUser] forKey:@"createBy"]; // 发布者
        [activity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                SWLog(@"%d",succeeded);
                self.titleTF.text = nil;
                self.textView.textView.text = nil;
            }
        }];
    }
    
}
//存草稿
-(void)itemRightsAction:(UIBarButtonItem *)sender{
    SWLog(@"嘿嘿");
   
    SWBaiduAPIViewController *baidu = [[SWBaiduAPIViewController alloc]init];
    [self.navigationController pushViewController:baidu animated:YES];

}
//button
-(void)uploadAction:(UIButton *)sender{
   // NSLog(@"上传图片");
    [self pusenotice];
}
-(void)addlabBtnAction:(UIButton *)sender{
    //NSLog(@"添加标签");
    [self addTags];
}

//调用系pusenotice统相册
-(void)pusenotice
{
    //定义本地通值对象
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相册和相机" message:@"呵呵" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SWLog(@"调用系统相册");
        [self presentViewController:self.imagepicker animated:YES completion:^{
            
        } ];
        
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SWLog(@"调用相机");
        // [self CameraImage];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SWLog(@"返回");
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:alert animated:YES completion:nil];
    //[alert showInView:self.view];
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    
}
#pragma  maek --图片选择器图片的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //取得图片
    UIImage *selectimage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.photoimageView.image = selectimage;
    [self dismissViewControllerAnimated:YES completion:nil];
}
//xitongxiangji
-(void)CameraImage
{
    self.imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    self.imagepicker.videoMaximumDuration = 15;
    //相机类型(拍照 录像...)字符串需要作出相应的类型转换
    self.imagepicker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage ];
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    self.imagepicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    //设置摄像头模式（拍照，录制视频）为录像模式
    self.imagepicker.cameraCaptureMode =  UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagepicker animated:YES completion:nil];
    
}
//添加标签
-(void)addTags
{
    //
    UIView *tagsview = [[UIView alloc]initWithFrame:CGRectMake(30, 240, 340, 110)];
    tagsview.backgroundColor = [UIColor whiteColor];
    tagsview.layer.masksToBounds = YES;
    tagsview.layer.cornerRadius = tagsview.frame.size.height/4;
    [self.view addSubview:tagsview];
    self.tageView = tagsview;
    NSArray *array = @[@[@"娱乐",@"文艺",@"乐活",@"旅行"],@[@"吃喝",@"时尚",@"美容",@"情感"]];
    for (int j = 0; j < array.count; j++) {
        NSArray *arr = array[j];
        for (int i = 0; i < arr.count; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(20+i*80, 10 +j*50, 60, 40);
            btn.backgroundColor = [UIColor orangeColor];
            [tagsview addSubview:btn];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = btn.frame.size.height/4;
            [btn addTarget:self action:@selector(tagsAssignment:) forControlEvents:(UIControlEventTouchUpInside)];
            [btn setTitle:[NSString stringWithFormat:@"%@",array[j][i]] forState:UIControlStateNormal];
        }
        
    }
    
    
}
//tagsAssignment赋值
-(void)tagsAssignment:(UIButton *)sender
{
    
    self.addtageButton.titleLabel.text = sender.titleLabel.text;
    
    [self.tageView removeFromSuperview];
    
    [self dismissViewControllerAnimated:YES completion:^{

    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
     [self.titleTF resignFirstResponder];
    [self.textView resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.scrollview resignFirstResponder];
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
