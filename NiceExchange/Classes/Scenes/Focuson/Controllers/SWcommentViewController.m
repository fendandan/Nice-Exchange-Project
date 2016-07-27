//
//  SWcommentViewController.m
//  
//
//  Created by Spacewalk on 16/7/15.
//
//

#import "SWcommentViewController.h"
#import "SWshowViewController.h"
@interface SWcommentViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
///
@property (nonatomic,strong)UIImagePickerController *ImagePickerController;
@property(nonatomic,strong)NSTextAttachment *NSTextAttachment;
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
    self.tttttt.text =  self.detail;
    self.titleL.text = self.detailll;
    self.detailL.text = self.aaa;
    self.bqLLLLL.text= self.bqL;
    self.ImagePickerController = [[UIImagePickerController alloc]init];
    self.ImagePickerController.delegate = self;
    
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
    _ImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  
    [self  presentViewController:_ImagePickerController animated:YES completion:^{
    }];
    
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
#warning Blokc传值 第二步:返回要传递的内容

#warning ------------

    
     [LCManager lcToCommentingWithActivityList:self.swActivityList commentString:self.textView.text completion:^(NSArray *mArray) {
         SWComment *comment = [SWComment object];
         
         comment.commentBy = [SWLcAvUSer currentUser];
         comment.commentContent = self.textView.text;
         self.SecondBlock(comment);
       
         [self.navigationController popViewControllerAnimated:YES];
         NSLog(@"发表评论");
         
         
     }];
}

 




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@", info);
    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //

    // textview add image
  
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    
   self.NSTextAttachment = [[NSTextAttachment alloc] initWithData:nil ofType:nil] ;
    UIImage *image1  = image;
   [self scaleToSize:image1 size:CGSizeMake(10, 10)];
    _NSTextAttachment.image = image1;
    
    NSAttributedString *textAttachmentString = [NSAttributedString attributedStringWithAttachment: _NSTextAttachment] ;
    
    [string insertAttributedString:textAttachmentString atIndex:0];//index为用户指定要插入图片的位置
    
    self.textView.attributedText = string;
  
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    // 创建一个bitmap的context
    
    // 并把它设置成为当前正在使用的context
    
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    
    [img drawInRect:CGRectMake(0,0, 1, 1)];
    
    // 从当前context中创建一个改变大小后的图片
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    //返回新的改变大小后的图片
    
    return scaledImage;
    
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
