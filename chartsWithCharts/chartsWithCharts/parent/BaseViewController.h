//
//  BaseViewController.h
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chartsWithCharts-Bridging-Header.h"

#define kSCREEN_W [UIScreen mainScreen].bounds.size.width
#define kSCREEN_H [UIScreen mainScreen].bounds.size.height

@interface BaseViewController : UIViewController
@property (strong, nonatomic) UIButton *backBtn;
//- (void)onClickBack:(UIButton *)sender;
@end
