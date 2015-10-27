//
//  BaiDamContentController.m
//  XiaKouStander
//  ********白水坑 大坝巡查的内容检查界面*********
//  Created by teddy on 15/10/27.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "BaiDamContentController.h"
#import "MainItemCell.h"

@interface BaiDamContentController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSArray *_mainList;
}
//主列表
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
//标题label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//结果
@property (weak, nonatomic) IBOutlet UITextView *resultContentView;

//点击背景取消键盘
- (IBAction)tapBackgroundAction:(id)sender;
@end

@implementation BaiDamContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.backgroundColor = CELL_BG_COLOR;
    
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

@end
