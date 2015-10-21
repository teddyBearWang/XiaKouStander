//
//  ValveDetailController.m
//  XiaKouStander
//  ***********锥形阀检查内容**************
//  Created by teddy on 15/10/21.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ValveDetailController.h"
#import "MainItemCell.h"

@interface ValveDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_mainDataList;//主列表的数据源
}
//左边主列表
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
//背景
@property (weak, nonatomic) IBOutlet UIImageView *bg_imageView;
//内容标签
@property (weak, nonatomic) IBOutlet UILabel *contenLabel;
//正常与否
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
//添加按钮
@property (weak, nonatomic) IBOutlet UIButton *add_btn;

//点击添加触发的事件
- (IBAction)addNoteAction:(id)sender;

@end

@implementation ValveDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.backgroundColor = CELL_BG_COLOR;
    
    _mainDataList = [NSMutableArray arrayWithObjects:@"电器",@"电动机",@"制动器",@"齿轮箱",@"滑动轴承",@"手摇机构",@"动滑轮" ,nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addNoteAction:(id)sender
{
    [self performSegueWithIdentifier:@"addNote" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addNote"]) {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"备注" forKey:@"titleName"];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainDataList.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //主列表
    MainItemCell *cell = (MainItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"MainItemCell" owner:nil options:nil] lastObject];
    cell.nameLabel.text = _mainDataList[indexPath.row];
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
