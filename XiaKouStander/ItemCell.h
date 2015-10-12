//
//  ItemCell.h
//  XiaKouStander
//
//  Created by teddy on 15/10/12.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UICollectionViewCell
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

//文字
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@end
