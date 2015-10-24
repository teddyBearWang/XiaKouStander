//
//  WaterSourceController.m
//  XiaKouStander
//  *********库区水源地************
//  Created by teddy on 15/10/24.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "WaterSourceController.h"
#import "SelectDateCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"
#import "ChildItemCell.h"
#import "RightLabelCell.h"

@interface WaterSourceController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *_infoList;//巡查信息
    NSString *_currentDate;
}
//列表
@property (weak, nonatomic) IBOutlet UITableView *waterTable;
//保存按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

- (IBAction)saveUploadAction:(id)sender;
@end

@implementation WaterSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.waterTable.delegate = self;
    self.waterTable.dataSource = self;
    self.waterTable.backgroundColor = CELL_BG_COLOR;
    
    _infoList = @[@"是否需要审批",@"检查人员",@"复核人员",@"负责人"];
    //默认为当天的日期
    _currentDate = [self getCurrentDate:[NSDate date]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",self.reserviorId);
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
        if ([self.waterTable respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.waterTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
#endif
    if ([self.waterTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.waterTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
            return 3;
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
            }else if(indexPath.row == 1){
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.text = @"  设备巡查";
                cell.backgroundColor = CELL_BG_COLOR;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                return cell;
            }else{
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.backgroundColor = CELL_BG_COLOR;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.text = @"  说明";
                
                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
                addButton.frame = (CGRect){cell.contentView.frame.size.width - 30 -10 ,7,30,30};
                [addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
                [addButton addTarget:self action:@selector(addResultsAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:addButton];
                return cell;
            }
            
        }
            break;
        case 2:
        {
            if (indexPath.row != 0) {
                RightLabelCell *rightCell = (RightLabelCell *)[[[NSBundle mainBundle] loadNibNamed:@"RightLabelCell" owner:nil options:nil] lastObject];
                rightCell.nameLabel.text = _infoList[indexPath.row];
                rightCell.rightLabel.text = @"系统管理员";
                rightCell.backgroundColor = CELL_BG_COLOR;
                rightCell.rightLabel.font = [UIFont systemFontOfSize:15];
                rightCell.nameLabel.font = [UIFont systemFontOfSize:15];
                rightCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return rightCell;
                
            }else{
                //子列表
                ChildItemCell *cell = (ChildItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"ChildItemCell" owner:nil options:nil] lastObject];
                cell.backgroundColor = CELL_BG_COLOR;
                cell.valueLabel.text = [NSString stringWithFormat:@"  %@",_infoList[indexPath.row]];
                cell.tapSelect.on = YES;//默认关闭
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"waterContent" sender:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//利用storyBoard进行传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addWaterSourceNote"]) {
        id theSegue = segue.destinationViewController;
        //到时候可以直接传递数据源到下一级
        [theSegue setValue:@"水源地保护情况说明" forKey:@"titleName"];
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
    [self.waterTable reloadData];
}

//后一天
- (void)nextDateAction:(id)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.waterTable reloadData];
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
    [self performSegueWithIdentifier:@"addWaterSourceNote" sender:nil];
}
//上报上传

- (IBAction)saveUploadAction:(id)sender {
}
@end
