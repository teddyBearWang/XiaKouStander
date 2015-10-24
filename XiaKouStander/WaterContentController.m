//
//  WaterContentController.m
//  XiaKouStander
//
//  Created by teddy on 15/10/24.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "WaterContentController.h"
#import "MainItemCell.h"

@interface WaterContentController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_mainList;//左侧列表的数据源
}


//主列表
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
//分割视图
@property (weak, nonatomic) IBOutlet UIView *dividerView;
//检查内容label
@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
//开关
@property (weak, nonatomic) IBOutlet UISwitch *tapSwitch;
//分割标签
@property (weak, nonatomic) IBOutlet UILabel *dividerLabel;

@end

@implementation WaterContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.backgroundColor = CELL_BG_COLOR;
    
    _mainList = @[@"植被情况(库区)",@"山体滑坡(库区)",@"非法取沙(库区)",@"乱倒垃圾(库区)",@"乱排放污水(库区)",@"饲料投放情况(库区)",@"库区清洁情况",@"其他"];
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
    cell.nameLabel.font = [UIFont systemFontOfSize:13];
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
