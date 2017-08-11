//
//  CJTabBar.m
//  CJCustomTabbar
//
//  Created by zxjk on 17/8/10.
//
//

#import "CJTabBar.h"

@interface CJTabBar ()

@property (nonatomic, strong) UIButton *centerButton;

@end

@implementation CJTabBar

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.centerButton];
    }
    return self;
}
#pragma mark getter
- (UIButton *)centerButton
{
    if (_centerButton == nil) {
        _centerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        [_centerButton setImage:[UIImage imageNamed:@"08"] forState:UIControlStateNormal];
        [_centerButton addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}

// 重新布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 获取原有tabBarButton
    NSMutableArray *tabArr = [NSMutableArray array];
    for (UIView *temp in self.subviews) {
        if ([temp isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabArr addObject:temp];
        }
    }
    // 重新设置坐标
    CGFloat btnWidth = (self.frame.size.width-self.centerButton.frame.size.width)/4.0;
    CGFloat btnHeight = 48;
    
    for (int i = 0; i < tabArr.count; i++) {
        UIButton *temp = tabArr[i];
        temp.frame = CGRectMake(btnWidth*i+(i/2)*btnWidth, 1, btnWidth, btnHeight);
    }
    // 设置中间按钮高
    self.centerButton.center = CGPointMake(self.frame.size.width / 2, 48/2-6);
}



#pragma mark centerButton click
- (void)centerAction:(UIButton *)btn
{
    NSLog(@"center");
}

// 重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha <= 0.01f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {
        // 把这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}



@end
