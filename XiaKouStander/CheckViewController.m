//
//  CheckViewController.m
//  XiaKouStander
//  **********检查内容************
//  Created by teddy on 15/10/13.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "CheckViewController.h"
#import "MainItemCell.h"
#import "ChildItemCell.h"

@interface CheckViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //主列表
    __weak IBOutlet UITableView *mainTable;
    //子列表
    __weak IBOutlet UITableView *childTable;
    //添加按钮
    __weak IBOutlet UIButton *addButton;
    
    NSMutableArray *_mainDataList;//主列表的数据源
    NSMutableArray *_childDataList;//子列表的数据源
}

//点击添加按钮触发的事件
- (IBAction)clickAddButtonAction:(id)sender;
@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.backgroundColor = CELL_BG_COLOR;
    childTable.delegate = self;
    childTable.dataSource = self;
    
    NSLog(@"传进来的值为:%d",[self.selectRow intValue]);
    //self.view.backgroundColor = CELL_INTRUCTION_COLOR;
    
    _mainDataList = [NSMutableArray arrayWithObjects:@"上游面",@"坝顶",@"下游面",@"坝址",@"廊道", nil];
    _childDataList = [NSMutableArray arrayWithObjects:@"表面整洁",@"表面排水沟孔",@"爆破/炸鱼/采石/取土",
                                                      @"重物对方",@"伸缩缝(错位)",@"伸缩缝(渗水)",
                                                       @"裂缝(状况)",@"裂缝(渗水)",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:mainTable]) {
        return _mainDataList.count;
    }else{
        return _childDataList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:mainTable]) {
        //主列表
        MainItemCell *cell = (MainItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"MainItemCell" owner:nil options:nil] lastObject];
        cell.nameLabel.text = _mainDataList[indexPath.row];
        cell.bg_view.backgroundColor = CELL_BG_COLOR;
        cell.backgroundColor = CELL_BG_COLOR;
        
        if (indexPath.row == 0) {
            [cell setSelectAction:YES];
        }
        return cell;
        
    }else{
        //子列表
        ChildItemCell *cell = (ChildItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"ChildItemCell" owner:nil options:nil] lastObject];
        cell.valueLabel.text = _childDataList[indexPath.row];
        cell.tapSelect.on = NO;//默认关闭
        cell.tapSelect.tag = indexPath.row;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
static NSUInteger _oldSelectIndex;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:mainTable]) {
        
        NSIndexPath *oldIndex = [NSIndexPath indexPathForRow:_oldSelectIndex inSection:0];
        MainItemCell *oldCell = (MainItemCell *)[tableView cellForRowAtIndexPath:oldIndex];
        [oldCell setSelectAction:NO];
        
        MainItemCell *cell = (MainItemCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell setSelectAction:YES];
        _oldSelectIndex = indexPath.row;
        
        //主视图
       // [childTable reloadData];
        NSLog(@"点击主视图");
    }else{
        //子视图
        NSLog(@"选择子视图");
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


//点击添加按钮触发的事件
- (IBAction)clickAddButtonAction:(id)sender
{
    
}
@end
