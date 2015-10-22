//
//  RightLabelCell.h
//  XiaKouStander
//
//  Created by teddy on 15/10/22.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightLabelCell : UITableViewCell
//左边label
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//右边label
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
