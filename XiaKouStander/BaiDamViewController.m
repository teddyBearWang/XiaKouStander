//
//  BaiDamViewController.m
//  XiaKouStander
//  *********白水坑大坝巡查*******
//  Created by teddy on 15/10/26.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "BaiDamViewController.h"
#import "SelectDateCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"

@interface BaiDamViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_partrolItems;//巡查数据源
    NSString *_currentDate;//当前的时间
}
@property (weak, nonatomic) IBOutlet UITableView *damTable;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

- (IBAction)saveUploadAction:(id)sender;
@end

@implementation BaiDamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.damTable.delegate = self;
    self.damTable.dataSource = self;
    self.damTable.backgroundColor = CELL_BG_COLOR;
    _partrolItems = @[@"坝体",@"坝基和坝区",@"输、泄水洞(管)",@"溢洪道", @"其他(包括备用电源等情况)"];
    //默认为当天的日期
    _currentDate = [self getCurrentDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            return 4;
        }
            break;
        case 2:
        {
            return _partrolItems.count;
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
            PartrolInfoCell *partrolCell = (PartrolInfoCell *)[[[NSBundle mainBundle] loadNibNamed:@"PartrolInfoCell" owner:nil options:nil] lastObject];
            partrolCell.selectionStyle = UITableViewCellSelectionStyleNone;
            partrolCell.backgroundColor = CELL_BG_COLOR;
            partrolCell.valueField.returnKeyType = UIReturnKeyDone;
            partrolCell.valueField.backgroundColor = CELL_BG_COLOR;
            partrolCell.valueField.delegate = self;
            switch (indexPath.row) {
                case 0:
                {
                    partrolCell.postionLabel.text = @"库水位";
                    partrolCell.valueField.placeholder = @"请输入库水位";
                }
                    break;
                case 1:
                {
                    partrolCell.postionLabel.text = @"检查人";
                    partrolCell.valueField.placeholder = @"请输入检查人姓名";
                }
                    break;
                case 2:
                {
                    partrolCell.postionLabel.text = @"记录人";
                    partrolCell.valueField.placeholder = @"请输入记录人姓名";
                }
                    break;
                case 3:
                {
                    partrolCell.postionLabel.text = @"负责人";
                    partrolCell.valueField.placeholder = @"请输入负责人姓名";
                }
                    break;
            }
            return partrolCell;
        }
            break;
        case 2:
        {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = _partrolItems[indexPath.row];
            cell.backgroundColor = CELL_BG_COLOR;
            return cell;
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
            header.titleLabel.text = @"巡查信息记录";
            return header;
        }
            break;
        case 2:
        {
            CusHeaderView *header = (CusHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomHeader" owner:nil options:nil] lastObject];
            header.titleLabel.text = @"巡查内容";
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
    if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"baiDamContent" sender:nil];
        _selectRow = (int)indexPath.row;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//利用storyBoard进行传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"baiDamContent"]) {
        id theSegue = segue.destinationViewController;
        //到时候可以直接传递数据源到下一级
        [theSegue setValue:[NSNumber numberWithInt:_selectRow] forKey:@"SelectRow"];
    }
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
- (void)forwardDateAction:(id)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:-60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.damTable reloadData];
}

//后一天
- (void)nextDateAction:(id)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.damTable reloadData];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)saveUploadAction:(id)sender {
}
@end
