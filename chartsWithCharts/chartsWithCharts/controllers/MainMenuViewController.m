//
//  MainMenuViewController.m
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnWithEntryIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnOfBaseBarChart;
@property (weak, nonatomic) IBOutlet UIButton *btnLineBarWithSameXAxis;
@property (weak, nonatomic) IBOutlet UIButton *btnOfBaseLineCharts;
@property (weak, nonatomic) IBOutlet UIButton *btnOfCombinedChart;

@end

@implementation MainMenuViewController

- (IBAction)toLineChartWithEntryIcon:(id)sender {
    [self presentViewController:[[LineChartWithIconViewController alloc]init] animated:YES completion:nil];
}
- (IBAction)toBaseBarChart:(id)sender {
    [self presentViewController:[[BaseBarChartViewController alloc]init] animated:YES completion:nil];
}
- (IBAction)toLineAndBarWithSameX:(id)sender {
    [self presentViewController:[[LineAndBarWithSameXViewController alloc]init] animated:YES completion:nil];
}
- (IBAction)toBaseLineChart:(id)sender {
    [self presentViewController:[[BaseLineChartViewController alloc]init] animated:YES completion:nil];
}
- (IBAction)toCombinedChart:(id)sender {
    [self presentViewController:[[CombinedChartViewController alloc]init] animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
