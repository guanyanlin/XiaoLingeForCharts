//
//  LineChartWithIconViewController.m
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import "LineChartWithIconViewController.h"
#import "MymarkerView.h"

@interface LineChartWithIconViewController ()
@property (nonatomic,strong) UILabel *markY;
@property (nonatomic,strong) MymarkerView *markY2;
@property (nonatomic,strong) LineChartView *lineView;
@end

@implementation LineChartWithIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LineChartView *lineView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 60, kSCREEN_W, kSCREEN_H-60)];
    lineView.delegate = self;//设置代理
    lineView.backgroundColor =  [UIColor whiteColor];
    lineView.noDataText = @"暂无数据";
    lineView.chartDescription.enabled = YES;
    lineView.scaleYEnabled = NO;//取消Y轴缩放
    lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
    lineView.dragEnabled = YES;//启用拖拽图标
    lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
    lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    //描述及图例样式
    [lineView setDescriptionText:@"这是一个练习的折线图"];//这个是该折线图的标题内容
    lineView.legend.enabled = YES;//这个是对折线的图例显示
    [lineView animateWithXAxisDuration:1.0f];
    
    //     设置Y轴
    lineView.rightAxis.enabled = NO;//不绘制右边轴
    ChartYAxis *leftAxis = lineView.leftAxis;//获取左边Y轴
    leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    leftAxis.axisMinValue = 0;//设置Y轴的最小值
    leftAxis.axisMaxValue = 105;//设置Y轴的最大值
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    leftAxis.gridColor = [UIColor grayColor];//网格线颜色
    leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
    
    
    //  设置X轴
    ChartXAxis *xAxis = lineView.xAxis;
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
    xAxis.gridColor = [UIColor grayColor];
    xAxis.labelTextColor = [UIColor blackColor];//文字颜色
    xAxis.axisLineColor = [UIColor grayColor];
    lineView.maxVisibleCount = 999;//设置能够显示的数据数量
    xAxis.axisMinValue = 1;
    ChartMarkerView *markerY = [[ChartMarkerView alloc]init];
    markerY.offset = CGPointMake(0, 0);
    markerY.chartView = lineView;
    lineView.marker = markerY;
    //    xAxis.valueFormatter = nil;
    
    [markerY addSubview:self.markY2];
    
    _lineView = lineView;
    _lineView.data = [self setData];  //设置折线图的数据
    
    [self.view addSubview:_lineView];
    
}
- (LineChartData *)setData {
    int xVals_count = 12;//X轴上要显示多少条数据
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 12; i++) {
        double val = 0;
        if(i%5==0){
            val = i+30.5;
        }else if(i%5==1){
            val = i+22.478;
        }else if(i%5==2){
            val = i+50;
        }else if(i%5==3){
            val = i+18.45;
        }else if(i%5==4){
            val = i+41.52;
        }
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        [yVals addObject:entry];
    }
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    for (int i = 1; i <= xVals_count; i++) {
        double val = (double)(arc4random_uniform(10));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        if(i%4==0){
            [entry setIcon:[UIImage imageNamed:@"southWest"]];
        }else if(i%4==1){
            [entry setIcon:[UIImage imageNamed:@"southEast"]];
        }else if(i%4==2){
            [entry setIcon:[UIImage imageNamed:@"northWest"]];
        }else if(i%4==3){
            [entry setIcon:[UIImage imageNamed:@"northEast"]];
        }
        [yVals2 addObject:entry];
    }
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    for (int i = 1; i <= xVals_count; i++) {
        double val = (double)(arc4random_uniform(90));
        if(i%4==0){
            val = 90;
        }else if(i%4==1){
            val = 88;
        }else if(i%4==2){
            val = 91;
        }else if(i%4==3){
            val = 89;
        }
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        
        [yVals3 addObject:entry];
    }
    
    
    LineChartDataSet *set1 = nil;
    if (self.lineView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)self.lineView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        return data;
    }else{
        //添加第二个LineChartDataSet对象
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc]initWithValues:yVals label:@"全年空气湿度走势图"];
        //设置折线的样式
        set1.lineWidth = 5.0/[UIScreen mainScreen].scale;//折线宽度
        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        [set1 setColor:[UIColor redColor]];//折线颜色
        set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
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
        set1.drawFilledEnabled = YES;//是否填充颜色
        
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#FF007FFF"].CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fillAlpha = 0.3f;//透明度
        set1.lineWidth = 3.0;
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
        set2.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        set2.fillColor = [UIColor redColor];
        set2.highlightEnabled = YES;
        [set2 setMode:LineChartModeCubicBezier];//对线条的类型进行设置（LineChartModeLinear普通,LineChartModeStepped阶梯,LineChartModeCubicBezier圆形线条,LineChartModeHorizontalBezier圆形线条,）
        set2.fillAlpha = 0.1;
        set2.highlightColor = [UIColor greenColor];
        set2.label = @"全年降水走势图";
        
        
        
        LineChartDataSet *set3 = [set1 copy];
        set3.values = yVals3;
        set3.valueColors = @[[UIColor purpleColor]];//折线拐点处显示数据的颜色
        set3.valueTextColor = [UIColor grayColor];
        [set3 setColor:[UIColor greenColor]];//折线颜色
        set3.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        set3.drawCirclesEnabled = YES;//是否显示拐角处的原点（还可设置拐角处的原点的半径）
        set3.drawIconsEnabled = YES;
        set3.fillColor = [UIColor clearColor];
        set3.highlightEnabled = YES;
        set3.fillAlpha = 0.1;
        set3.highlightColor = [UIColor greenColor];
        set3.label = @"全年降水走势图";
        //        LineRadarChartRenderer
        
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        [dataSets addObject:set3];
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        //        LineChartData *data = [[LineChartData alloc] initWithXVals:xVals dataSets:dataSets];
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];//文字字体
        [data setValueTextColor:[UIColor orangeColor]];//文字颜色
        return data;
    }
    
}
//懒加载,这个是折线图点击选中后的那个显示的数值的区域（就是一个UILabel）
- (UIView *)markY2{
    if (!_markY2) {
        _markY2 = [[MymarkerView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
        _markY2.backgroundColor = [UIColor orangeColor];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        label1.text = @"Hello";
        [_markY2 addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 100, 20)];
        label2.text = @"Hello2222";
        [_markY2 addSubview:label2];
        
    }
    return _markY2;
}

#pragma mark --ChartViewDelegate的代理方法
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"chartValueSelected");
    _markY.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];//改变选中的数据时候，label的值跟着变化
    //将点击的数据滑动到中间
    [_lineView centerViewToAnimatedWithXValue:highlight.drawX yValue:highlight.drawX axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    NSLog(@"chartValueNothingSelected");
}
- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY {
    NSLog(@"chartScaled");
}
- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
    NSLog(@"chartTranslated");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
