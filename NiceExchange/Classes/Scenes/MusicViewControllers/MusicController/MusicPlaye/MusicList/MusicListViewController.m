//
//  MusicListViewController.m
//  YDMusicPlayer
//
//  Created by 王佩 on 16/5/16.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MusicListViewController.h"
#import "MusicInfosHandle.h"
#import "DataSource_Url.h"
#import "MBProgressHUD.h"
#import "MusicListCell.h"
#import "MusicPlayerViewController.h"
#import "AVPlayerManager.h"
//获取单例对象
#define kMusicInfosHandle [MusicInfosHandle sharedMusicInfosHandle]

#define kAVPlayerManager [AVPlayerManager sharedAVPlayerManager]

@interface MusicListViewController ()

@end

@implementation MusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音乐列表";
    //请求需要的数据
    [self requestData];
    //加载菊花
    [self showHUD];
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicListCell" bundle:nil] forCellReuseIdentifier:@"musicListCell"];
}
#pragma mark-- 私有方法
//显示菊花
- (void)showHUD
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"歌曲正在加载...";
}
//隐藏菊花
- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)requestData
{
    
    __weak MusicListViewController * musicListVC = self;
    [kMusicInfosHandle getMusicInfosWithUrl:MUSIC_LIST_URL completion:^(NSArray *array, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            //刷新表视图
            [musicListVC updateData];
        }
    }];
}

- (void)updateData
{
    [self.tableView reloadData];
    //数据刷新完毕隐藏菊花
    [self hideHUD];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return [kMusicInfosHandle numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [kMusicInfosHandle numberofRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicListCell" forIndexPath:indexPath];
    //
   MusicInfo * music = [kMusicInfosHandle musicInfoForRowAtIndexPath:indexPath];
    
    cell.music = music;
    return cell;
}
//cell高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
#pragma  mark --
    //获取要播放的歌曲
    MusicInfo * music =  [kMusicInfosHandle musicInfoForRowAtIndexPath:indexPath];
    [AVPlayerManager sharedAVPlayerManager];
    
//    MusicPlayerViewController * MPVC = (MusicPlayerViewController *)kAVPlayerManager.VC;
//    //当MPVC为空，或者将要的播放歌曲的Id和正在播放歌曲的Id不同时，需重新创建一个视图控制器
//    if (!(MPVC && (MPVC.music.Id == music.Id)) ) {
//        
//        MPVC = [[MusicPlayerViewController alloc] init];
//        kAVPlayerManager.VC = MPVC;
//        //传值
//        MPVC.music = music;
//        MPVC.index = indexPath.row;
//        
//    }
    MusicPlayerViewController *musicVC = nil;

    if (kAVPlayerManager.VC && [(MusicPlayerViewController *)kAVPlayerManager.VC music].Id  == music.Id) {
        musicVC = (MusicPlayerViewController *)kAVPlayerManager.VC;
    }else {
        //模态出播放页面
        musicVC = [[MusicPlayerViewController alloc] init];
        musicVC.music = music;
        //传入索引值
        musicVC.index = indexPath.row;
        kAVPlayerManager.VC = musicVC;
    }

    [self presentViewController:musicVC animated:YES completion:nil];
    

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
