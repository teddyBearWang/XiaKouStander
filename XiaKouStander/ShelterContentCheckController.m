//
//  ShelterContentCheckController.m
//  XiaKouStander
//  ********防空洞内容检查*********
//  Created by teddy on 15/10/26.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ShelterContentCheckController.h"
#import "MainItemCell.h"

@interface ShelterContentCheckController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSArray *_mainList;//数据源
    
}
//主列表
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
//内容标签
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//分割标签
@property (weak, nonatomic) IBOutlet UILabel *dividerLabel;
//结果
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
//选择检查人
@property (weak, nonatomic) IBOutlet UIButton *checkPersonBtn;
- (IBAction)selectCheckPersonAction:(id)sender;

//点击背景取消键盘
- (IBAction)tabBackground:(id)sender;

@end

@implementation ShelterContentCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.backgroundColor = CELL_BG_COLOR;
    
    self.resultTextView.delegate = self;
    
    _mainList = @[@"操作人员",@"电器",@"电动机",@"制动器",@"制动轮",@"通气孔",@"减速箱",@"开式齿轮",@"拉杆",@"闸门"];
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
        [self.resultTextView resignFirstResponder];
    }
    return YES;
}

- (IBAction)tabBackground:(id)sender
{
    [self.resultTextView resignFirstResponder];
}

//选择检查人
- (IBAction)selectCheckPersonAction:(id)sender {
}
@end
