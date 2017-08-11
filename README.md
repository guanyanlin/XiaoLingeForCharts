# XiaoLingeForCharts

一、对于Charts第三方的集成步骤在此略过。
二、对于其中的一些疑难杂症以我自己的方式进行讲解：
	1、添加数据时，
	例如：
	NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 12; i++) {
        double val = (double)(arc4random_uniform(50));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        [yVals addObject:entry];
    }
	这种数据添加时其实就已经对x轴的数据进行了初始化和添加，因此不需要再次添加x数据，然后我们可以根据x轴的不同数据进行不同数据类型的显示。

	2、对X轴或者Y轴的不同数据格式的显示时一般有两种方法（用两个例子解释）：
		(1) 首先，ChartXAxis *xAxis = barChartView.xAxis;
		xAxis.valueFormatter = self;
			其次，类中实现代理方法
		- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    		NSString *result = [NSString stringWithFormat:@"第%d天",(int)value+1];
    		result = [_xLabels objectAtIndex:(NSInteger)value];
    	return result;
		}
		(2)首先，创建一个类实现IChartAxisValueFormatter的代理，
			XSymbolValueFormatter : NSObject<IChartAxisValueFormatter>
   		   其次，在m源文件中实现stringForValue的代理方法
   			- (NSString * _Nonnull)stringForValue:(double)value axis:(ChartAxisBase * _Nullable)axis {
    		NSString *result = [NSString stringWithFormat:@"第%d天",(int)value+1];
    		result = [_xLabels objectAtIndex:(NSInteger)value];
    		return result;
    	}

	3、坐标轴的线的宽度，线的颜色，显示的label数量显示(eg：xAxis.labelCount)；坐标轴距离上下左右的距离；坐标轴是否显示重复的数据；x轴上的数据的显示位置（xAxis.labelPosition）分为上方和下方；设置x和y轴是否允许缩放(scaleYEnabled，scaleXEnabled);设置图例（barChartView.legend）的：样式（form：圆形，线性，矩形，没有效果几种）、字体（颜色、大小等）、位置（position:左上角，右上角，左下角等等）、还有距离上下左右的距离（xOffset、yOffset);设置x轴和y轴是否显示网格线（就是在每个x轴点上的竖线，进行标识哪个点的哪个数据，实现数据的归属);x轴或者y轴的数据的字体(label的字体、颜色、大小等等)；为ChartView添加自定义的描述信息（自定义ChartDescription进行显现）；为x轴或者y轴添加控制线（控制线就是在数据的两边进行限定数据的位置的一些线），至于应用场景下面有具体的讲解，暂时不具体讲解，
		例如（以x轴添加控制线为例）：
			for (int i=0; i<45; i++) {
        		ChartLimitLine *limitLine = [[ChartLimitLine alloc]initWithLimit:i+0.5];
        		limitLine.lineWidth = 0.5f;
        		limitLine.lineColor = [UIColor lightGrayColor];
        		[xAxis addLimitLine:limitLine];
    		}

	4、有时候数据不显示或显示不正常时，很有可能你没有为x轴和y轴设置最大值(axisMaxValue)和最小值(axisMinValue);
	5、值得注意的是，当需要显示的效果在折线，或者柱状图的本身时，需要对不同的折线图，柱状图对应的DataSet进行设置；

三、下面以几个例子讲解一下具体实现效果的代码：

	1)、https://github.com/guanyanlin/XiaoLingeForCharts/blob/master/chartsWithCharts/image/lineEntryIcon.PNG

	这个效果其实很简单，就是通过添加数据时的Entry的icon属性：
	例如：//对应Y轴上面需要显示的数据
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


	2)、https://raw.githubusercontent.com/guanyanlin/XiaoLingeForCharts/master/chartsWithCharts/image/XAxisLabelinCenter.PNG
		

	这个其实就是添加了一下x轴上的控制线（具体的控制线添加方法，参照以上的步骤 5），为x轴上的点添加了数据的界限 线条，所以让人看起来像是x轴的数据在中间，其实仔细分析，x轴的数据根本没有变化，每一个x轴的label点还在原来位置，只不过只由于控制线的原因让其看起来位置像是移动了。
	使用场景：其实和其他的一般折线图的场景一样，表示某个具体时刻的数据大小；

	3)、https://github.com/guanyanlin/XiaoLingeForCharts/blob/master/chartsWithCharts/image/XaxisLabelRealinCenter.PNG


	相比于上面一个这个又有所不同，这个效果确实真的x轴的label的位置已到了中间，仔细看可以发现，x轴上的label数据的位置没有任何点；
	实现效果用了一个x轴的另一个属性：xAxis.centerAxisLabelsEnabled = YES;设置label在中间；
	使用场景：一般当x轴上的label表示的不是某个点的数据，而是某一段时间段的温度变化等，但是上面一个则是表示一个时间点（只能是某个时间点的最高温度，最低温度等）

	4)、https://github.com/guanyanlin/XiaoLingeForCharts/blob/master/chartsWithCharts/image/combinedChart.PNG


	这个其实也就是通过另一个混合视图，Charts自带的：CombinedChartView 初始化。然后通过
	CombinedChartData *data = [[CombinedChartData alloc] init];
    data.lineData = [self setData];
    data.barData = [self setDataForBar];
    _combineChart.data = data;
    这种方式分别设置折线和柱状图的数据等。


	4)、https://github.com/guanyanlin/XiaoLingeForCharts/blob/master/chartsWithCharts/image/sameXaxis.PNG


	这个难点就在于，两个视图进行的联动(当折线图滑动时柱状图也会跟着滑动，同理，柱状图滑动时折线图也会滑动)
	这种方式是通过两个视图实现的：
		<1>、上面一个折线图，下面一个柱状图;
		<2>、让柱状图的y轴进行翻转(leftAxis.inverted = YES)；
		<3>、对其中一个试图的x轴的数据不显示。(当然还有其他的一些线宽，颜色等的设置)
		通过以上三步我们的效果基本上已经出来了，现在最主要的是实现滑动时候的联动：
		通过
		lineChartView.delegate = self;
		barChartView.delegate = self;
		使两个视图的代理指向同一个代理方法，然后在滑动的代理方法中实现二者滑动（通过滑动时候的左侧的最小值，并配合视图滑动的 矢量距离dX 实现联动滑动）
		- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY {
		    [_lineView moveViewToX:(_barChartView.lowestVisibleX - dX)];
		    [_barChartView moveViewToX:(_lineView.lowestVisibleX - dX)];
		    [_lineView setNeedsDisplay];
		    [_barChartView setNeedsDisplay];
		}

(希望以上对大家有所帮助，有问题的话还望多多指正，谢谢支持)


