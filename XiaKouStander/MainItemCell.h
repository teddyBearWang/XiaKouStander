//
//  MainItemCell.h
//  XiaKouStander
//  ***********主列表cell**********
//  Created by teddy on 15/10/13.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainItemCell : UITableViewCell
//背景视图
@property (weak, nonatomic) IBOutlet UIView *bg_view;
//指示视图
@property (weak, nonatomic) IBOutlet UIView *instructionView;
//名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)setSelectAction:(BOOL)isYes;

@end
