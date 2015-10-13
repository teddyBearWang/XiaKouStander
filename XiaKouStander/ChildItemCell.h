//
//  ChildItemCell.h
//  XiaKouStander
//  ***********子列表cell**********
//  Created by teddy on 15/10/13.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UISwitch *tapSelect;

@end
