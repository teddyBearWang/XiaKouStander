//
//  CusNavViewController.m
//  XiaKouStander
//
//  Created by teddy on 15/10/12.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "CusNavViewController.h"

@interface CusNavViewController ()

@end

@implementation CusNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置返回按钮颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    //设置nabigationBar的背景颜色
    self.navigationBar.barTintColor = [UIColor colorWithRed:48/255.0 green:144/255.0 blue:228/255.0 alpha:1.0];
    //设置navigationBar 的title 颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
