//
//  ViewController.m
//  XiaKouStander
//
//  Created by teddy on 15/9/17.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *user_bg_view;
@property (weak, nonatomic) IBOutlet UIImageView *user_image;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UIView *psw_ng_view;
@property (weak, nonatomic) IBOutlet UIImageView *psw_image;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//登陆
- (IBAction)loginAction:(id)sender;

//点击背景取消键盘
- (IBAction)tapBackgroundAction:(id)sender;
@end;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.user_bg_view.layer.cornerRadius = 5.0;
    self.user_bg_view.layer.masksToBounds = YES;
    self.user_image.image = [UIImage imageNamed:@"user"];
    
    self.psw_ng_view.layer.cornerRadius = 5.0;
    self.psw_ng_view.layer.masksToBounds = YES;
    self.pswField.secureTextEntry = YES;
    self.psw_image.image = [UIImage imageNamed:@"password"];
    
    self.loginBtn.layer.cornerRadius = 5.0f;
    self.loginBtn.backgroundColor = [UIColor colorWithRed:56/255.0 green:131/255.0 blue:238/255.0 alpha:1.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登陆
- (IBAction)loginAction:(id)sender
{
    [self performSegueWithIdentifier:@"login" sender:nil];
}

//点击背景取消键盘
- (IBAction)tapBackgroundAction:(id)sender
{
    [self.userNameField resignFirstResponder];
    [self.pswField resignFirstResponder];
}
@end
