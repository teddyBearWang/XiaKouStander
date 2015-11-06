//
//  ChannelViewController.m
//  XiaKouStander
//  ***********渠道检查**********
//  Created by teddy on 15/11/6.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ChannelViewController.h"
#import "SelectDateCell.h"
#import "PartrolInfoCell.h"
#import "WeatherView.h"
#import "CusHeaderView.h"
#import "ChildItemCell.h"
#import "RightLabelCell.h"
#import "ChannelResultVController.h"

@interface ChannelViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString *_currentDate;//选择时间
}

@property (weak, nonatomic) IBOutlet UITableView *channelTable;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

//确认提交
- (IBAction)confirmUploadAction:(id)sender;

//点击背景取消
- (IBAction)tabBackground:(id)sender;
@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.channelTable.backgroundColor = BG_COLOR;
    //默认为当天的日期
    _currentDate = [self getCurrentDate:[NSDate date]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    
//#ifdef __IPHONE_8_0
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
//        if ([self.channelTable respondsToSelector:@selector(setLayoutMargins:)]) {
//            [self.channelTable setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
//        }
//    }
//#endif
//    if ([self.channelTable respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.channelTable setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;

    }else{
        return 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //时间选择
        SelectDateCell *dateCell = (SelectDateCell *)[[[NSBundle mainBundle] loadNibNamed:@"DamPartrolCell" owner:nil options:nil] lastObject];
        dateCell.backgroundColor = CELL_BG_COLOR;
        dateCell.selectionStyle = UITableViewCellSelectionStyleNone;
        dateCell.dateLabel.text = _currentDate;
        [dateCell.forwardBtn addTarget:self action:@selector(forwardDateAction:) forControlEvents:UIControlEventTouchUpInside];
        [dateCell.nextBtn addTarget:self action:@selector(nextDateAction:) forControlEvents:UIControlEventTouchUpInside];
        return dateCell;
    }else{
        switch (indexPath.row) {
            case 0:
            {
                RightLabelCell *rightCell = (RightLabelCell *)[[[NSBundle mainBundle] loadNibNamed:@"RightLabelCell" owner:nil options:nil] lastObject];
                rightCell.nameLabel.text = @"  所在渠道战";                rightCell.rightLabel.text = @"渠首站";
                rightCell.backgroundColor = CELL_BG_COLOR;
                rightCell.rightLabel.font = [UIFont systemFontOfSize:15];
                rightCell.nameLabel.font = [UIFont systemFontOfSize:15];
                rightCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return rightCell;
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
                
                partrolCell.postionLabel.font = [UIFont systemFontOfSize:15];
                partrolCell.postionLabel.text = @"  渠别";
                partrolCell.valueField.placeholder = @"请输入渠别名称";
                partrolCell.valueField.delegate = self;
                return partrolCell;
            }
                break;
            case 2:
            {
                PartrolInfoCell *partrolCell = (PartrolInfoCell *)[[[NSBundle mainBundle] loadNibNamed:@"PartrolInfoCell" owner:nil options:nil] lastObject];
                partrolCell.selectionStyle = UITableViewCellSelectionStyleNone;
                partrolCell.backgroundColor = CELL_BG_COLOR;
                partrolCell.valueField.returnKeyType = UIReturnKeyDone;
                partrolCell.valueField.backgroundColor = CELL_BG_COLOR;
                partrolCell.valueField.delegate = self;
                
                partrolCell.postionLabel.font = [UIFont systemFontOfSize:15];
                partrolCell.postionLabel.text = @"  公里编号";
                partrolCell.valueField.placeholder = @"请输入公里编号";
                partrolCell.valueField.delegate = self;
                return partrolCell;
            }
                break;
            case 6:
            {
                //子列表
                ChildItemCell *cell = (ChildItemCell *)[[[NSBundle mainBundle] loadNibNamed:@"ChildItemCell" owner:nil options:nil] lastObject];
                cell.backgroundColor = CELL_BG_COLOR;
                cell.valueLabel.text = @"  是否需要审批";
                cell.tapSelect.on = NO;//默认关闭
                cell.tapSelect.tag = indexPath.row;
                return cell;
            }
                break;
            default:
            {
                //初查情况，处理情况，处理结果
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.backgroundColor = CELL_BG_COLOR;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                if (indexPath.row == 3) {
                    
                    cell.textLabel.text = @"  初查情况";
                }else if(indexPath.row == 4){
                    cell.textLabel.text = @"  处理情况";
                }else{
                    cell.textLabel.text = @"  处理结果";
                }
                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
                addButton.tag = indexPath.row+1000;
                addButton.frame = (CGRect){cell.contentView.frame.size.width - 30 -10 ,7,30,30};
                [addButton setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
                [addButton addTarget:self action:@selector(addResultsAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:addButton];
                return cell;
            }
                break;
        }
    }
}

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
- (void)forwardDateAction:(id)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:-60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.channelTable reloadData];
}

//后一天
- (void)nextDateAction:(id)sender
{
    NSDate *date = [self stringToDate:_currentDate];
    NSDate *forwardDate = [date dateByAddingTimeInterval:60*60*24];
    _currentDate = [self getCurrentDate:forwardDate];
    [self.channelTable reloadData];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
    }
    return YES;
}

//新增处理结果
- (void)addResultsAction:(UIButton *)btn
{
    NSLog(@"新增处理结果");
    [self performSegueWithIdentifier:@"channelCheckResult" sender:[NSString stringWithFormat:@"%ld",btn.tag]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSInteger btnTag = [(NSString *)sender integerValue];
    if ([segue.identifier isEqualToString:@"channelCheckResult"]) {
        ChannelResultVController *theSegue = (ChannelResultVController *)segue.destinationViewController;
        if (btnTag == 1003) {
            [theSegue setValue:@"初查情况" forKey:@"resultType"];
            [theSegue takeReultText:^(NSString *result) {
                //回调
                NSLog(@"初查情况是:%@",result);
            }];
        }else if(btnTag == 1004){
            [theSegue setValue:@"处理情况" forKey:@"resultType"];
            [theSegue takeReultText:^(NSString *result) {
                //回调
                NSLog(@"处理情况:%@",result);
            }];
        }else{
            [theSegue setValue:@"处理结果" forKey:@"resultType"];
            [theSegue takeReultText:^(NSString *result) {
                //回调
                NSLog(@"处理结果:%@",result);
            }];
        }
    }
}


//点击背景取消
- (IBAction)tabBackground:(id)sender
{
    
}

//上报
- (IBAction)confirmUploadAction:(id)sender {
}
@end
