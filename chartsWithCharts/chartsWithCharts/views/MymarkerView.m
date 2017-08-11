//
//  MymarkerView.m
//  MyStudyForLineAndBar
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import "MymarkerView.h"

@implementation MymarkerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        label1.text = @"Hello";
        [self addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, self.frame.size.width, 20)];
        label2.text = @"Hello2222";
        [self addSubview:label2];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
