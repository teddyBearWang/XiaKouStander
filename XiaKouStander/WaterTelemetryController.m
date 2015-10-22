//
//  WaterTelemetryController.m
//  XiaKouStander
//  *******水情遥测***********
//  Created by teddy on 15/10/22.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "WaterTelemetryController.h"
#import "SelectDateCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"
#import "ChildItemCell.h"

@interface WaterTelemetryController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *_infoList;//巡查信息
    NSString *_currentDate;
}

@property (weak, nonatomic) IBOutlet UITableView *detailTable;

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
- (IBAction)saveUploadAction:(id)sender;
@end

@implementation WaterTelemetryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.detailTable.delegate = self;
    self.detailTable.dataSource = self;
    self.detailTable.backgroundColor = CELL_BG_COLOR;
    
    _infoList = @[@"是否需要审批",@"维护人"];
    //默认为当天的日期
    _currentDate = [self getCurrentDate:[NSDate date]];
    
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
            return 2;
        }
            break;
        case 2:
        {
            return _infoList.count;
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
            [dateCell.nextBtn addTarget:self action:@selector(nextDateAction:) forControlEvents:UIControlEventTouchUpInside];
            return dateCell;
        }
            break;
        case 1:
        {
            
            if (indexPath.row == 0) {
                //闸门名称
                PartrolInfoCell *partrolCell = (PartrolInfoCell *)[[[NSBundle mainBundle] loadNibNamed:@"PartrolInfoCell" owner:nil options:nil] lastObject];
                partrolCell.selectionStyle = UITableViewCellSelectionStyleNone;
                partrolCell.backgroundColor = CELL_BG_COLOR;
                partrolCell.valueField.returnKeyType = UIReturnKeyDone;
                partrolCell.valueField.backgroundColor = CELL_BG_COLOR;
                partrolCell.valueField.delegate = self;
                
                partrolCell.postionLabel.font = [UIFont systemFontOfSize:15];
                partrolCell.postionLabel.text = @" 水位";
                partrolCell.valueField.placeholder = @"请输入水位(米)";
                return partrolCell;
            }else{
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.text = @"  设备事项";
                cell.backgroundColor = CELL_BG_COLOR;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                return cell;
            }
            
        }
            break;
        case 2:
        {
            if (indexPath.row != 0) {
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = [NSString stringWithFormat:@"  %@",_infoList[indexPath.row]];
                cell.backgroundColor = CELL_BG_COLOR;
                
                return cell;
            }else{
                //子列表
                ChildItemCell *cell = (ChildItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"ChildItemCell" owner:nil options:nil] lastObject];
                cell.backgroundColor = CELL_BG_COLOR;
                cell.valueLabel.text = [NSString stringWithFormat:@"  %@",_infoList[indexPath.row]];
                cell.tapSelect.on = NO;//默认关闭
                cell.tapSelect.tag = indexPath.row;
                return cell;
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
            header.titleLabel.text = @"巡查内容";
            return header;
        }
            break;
        case 2:
        {
            CusHeaderView *header = (CusHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
            header.titleLabel.text = @"巡查信息记录";
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
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"gateContent" sender:nil];
            _selectRow = (int)indexPath.row;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//利用storyBoard进行传值
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"addResult"]) {
//        id theSegue = segue.destinationViewController;
//        //到时候可以直接传递数据源到下一级
//        [theSegue setValue:@"新增处理结果" forKey:@"titleName"];
//    }
//}

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
- (void)forwardDateAction:(id)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:-60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.detailTable reloadData];
}

//后一天
- (void)nextDateAction:(id)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
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
