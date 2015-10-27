//
//  DieselGeneratorController.m
//  XiaKouStander
//  ********柴油发电机*************
//  Created by teddy on 15/10/24.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "DieselGeneratorController.h"
#import "RightLabelCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"
#import "SelectDateCell.h"

@interface DieselGeneratorController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_list;//数据源
    NSString *_currentDate; //当前填表的日期
}
@property (weak, nonatomic) IBOutlet UITableView *dieselTable;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
- (IBAction)saveUploadAction:(id)sender;

@end

@implementation DieselGeneratorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dieselTable.delegate = self;
    self.dieselTable.dataSource = self;
    self.dieselTable.backgroundColor = CELL_BG_COLOR;
    
    _list = @[@"燃油",@"冷却水",@"电瓶",@"机油",@"机温",@"转速",@"油压",@"频率表",@"发动机",@"控制开关",@"运行时间",@"运行情况",@"送电情况",@"检测人员",@"校核人员"];
    //默认为当天的日期
    _currentDate = [self getCurrentDate:[NSDate date]];
    
    
    //键盘即将出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillHideNotification object:nil];
    
    //键盘即将消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillShowNotification object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        if ([self.dieselTable respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.dieselTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
#endif
    if ([self.dieselTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.dieselTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

#pragma mark - NSNotification
//键盘即将出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y+150);
    [UIView commitAnimations];
}

//键盘即将消失
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y-150);
    [UIView commitAnimations];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return _list.count;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            //时间选择
            SelectDateCell *dateCell = (SelectDateCell *)[[[NSBundle mainBundle] loadNibNamed:@"DamPartrolCell" owner:nil options:nil] lastObject];
            dateCell.backgroundColor = CELL_BG_COLOR;
            dateCell.selectionStyle = UITableViewCellSelectionStyleNone;
            dateCell.dateLabel.text = _currentDate;
            [dateCell.forwardBtn addTarget:self action:@selector(forwardDateAction:) forControlEvents:UIControlEventTouchUpInside];
            dateCell.forwardBtn.tag = 101;
            [dateCell.nextBtn addTarget:self action:@selector(nextDateAction:) forControlEvents:UIControlEventTouchUpInside];
            dateCell.nextBtn.tag = 102;
            return dateCell;
        }
            break;
        case 1:
        {
            if (indexPath.row != _list.count - 1) {
                
                //闸门名称
                PartrolInfoCell *partrolCell = (PartrolInfoCell *)[[[NSBundle mainBundle] loadNibNamed:@"PartrolInfoCell" owner:nil options:nil] lastObject];
                partrolCell.selectionStyle = UITableViewCellSelectionStyleNone;
                partrolCell.backgroundColor = CELL_BG_COLOR;
                partrolCell.valueField.returnKeyType = UIReturnKeyDone;
                partrolCell.valueField.backgroundColor = CELL_BG_COLOR;
                partrolCell.valueField.delegate = self;
                
                partrolCell.postionLabel.font = [UIFont systemFontOfSize:15];
                partrolCell.postionLabel.text = _list[indexPath.row];
                partrolCell.valueField.placeholder = [NSString stringWithFormat:@"请输入%@",_list[indexPath.row]];
                return partrolCell;
            }else{
                RightLabelCell *rightCell = (RightLabelCell *)[[[NSBundle mainBundle] loadNibNamed:@"RightLabelCell" owner:nil options:nil] lastObject];
                rightCell.nameLabel.text = _list[indexPath.row];
                rightCell.nameLabel.font = [UIFont systemFontOfSize:15];
                rightCell.rightLabel.font = [UIFont systemFontOfSize:15];
                rightCell.rightLabel.text = @"系统管理员";
                rightCell.backgroundColor = CELL_BG_COLOR;
                rightCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return rightCell;
            }
            
        }
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            WeatherView *weatherView = (WeatherView *)[[[NSBundle mainBundle] loadNibNamed:@"weatherView" owner:nil options:nil] lastObject];
            return weatherView;
        }
            break;
        case 1:
        {
            CusHeaderView *header = (CusHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
            header.titleLabel.text = @"检查内容";
            return header;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - SelectDateAction
//根据时间得到时间字符串
- (NSString *)getCurrentDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//根据时间字符串得到时间
- (NSDate *)stringToDate:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

//前一天
- (void)forwardDateAction:(UIButton *)sender
{
    
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:-60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.dieselTable reloadData];
}

//后一天
- (void)nextDateAction:(UIButton *)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
    //  _currentDate = [self getCurrentDate:forwardDate];
    _currentDate = [self getCurrentDate:forwardDate];
   
    [self.dieselTable reloadData];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"addTestNote"]) {
//        id theSegue = segue.destinationViewController;
//        [theSegue setValue:@"备注" forKey:@"titleName"];
//    }
//}

#pragma mark - UItextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)saveUploadAction:(id)sender {
}
@end
