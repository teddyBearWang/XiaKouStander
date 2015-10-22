//
//  RotatingEquipmentController.m
//  XiaKouStander
//  **********设备轮换检查记录**********
//  Created by teddy on 15/10/22.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "RotatingEquipmentController.h"
#import "RightLabelCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"
#import "SelectDateCell.h"

@interface RotatingEquipmentController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString *_currentDate; //当前填表的日期
}

@property (weak, nonatomic) IBOutlet UITableView *equalTable;

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
- (IBAction)saveUploadAction:(id)sender;
@end

@implementation RotatingEquipmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.equalTable.delegate = self;
    self.equalTable.dataSource = self;
    self.equalTable.backgroundColor = CELL_BG_COLOR;
    
    //默认为当天的日期
    _currentDate = [self getCurrentDate:[NSDate date]];
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
        if ([self.equalTable respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.equalTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
#endif
    if ([self.equalTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.equalTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
            return 1;
        }
            break;
        case 2:
        {
            return 4;
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
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.text = @"注:每月1号和16号为规定轮换检查时间";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = CELL_BG_COLOR;
            return cell;
        }
            break;
        case 1:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.backgroundColor = CELL_BG_COLOR;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"  轮换检查内容";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
            addButton.tag = 201;
            addButton.frame = (CGRect){cell.contentView.frame.size.width - 30 -10 ,7,30,30};
            [addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(addResultsAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:addButton];
            return cell;
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.text = @"检查日期";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = CELL_BG_COLOR;
                return cell;
            }
            if (indexPath.row == 1) {
                //时间选择
                SelectDateCell *dateCell = (SelectDateCell *)[[[NSBundle mainBundle] loadNibNamed:@"DamPartrolCell" owner:nil options:nil] lastObject];
                dateCell.backgroundColor = CELL_BG_COLOR;
                dateCell.selectionStyle = UITableViewCellSelectionStyleNone;
                dateCell.dateLabel.text = _currentDate;
                [dateCell.forwardBtn addTarget:self action:@selector(forwardDateAction:) forControlEvents:UIControlEventTouchUpInside];
                [dateCell.nextBtn addTarget:self action:@selector(nextDateAction:) forControlEvents:UIControlEventTouchUpInside];
                return dateCell;
            }
            else if (indexPath.row == 2)
            {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.backgroundColor = CELL_BG_COLOR;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.text = @"  检查轮换设备工作状态";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
                addButton.tag = 202;
                addButton.frame = (CGRect){cell.contentView.frame.size.width - 30 -10 ,7,30,30};
                [addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
                [addButton addTarget:self action:@selector(addResultsAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:addButton];
                return cell;
            }else{
                //闸门名称
                PartrolInfoCell *partrolCell = (PartrolInfoCell *)[[[NSBundle mainBundle] loadNibNamed:@"PartrolInfoCell" owner:nil options:nil] lastObject];
                partrolCell.selectionStyle = UITableViewCellSelectionStyleNone;
                partrolCell.backgroundColor = CELL_BG_COLOR;
                partrolCell.postionLabel.text = @"登录人";
                partrolCell.valueField.returnKeyType = UIReturnKeyDone;
                partrolCell.valueField.backgroundColor = CELL_BG_COLOR;
                partrolCell.valueField.delegate = self;
                partrolCell.valueField.placeholder = @"请输入检查人姓名";
                partrolCell.postionLabel.font = [UIFont systemFontOfSize:15];
                return partrolCell;
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
    switch (indexPath.section) {
        case 0:
        {
            return 40;
        }
            break;
        case 1:
        {
            return 44;
        }
            break;
        case 2:
        {
            return 44;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            UIView *view = [[UIView alloc] initWithFrame:(CGRect){0,0,kScreen_Width,0}];
            return view;
        }
            break;
        case 1:
        {
            CusHeaderView *header = (CusHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
            header.titleLabel.text = @"检查内容";
            return header;
        }
            break;
        case 2:
        {
            CusHeaderView *header = (CusHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
            header.titleLabel.text = @"记录内容";
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
    [self.equalTable reloadData];
}

//后一天
- (void)nextDateAction:(UIButton *)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.equalTable reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"rotationConetntCheck"]) {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"轮换检查内容" forKey:@"titleName"];
    }
    else if ([segue.identifier isEqualToString:@"workStation"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"设备轮换设备工作的状态" forKey:@"titleName"];
    }
}

#pragma mark - UItextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


//新增处理结果
- (void)addResultsAction:(UIButton *)btn
{
    NSLog(@"新增处理结果");
    if (btn.tag == 201) {
        //轮换检查内容
        [self performSegueWithIdentifier:@"rotationConetntCheck" sender:nil];
    }
    else if (btn.tag == 202)
    {
        //轮换设备工作状态
        [self performSegueWithIdentifier:@"workStation" sender:nil];
    }
}


- (IBAction)saveUploadAction:(id)sender {
}
@end
