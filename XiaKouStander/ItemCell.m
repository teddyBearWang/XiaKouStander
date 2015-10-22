//
//  ItemCell.m
//  XiaKouStander
//
//  Created by teddy on 15/10/12.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ItemCell.h"

@implementation ItemCell

//赋值
- (void)setLabelContext:(NSString *)name
{
    CGSize size = [name sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(self.frame.size.width, 200) lineBreakMode:NSLineBreakByWordWrapping];
    self.itemNameLabel.frame = (CGRect){self.itemNameLabel.frame.origin.x,self.itemNameLabel.frame.origin.y,self.itemNameLabel.frame.size.width,size.height};
    self.itemNameLabel.numberOfLines = 0;//允许多行
    self.itemNameLabel.text = name;

}

@end
