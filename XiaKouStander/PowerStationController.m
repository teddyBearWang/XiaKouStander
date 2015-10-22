//
//  PowerStationController.m
//  XiaKouStander
//  *********电站主界面**********
//  Created by teddy on 15/10/22.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "PowerStationController.h"
#import "ItemCell.h"

@interface PowerStationController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_itemList;//数据源
}

@property (weak, nonatomic) IBOutlet UITableView *itemTable;

@end

@implementation PowerStationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemTable.delegate = self;
    self.itemTable.dataSource = self;
    
    _itemList = @[@"安全工器定期检查记录",@"安全工器定期试验记录表",@"设备检修和试验登记表",@"设备试验或轮换记录",@"应急设备定期检查试验记录"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _itemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _itemList[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            //安全工器定期检查记录s
            [self performSegueWithIdentifier:@"regularInspection" sender:nil];
        }
            break;
        case 1:
        {
            //安全工器定期试验记录表
            [self performSegueWithIdentifier:@"regularTest" sender:nil];
        }
            break;
        case 2:
        {
            //设备检修和试验登记表
            [self performSegueWithIdentifier:@"machineCheck" sender:nil];
        }
            break;
        case 3:
        {
            //设备轮换检查记录
            [self performSegueWithIdentifier:@"rotationEquaipment" sender:nil];
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
}
@end
