//
//  WaterContentController.m
//  XiaKouStander
//  **********水源地检查内容*********
//  Created by teddy on 15/10/24.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "WaterContentController.h"
#import "MainItemCell.h"

@interface WaterContentController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    NSArray *_mainList;//左侧列表的数据源
}
//主列表
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
//分割视图
@property (weak, nonatomic) IBOutlet UIView *dividerView;
//检查内容label
@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
//检查结果
@property (weak, nonatomic) IBOutlet UITextView *resultContentView;
//添加备注 按钮
@property (weak, nonatomic) IBOutlet UIButton *addNoteBtn;
//点击有问题
@property (weak, nonatomic) IBOutlet UISwitch *tapSwitch;
//点击有问题开关
- (IBAction)tapSwitchAction:(id)sender;

//添加备注
- (IBAction)addNoteAction:(id)sender;

- (IBAction)tapBackgroundAction:(id)sender;

@end

@implementation WaterContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTable.backgroundColor = CELL_BG_COLOR;
    
    self.resultContentView.delegate = self;
    self.resultContentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.resultContentView.layer.borderWidth = 0.3;
    self.resultContentView.layer.cornerRadius = 5.0;
    
    self.addNoteBtn.layer.cornerRadius = 5.0;
    
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


#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.resultContentView resignFirstResponder];
    }
    return YES;
}

//添加备注
- (IBAction)addNoteAction:(id)sender
{
    //添加备注
    [self performSegueWithIdentifier:@"waterNotePush" sender:nil];
}
//点击有问题开关
- (IBAction)tapSwitchAction:(id)sender
{
    UISwitch *tap = (UISwitch *)sender;
    if (!tap.isOn) {
        //存在问题就显示
        self.resultContentView.hidden = NO;
    }else{
        //没有问题就隐藏
        self.resultContentView.hidden = YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"waterNotePush"]) {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"水情备注" forKey:@"titleName"];
    }
}

- (IBAction)tapBackgroundAction:(id)sender
{
    [self.resultContentView resignFirstResponder];
}
@end
