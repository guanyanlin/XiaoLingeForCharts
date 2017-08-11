//
//  CombinedChartViewController.m
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import "CombinedChartViewController.h"

@interface CombinedChartViewController ()
@property (nonatomic, strong) CombinedChartView *combineChart;
@end

@implementation CombinedChartViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _combineChart = [[CombinedChartView alloc]initWithFrame:CGRectMake(0, 60, kSCREEN_W, kSCREEN_H-60)];
    _combineChart.backgroundColor = [UIColor blackColor];
    _combineChart.alpha = 0.4;
    _combineChart.descriptionText = @"";
    _combineChart.pinchZoomEnabled = YES;
    _combineChart.marker = [[ChartMarkerView alloc] init];
    //    _combineChart.drawOrder = @[@0,@0,@2];//CombinedChartDrawOrderBar,CombinedChartDrawOrderLine 绘制顺序
    _combineChart.doubleTapToZoomEnabled = NO;//取消双击放大
    _combineChart.scaleYEnabled = NO;//取消Y轴缩放
    _combineChart.dragEnabled = YES;//启用拖拽图表
    _combineChart.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    _combineChart.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    _combineChart.highlightPerTapEnabled = NO;//取消单击高亮显示
    _combineChart.highlightPerDragEnabled = NO;//取消拖拽高亮
    ChartXAxis *xAxis = _combineChart.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelFont = [UIFont systemFontOfSize:15];
    xAxis.labelTextColor = [UIColor whiteColor];
    xAxis.labelCount = 999;
    xAxis.labelRotationAngle = -40;
    xAxis.axisMinValue = -0.5;
    
    
    //左侧Y轴设置
    ChartYAxis *leftAxis = _combineChart.leftAxis;
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.axisMinValue = 0.0f;
    leftAxis.drawGridLinesEnabled = YES;
    
    //右侧Y轴
    ChartYAxis *rightAxis = _combineChart.rightAxis;
    rightAxis.labelPosition = YAxisLabelPositionOutsideChart;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinValue = -1.5;
    rightAxis.axisMaxValue = 100;
    //设置图例
    ChartLegend *legend = _combineChart.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    legend.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    legend.orientation = ChartLegendOrientationHorizontal;
    legend.drawInside = NO;
    legend.direction = ChartLegendDirectionLeftToRight;
    legend.form = ChartLegendFormLine;
    legend.textColor = [UIColor whiteColor];
    legend.formSize = 12;
    //设置数据
    
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.lineData = [self setData];
    data.barData = [self setDataForBar];
    _combineChart.data = data;
    _combineChart.extraBottomOffset = 10;
    _combineChart.extraTopOffset = 30;
    [_combineChart animateWithYAxisDuration:1.0];//添加Y轴动画
    LineChartView *lineChartView = (LineChartView *)_combineChart.viewForFirstBaselineLayout;
    lineChartView.leftAxis.inverted = NO;
    [self.view addSubview:_combineChart];
}

- (BarChartData *)setDataForBar {
    //    double maxYVal = 100;//Y轴的最大值
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i++) {
        double val = (double)arc4random_uniform(40);
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:val];
        [yVals addObject:entry];
    }
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals];
    set1.label = @"降水量(mm)";
    //    set1.barSpace = 0.2;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
    set1.drawIconsEnabled = YES;
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    //    [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色
    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithRed:140 green:80 blue:120 alpha:0.4], nil];
    [set1 setColors:colors];//设置柱形图颜色
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc]initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    
    return data;
}
- (LineChartData*)setData {
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 12; i++) {
        double val = (double)arc4random_uniform(50);
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        [yVals addObject:entry];
    }
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 12; i++) {
        double val = (double)(arc4random_uniform(20));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        [yVals2 addObject:entry];
    }
    
    //添加第二个LineChartDataSet对象
    //创建LineChartDataSet对象
    LineChartDataSet *set1 = [[LineChartDataSet alloc]initWithValues:yVals label:@"全年空气湿度走势图1"];
    //设置折线的样式
    set1.lineWidth = 1.3;//折线宽度
    set1.drawValuesEnabled = YES;//是否在拐点处显示数据
    set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
    [set1 setColor:[UIColor colorWithRed:92 green:92 blue:92 alpha:0.5]];//折线颜色
    set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
    //折线拐点样式
    set1.drawCirclesEnabled = YES;//是否绘制拐点
    set1.circleRadius = 4.0f;//拐点半径
    set1.circleColors = @[[UIColor redColor], [UIColor greenColor]];//拐点颜色
    //拐点中间的空心样式
    set1.drawCircleHoleEnabled = YES;//是否绘制中间的空心
    set1.circleHoleRadius = 2.0f;//空心的半径
    set1.circleHoleColor = [UIColor blackColor];//空心的颜色
    //折线的颜色填充样式
    //第一种填充样式:单色填充
    //         set1.drawFilledEnabled = YES;//是否填充颜色
    //         set1.fillColor = [UIColor redColor];//填充颜色
    // set1.fillAlpha = 0.3;//填充颜色的透明度
    //第二种填充样式:渐变填充
    set1.drawFilledEnabled = NO;//是否填充颜色
    
    NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
    CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    set1.fillAlpha = 0.3f;//透明度
    set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef);//释放gradientRef
    //点击选中拐点的交互样式
    set1.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    set1.highlightColor = [UIColor blueColor];//点击选中拐点的十字线的颜色
    set1.highlightLineWidth = 1.0/[UIScreen mainScreen].scale;//十字线宽度
    set1.highlightLineDashLengths = @[@5, @5];//十字线的虚线样式
    
    LineChartDataSet *set2 = [set1 copy];
    set2.values = yVals2;
    set2.valueColors = @[[UIColor purpleColor]];//折线拐点处显示数据的颜色
    [set2 setColor:[UIColor blueColor]];//折线颜色
    set2.drawFilledEnabled = YES;
    set2.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
    set2.fillColor = [UIColor redColor];
    set2.highlightEnabled = YES;
    [set2 setMode:LineChartModeCubicBezier];//对线条的类型进行设置（LineChartModeLinear普通,LineChartModeStepped阶梯,LineChartModeCubicBezier圆形线条,LineChartModeHorizontalBezier圆形线条,）
    set2.fillAlpha = 0.1;
    set2.highlightColor = [UIColor greenColor];
    set2.label = @"全年降水走势图2";
    
    set2.drawCirclesEnabled = NO;
    set2.drawCircleHoleEnabled = NO;
    //将 LineChartDataSet 对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    //        [dataSets addObject:set3];
    //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
    //        LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];//文字字体
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    return data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
