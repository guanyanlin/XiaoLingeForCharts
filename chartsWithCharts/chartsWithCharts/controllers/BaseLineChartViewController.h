//
//  BaseLineChartViewController.h
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MymarkerView.h"

@interface BaseLineChartViewController : BaseViewController
@property (nonatomic,strong) UILabel *markY;
@property (nonatomic,strong) MymarkerView *markY2;
@property (nonatomic,strong) LineChartView *lineView;
@end
