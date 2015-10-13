//
//  SelectDateCell.h
//  XiaKouStander
//  **********日期选择*************
//  Created by teddy on 15/10/13.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel; //时间显示
@property (weak, nonatomic) IBOutlet UIButton *forwardBtn;//前一天
@property (weak, nonatomic) IBOutlet UIButton *nextBtn; //后一天

@end
