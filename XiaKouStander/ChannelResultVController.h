//
//  ChannelResultVController.h
//  XiaKouStander
//
//  Created by teddy on 15/11/6.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "RootViewController.h"

typedef void(^ReturnBlock)(NSString *result) ;
@interface ChannelResultVController : RootViewController

@property (nonatomic, strong) NSString *resultType;//传入的类型

@property (nonatomic, assign) ReturnBlock returnBlock;

- (void)takeReultText:(ReturnBlock)block;

@end
