//
//  GateContentCheckController.m
//  XiaKouStander
//  ************闸门内容检查*****
//  Created by teddy on 15/10/22.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "GateContentCheckController.h"
#import "MainItemCell.h"

@interface GateContentCheckController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_mainList;//左侧列表的数据源
}
//选择列表
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
//状态标签
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
//开关按钮
@property (weak, nonatomic) IBOutlet UISwitch *tabSwitch;
//分割线
@property (weak, nonatomic) IBOutlet UILabel *separeterLabel;

@end

@implementation GateContentCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.backgroundColor = CELL_BG_COLOR;
    
    _mainList = @[@"水流状态",@"漏水状态",@"闸墩",@"门槽",@"底板伸缩缝",@"通气孔",@"启闭机室",@"附属设施",@"电气设备",@"备用电源"];
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
    
    //主视图
    // [childTable reloadData];
    NSLog(@"点击主视图");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



@end
