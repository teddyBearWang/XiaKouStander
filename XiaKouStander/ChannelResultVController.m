//
//  ChannelResultVController.m
//  XiaKouStander
//  ************渠道检查结果************
//  Created by teddy on 15/11/6.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ChannelResultVController.h"

@interface ChannelResultVController ()

@property (weak, nonatomic) IBOutlet UITextView *resultTextVIew;


@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

//保存结果
- (IBAction)saveResultAction:(id)sender;

//点击背景取消
- (IBAction)tapBackground:(id)sender;
@end

@implementation ChannelResultVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.resultType;
    //内容向上便宜64像素，以为由于导航栏和状态栏的缘由，默认内容向下偏移64px
    self.resultTextVIew.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)takeReultText:(ReturnBlock)block
{
    self.returnBlock = block;
}


//点击背景取消
- (IBAction)tapBackground:(id)sender
{
    [self.resultTextVIew resignFirstResponder];
}

- (IBAction)saveResultAction:(id)sender
{
    if (self.resultTextVIew.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"填写的内容为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    self.returnBlock(self.resultTextVIew.text);
}
@end
