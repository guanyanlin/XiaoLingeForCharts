//
//  BaseViewController.m
//  chartsWithCharts
//
//  Created by xiaolinge on 2017/8/10.
//  Copyright © 2017年 xiaolinge. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)onClickBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.frame];
    bgView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:bgView];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_W, 56)];
    titleView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:titleView];
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
    [_backBtn setTitle:@"back" forState:UIControlStateNormal];
    _backBtn.titleLabel.textColor = [UIColor blueColor];
    [self.backBtn addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
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
