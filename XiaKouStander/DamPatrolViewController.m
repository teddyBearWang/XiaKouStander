//
//  DamPatrolViewController.m
//  XiaKouStander
//  ************大坝巡查记录表*********
//  Created by teddy on 15/10/12.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "DamPatrolViewController.h"

@interface DamPatrolViewController ()

@property (weak, nonatomic) IBOutlet UITableView *detailTable;//详细列表
@property (weak, nonatomic) IBOutlet UIButton *confirm_btn;//提交按钮

//确认提交
- (IBAction)confirmUploadAction:(id)sender;

@end

@implementation DamPatrolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)confirmUploadAction:(id)sender {
}
@end
