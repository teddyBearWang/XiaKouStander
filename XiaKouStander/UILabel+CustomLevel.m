//
//  UILabel+CustomLevel.m
//  XiaKouStander
//  *******label的高度随着内容的变多而变化*************
//  Created by teddy on 15/10/26.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "UILabel+CustomLevel.h"

@implementation UILabel (CustomLevel)

//在storyboard中。当label距离左右和顶部的距离限制的时候。会自动适应高度的
- (void)setLabelContentWithName:(NSString *)name
{
    //本身的尺寸
    self.text = name;
    self.numberOfLines = 0;//允许多行
    self.lineBreakMode = NSLineBreakByWordWrapping;
}

@end
