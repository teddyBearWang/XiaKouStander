//
//  WeatherView.h
//  XiaKouStander
//
//  Created by teddy on 15/10/13.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView
//天气图片
@property (weak, nonatomic) IBOutlet UIImageView *weatherStatusImageView;
//天气状态
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
//温度
@property (weak, nonatomic) IBOutlet UILabel *tempertureLabel;

@end
