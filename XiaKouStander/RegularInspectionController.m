//
//  RegularInspectionController.m
//  XiaKouStander
//  **********安全工器定期检查记录***********
//  Created by teddy on 15/10/22.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "RegularInspectionController.h"
#import "RightLabelCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"
#import "SelectDateCell.h"

@interface RegularInspectionController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_list;//数据源
    NSString *_currentDate; //当前填表的日期
    NSString *_nextCheckDate;//下次检查的日期
}

@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

- (IBAction)saveUploadAction:(id)sender;
@end

@implementation RegularInspectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailTable.delegate = self;
    self.detailTable.dataSource = self;
    self.detailTable.backgroundColor = CELL_BG_COLOR;
    
    _list = @[@"序号",@"工器具名称",@"规格名称",@"单位",@"数量",@"所检部门",@"检查结果",@"检查人",];
    //默认为当天的日期
    _currentDate = [self getCurrentDate:[NSDate date]];
    _nextCheckDate = _currentDate;
    
    
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
        if ([self.detailTable respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.detailTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
#endif
    if ([self.detailTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.detailTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
    return 3;
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
        case 2:
        {
            return 1;
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
            
            if (indexPath.row == 0) {
                RightLabelCell *rightCell = (RightLabelCell *)[[[NSBundle mainBundle] loadNibNamed:@"RightLabelCell" owner:nil options:nil] lastObject];
                rightCell.nameLabel.text = _list[indexPath.row];
                rightCell.rightLabel.text = @"001";
                rightCell.backgroundColor = CELL_BG_COLOR;
                return rightCell;
            }else{
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
            }
            
        }
            break;
        case 2:
        {
            //时间选择
            SelectDateCell *dateCell = (SelectDateCell *)[[[NSBundle mainBundle] loadNibNamed:@"DamPartrolCell" owner:nil options:nil] lastObject];
            dateCell.backgroundColor = CELL_BG_COLOR;
            dateCell.selectionStyle = UITableViewCellSelectionStyleNone;
            dateCell.dateLabel.text = _nextCheckDate;
            [dateCell.forwardBtn addTarget:self action:@selector(forwardDateAction:) forControlEvents:UIControlEventTouchUpInside];
            dateCell.forwardBtn.tag = 103;
            [dateCell.nextBtn addTarget:self action:@selector(nextDateAction:) forControlEvents:UIControlEventTouchUpInside];
            dateCell.nextBtn.tag = 104;
            return dateCell;
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
            header.titleLabel.text = @"记录内容";
            return header;
        }
            break;
        case 2:
        {
            CusHeaderView *header = (CusHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
            header.titleLabel.text = @"下次检查日期";
            return header;
        }
            break;
        default:
            return nil;
            break;
    }
}

static int _selectRow; //选择第几行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 1) {
//        if (indexPath.row == 1) {
//            [self performSegueWithIdentifier:@"gateContent" sender:nil];
//            _selectRow = (int)indexPath.row;
//        }
//    }
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
    if (sender.tag == 101) {
        _currentDate = [self getCurrentDate:forwardDate];
    }
    else if (sender.tag == 103)
    {
       _nextCheckDate = [self getCurrentDate:forwardDate];
    }
    [self.detailTable reloadData];
}

//后一天
- (void)nextDateAction:(UIButton *)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
  //  _currentDate = [self getCurrentDate:forwardDate];
    if (sender.tag == 102) {
        _currentDate = [self getCurrentDate:forwardDate];
    }
    else if (sender.tag == 104)
    {
        _nextCheckDate = [self getCurrentDate:forwardDate];
    }
    [self.detailTable reloadData];
}

#pragma mark - UItextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)saveUploadAction:(id)sender {
}
@end
