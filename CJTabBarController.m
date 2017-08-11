//
//  CJTabBarController.m
//  CJCustomTabbar
//
//  Created by zxjk on 17/8/11.
//
//

#import "CJTabBarController.h"
#import "CJTabBar.h"

@interface CJTabBarController ()

@end

@implementation CJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tabBar
    [self setValue:[CJTabBar new] forKey:@"tabBar"];
    
    [self createControllers];
}

#pragma mark 创建controller
- (void)createControllers
{
    NSArray *titleArr = @[@"首页", @"发现", @"收藏", @"设置"];
    NSArray *imageArr = @[@"wxb主页", @"iconfont-yiqiyibiao", @"iconfont-xingxing", @"iconfont-jixieqimo"];
    NSArray *selectImageArr = @[@"wxb主页-2", @"iconfont-yiqiyibiao-2", @"iconfont-xingxing-2", @"iconfont-jixieqimo-2"];
    for (NSInteger i = 0; i < titleArr.count; i++) {
        // 对应controller
        UIViewController *VC = [[UIViewController alloc] init];
        VC.view.backgroundColor = [UIColor colorWithRed:255.0/3*i/255.0 green:255.0/3*i/255.0 blue:255.0/3*i/255.0 alpha:1];
        // 创建navigation
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        // nav标题
        VC.navigationItem.title = titleArr[i];
        // tabBar标题
        nav.tabBarItem.title = titleArr[i];
        // 设置未选中图片（原谅我首页图片颜色和其他不一样，下错了）
        nav.tabBarItem.image = [[UIImage imageNamed:imageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 设置选中图片
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 添加
        [self addChildViewController:nav];
    }
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
