//
//  BaseBarChartViewController.m
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import "BaseBarChartViewController.h"

@interface BaseBarChartViewController ()<ChartViewDelegate>
@property (strong, nonatomic) BarChartView *barChartView;
@end

@implementation BaseBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kSCREEN_W, kSCREEN_H-60)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    self.barChartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, 60, kSCREEN_W, kSCREEN_H-60)];
    
    //  基本样式
    self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
    self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
    self.barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
    
    //  barChartView的交互设置
    self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
    self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.barChartView.dragEnabled = YES;//启用拖拽图表
    self.barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
    //    设置barChartView的X轴样式
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.axisLineWidth = 1;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    //    xAxis.spaceBetweenLabels = 4;//设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
    xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
    
    //    设置barChartView的Y轴样式,默认样式中会绘制左右两侧的Y轴
    self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis= self.barChartView.leftAxis;
    leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
    leftAxis.axisMinValue = 0;//设置Y轴的最小值
    leftAxis.axisMinValue = 0;//从0开始绘制
    leftAxis.axisMaxValue = 105;//设置Y轴的最大值
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineWidth = 0.5;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    
    //    设置Y轴上标签的样式，代码如下：
    leftAxis.labelCount = 5;
    leftAxis.forceLabelsEnabled = NO;
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    
    //    设置Y轴上网格线的样式
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
    self.barChartView.data = [self setData];
    [self.view addSubview:self.barChartView];
}
- (BarChartData *)setData {
    int xVals_count = 12;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals.count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i+1 y:val];
        [yVals addObject:entry];
    }
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"降水(mm)"];
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色(这个事不同颜色的数组，数组中有一个数据时，就是单一的颜色;也可以使用setColor这个函数，设置单一颜色)
    [set1 setColor:[UIColor cyanColor] alpha:0.5];//设置单一颜色
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc]initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    return data;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
