//
//  NoteViewController.m
//  XiaKouStander
//  ***备注或新增检查结果**********
//  Created by teddy on 15/10/21.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()
//填写的内容
@property (weak, nonatomic) IBOutlet UITextView *contentVIew;
//save button
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

//保存事件
- (IBAction)saveInfoAction:(id)sender;

//点击背景取消
- (IBAction)tapBackgroundAction:(id)sender;
@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.titleName;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
- (IBAction)saveInfoAction:(id)sender
{
    
}

//点击背景取消
- (IBAction)tapBackgroundAction:(id)sender
{
    [self.contentVIew resignFirstResponder];
}
@end
