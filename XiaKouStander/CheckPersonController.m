//
//  CheckPersonController.m
//  XiaKouStander
//  ************检查人员列表**********
//  Created by teddy on 15/10/27.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "CheckPersonController.h"

@interface CheckPersonController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataList;//数据源
}
//人员列表
@property (weak, nonatomic) IBOutlet UITableView *personTable;

@end

@implementation CheckPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.personTable.delegate = self;
    self.personTable.dataSource = self;
    self.personTable.backgroundColor = CELL_BG_COLOR;
    
    _dataList = @[@"系统管理员",@"系统管理员",@"系统管理员",@"系统管理员",@"系统管理员",@"系统管理员",@"系统管理员",@"系统管理员",@"系统管理员",@"系统管理员"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = CELL_BG_COLOR;
    cell.textLabel.text = _dataList[indexPath.row];
    return cell;
}

static NSInteger _oldSelectIndex;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:_oldSelectIndex inSection:0];
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark ) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    _oldSelectIndex = indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
