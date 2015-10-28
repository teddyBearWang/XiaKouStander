//
//  WaterTelemetryCheckContentController.m
//  XiaKouStander
//  **********水情遥测内容检查界面************
//  Created by teddy on 15/10/28.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "WaterTelemetryCheckContentController.h"
#import "MainItemCell.h"

@interface WaterTelemetryCheckContentController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSArray *_mainList;
}

//主列表
@property (weak, nonatomic) IBOutlet UITableView *waterTable;
//标题label:是否运转正常
@property (weak, nonatomic) IBOutlet UILabel *statueLabel;
//结果
@property (weak, nonatomic) IBOutlet UITextView *resultContentView;

//状态标签:异常情况
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
//开关
@property (weak, nonatomic) IBOutlet UISwitch *tapSwitch;
//分割线标签
@property (weak, nonatomic) IBOutlet UILabel *divilLable;

//点击了开关触发的方法
- (IBAction)tapSwitchAction:(id)sender;


//点击背景取消键盘
- (IBAction)tapBackgroundAction:(id)sender;

@end

@implementation WaterTelemetryCheckContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.waterTable.delegate = self;
    self.waterTable.dataSource = self;
    self.waterTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.waterTable.backgroundColor = CELL_BG_COLOR;
    
    self.resultContentView.delegate = self;
    self.resultContentView.backgroundColor = [UIColor whiteColor];
    self.resultContentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.resultContentView.layer.borderWidth = 0.3;
    self.resultContentView.layer.cornerRadius = 5.0;
    
    _mainList = @[@"坝顶",@"防浪墙",@"迎水面",@"背水面",@"坝址",@"排水系统",@"倒渗降压系统",@"观测系统"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainList.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //主列表
    MainItemCell *cell = (MainItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"MainItemCell" owner:nil options:nil] lastObject];
    cell.nameLabel.text = _mainList[indexPath.row];
    cell.nameLabel.font = [UIFont systemFontOfSize:15];
    cell.bg_view.backgroundColor = CELL_BG_COLOR;
    cell.backgroundColor = CELL_BG_COLOR;
    
    if (indexPath.row == 0) {
        [cell setSelectAction:YES];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
static NSUInteger _oldSelectIndex;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *oldIndex = [NSIndexPath indexPathForRow:_oldSelectIndex inSection:0];
    MainItemCell *oldCell = (MainItemCell *)[tableView cellForRowAtIndexPath:oldIndex];
    [oldCell setSelectAction:NO];
    
    MainItemCell *cell = (MainItemCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectAction:YES];
    _oldSelectIndex = indexPath.row;
    
    NSLog(@"点击主视图");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.resultContentView resignFirstResponder];
    }
    return YES;
}

//点击背景取消键盘
- (IBAction)tapBackgroundAction:(id)sender
{
    [self.resultContentView resignFirstResponder];
}

//点击开关触发的方法
- (IBAction)tapSwitchAction:(id)sender
{
    UISwitch *tap = (UISwitch *)sender;
    if (!tap.isOn) {
        //存在问题，所以显示
        self.resultContentView.hidden = NO;
        self.resultLabel.hidden = NO;
    }else{
        //不存在问题，所以隐藏
        self.resultContentView.hidden = YES;
        self.resultLabel.hidden = YES;
    }
}

@end
