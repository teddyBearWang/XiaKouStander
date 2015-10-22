//
//  MachineCheckController.m
//  XiaKouStander
//  **********设备检修和试验登记表************
//  Created by teddy on 15/10/22.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "MachineCheckController.h"
#import "RightLabelCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"
#import "SelectDateCell.h"

@interface MachineCheckController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_list;//数据源
    NSString *_currentDate; //当前填表的日期
}

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UITableView *machineTable;


- (IBAction)saveUploadAction:(id)sender;
@end

@implementation MachineCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.machineTable.delegate = self;
    self.machineTable.dataSource = self;
    self.machineTable.backgroundColor = CELL_BG_COLOR;
    
    _list = @[@"序号",@"设备名称",@"检修和试验内容",@"检修和实验结果",@"登录人"];
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
        if ([self.machineTable respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.machineTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
#endif
    if ([self.machineTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.machineTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
            
            if (indexPath.row == 0) {
                RightLabelCell *rightCell = (RightLabelCell *)[[[NSBundle mainBundle] loadNibNamed:@"RightLabelCell" owner:nil options:nil] lastObject];
                rightCell.nameLabel.text = _list[indexPath.row];
                rightCell.rightLabel.text = @"001";
                rightCell.backgroundColor = CELL_BG_COLOR;
                return rightCell;
            }else if(indexPath.row == 1){
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
            }else if(indexPath.row == 2 || indexPath.row == 3){
    
                //备注
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.backgroundColor = CELL_BG_COLOR;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.text = _list[indexPath.row];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
                addButton.tag = indexPath.row;
                addButton.frame = (CGRect){cell.contentView.frame.size.width - 30 -10 ,7,30,30};
                [addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
                [addButton addTarget:self action:@selector(addResultsAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:addButton];
                return cell;
            }else{
                RightLabelCell *rightCell = (RightLabelCell *)[[[NSBundle mainBundle] loadNibNamed:@"RightLabelCell" owner:nil options:nil] lastObject];
                rightCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                rightCell.nameLabel.text = _list[indexPath.row];
                rightCell.rightLabel.text = @"系统管理员";
                rightCell.backgroundColor = CELL_BG_COLOR;
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
    [self.machineTable reloadData];
}

//后一天
- (void)nextDateAction:(UIButton *)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.machineTable reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addmachineContent"]) {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"检修和试验内容" forKey:@"titleName"];
    }
    else if ([segue.identifier isEqualToString:@"addmachineResult"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"检修和试验结果" forKey:@"titleName"];
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
    if (btn.tag == 2) {
        
        [self performSegueWithIdentifier:@"addmachineContent" sender:nil];
    }
    else if (btn.tag == 3)
    {
        [self performSegueWithIdentifier:@"addmachineResult" sender:nil];
    }
}

- (IBAction)saveUploadAction:(id)sender {
}
@end
