//
//  LineAndBarWithSameXViewController.m
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import "LineAndBarWithSameXViewController.h"

@interface LineAndBarWithSameXViewController ()<ChartViewDelegate>

@property (nonatomic,strong) LineChartView *lineView;
@property (nonatomic,strong) BarChartView *barChartView;

@end

@implementation LineAndBarWithSameXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLineChartView];
    [self createBarChartView];

}
- (void)createBarChartView {
    if(self.barChartView){
        [self.barChartView removeFromSuperview];
    }
    self.barChartView = [[BarChartView alloc]initWithFrame:CGRectMake(0, kSCREEN_H/2, kSCREEN_W, kSCREEN_H/2)];
    //  基本样式
    _barChartView.delegate = self;//设置代理
    self.barChartView.backgroundColor =  [UIColor blackColor];
    self.barChartView.alpha = 0.4;
    self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
    self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
    self.barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
    self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
    _barChartView.scaleXEnabled = NO;
    self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.barChartView.dragEnabled = YES;//启用拖拽图表
    self.barChartView.dragDecelerationEnabled = NO;//拖拽后是否有惯性效果
    self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    _barChartView.legend.enabled = YES;//这个是对折线的图例显示
    [_barChartView animateWithXAxisDuration:1.0f];
    _barChartView.legend.form = ChartLegendFormCircle;//设置图例的样式
    _barChartView.legend.textColor = [UIColor whiteColor];
    
    //设置barChartView的Y轴样式,默认样式中会绘制左右两侧的Y轴
    self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis= self.barChartView.leftAxis;
    leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    leftAxis.axisMinValue = 0;//设置Y轴的最小值
    leftAxis.axisLineWidth = 3.0f;
    leftAxis.inverted = YES;
    leftAxis.axisMaxValue = 105;//设置Y轴的最大值
    leftAxis.axisLineColor = [UIColor whiteColor];//Y轴颜色
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor whiteColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    leftAxis.gridColor = [UIColor grayColor];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
    //  设置X轴
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.axisLineWidth = 3.0f;
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.labelPosition= XAxisLabelPositionTop;//设置x轴数据在底部
    xAxis.gridColor = [UIColor grayColor];
    xAxis.labelTextColor = [UIColor whiteColor];//文字颜色
    xAxis.axisLineColor = [UIColor whiteColor];
    xAxis.axisMinValue = 0.5;
    xAxis.axisMaxValue = 12.5;
    
    self.barChartView.data = [self setBarChartData];
    [_barChartView zoomWithScaleX:2.2 scaleY:0 x:0 y:0];
    [self.view addSubview:self.barChartView];
}
- (BarChartData *)setBarChartData {
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 12; i++) {
        double val = (double)(arc4random_uniform(90));
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:val];
        [yVals addObject:entry];
    }
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals];
    set1.label = @"降水(mm)";
    set1.drawValuesEnabled = NO;//是否在柱形图上面显示数值
    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色(这个事不同颜色的数组，数组中有一个数据时，就是单一的颜色;也可以使用setColor这个函数，设置单一颜色)
    [set1 setColor:[UIColor cyanColor] alpha:0.5];//设置单一颜色
    //将BarChartDataSet对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
    BarChartData *data = [[BarChartData alloc]initWithDataSets:dataSets];
    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
    return data;
}


- (void)createLineChartView {
    if(self.lineView){
        [self.lineView removeFromSuperview];
    }
    _lineView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 60, kSCREEN_W, kSCREEN_H/2-60)];
    _lineView.delegate = self;//设置代理
    _lineView.backgroundColor =  [UIColor blackColor];
    _lineView.alpha = 0.4;
    _lineView.noDataText = @"暂无数据";
    _lineView.scaleYEnabled = NO;//取消Y轴缩放
    _lineView.scaleXEnabled = NO;
    _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
    _lineView.dragEnabled = YES;//启用拖拽图标
    _lineView.dragDecelerationEnabled = NO;//拖拽后是否有惯性效果
    _lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    //描述及图例样式
    _lineView.legend.enabled = YES;//这个是对折线的图例显示
    [_lineView animateWithXAxisDuration:1.0f];
    _lineView.legend.form = ChartLegendFormCircle;//设置图例的样式
    _lineView.legend.textColor = [UIColor whiteColor];
    _lineView.legend.position = ChartLegendPositionAboveChartRight;
    
    
    //     设置Y轴
    _lineView.rightAxis.enabled = NO;//不绘制右边轴
    _lineView.leftAxis.enabled = YES;//不绘制右边轴
    ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
    leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    leftAxis.axisMinValue = 0;//设置Y轴的最小值
    leftAxis.axisLineWidth = 3.0f;
    leftAxis.axisMaxValue = 105;//设置Y轴的最大值
    leftAxis.axisLineColor = [UIColor whiteColor];//Y轴颜色
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor whiteColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    leftAxis.gridColor = [UIColor grayColor];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
    //  设置X轴
    ChartXAxis *xAxis = _lineView.xAxis;
    xAxis.axisLineWidth = 3.0f;
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
    xAxis.gridColor = [UIColor grayColor];
    xAxis.labelTextColor = [UIColor whiteColor];//文字颜色
    xAxis.axisLineColor = [UIColor whiteColor];
    xAxis.axisMinValue = 0.5;
    xAxis.axisMaxValue = 12.5;
    
    
    _lineView.data = [self setLineChartData];  //设置折线图的数据
    [_lineView zoomWithScaleX:2.2 scaleY:0 x:0 y:0];
    [self.view addSubview:_lineView];

}
- (LineChartData *)setLineChartData {
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 12; i++) {
        double val = (double)(arc4random_uniform(20));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        [yVals1 addObject:entry];
    }
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 12; i++) {
        double val = (double)(arc4random_uniform(90));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        [yVals2 addObject:entry];
    }
    
    
    {
        //添加第二个LineChartDataSet对象
        //创建LineChartDataSet对象
        LineChartDataSet *set1 = [[LineChartDataSet alloc]initWithValues:yVals1];
        set1.label = @"全年空气湿度走势图";
        //设置折线的样式
        set1.lineWidth = 2.0;//折线宽度
        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        [set1 setColor:[UIColor yellowColor]];//折线颜色
        set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.drawFilledEnabled = YES;//是否填充颜色
        
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
        set1.label = @"全年空气湿度走势图2";
        set2.values = yVals2;
        set2.valueColors = @[[UIColor purpleColor]];//折线拐点处显示数据的颜色
        [set2 setColor:[UIColor greenColor]];//折线颜色
        set2.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        set2.fillColor = [UIColor redColor];
        set2.highlightEnabled = YES;
        [set2 setMode:LineChartModeCubicBezier];//对线条的类型进行设置（LineChartModeLinear普通,LineChartModeStepped阶梯,LineChartModeCubicBezier圆形线条,LineChartModeHorizontalBezier圆形线条,）
        set2.fillAlpha = 0.1;
        set2.highlightColor = [UIColor greenColor];
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        //        LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:[UIColor orangeColor]];//文字颜色
        return data;
    }
    
}
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"");
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    NSLog(@"");
}
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    NSLog(@"");
}
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
    [_lineView moveViewToX:(_barChartView.lowestVisibleX - dX)];
    [_barChartView moveViewToX:(_lineView.lowestVisibleX - dX)];
    [_lineView setNeedsDisplay];
    [_barChartView setNeedsDisplay];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
