//
//  MainItemCell.m
//  XiaKouStander
//
//  Created by teddy on 15/10/13.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "MainItemCell.h"

@implementation MainItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSelectAction:(BOOL)isYes
{
    if (isYes) {
        self.bg_view.layer.borderWidth = 0.5;
        self.bg_view.layer.borderColor = CELL_INTRUCTION_COLOR.CGColor;
        self.instructionView.backgroundColor = CELL_INTRUCTION_COLOR;
    }else{
        self.bg_view.layer.borderWidth = 0;
       // self.bg_view.layer.borderColor = nil;
        self.instructionView.backgroundColor = CELL_BG_COLOR;
    }
}


@end
