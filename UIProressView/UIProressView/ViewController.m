//
//  ViewController.m
//  UIProressView
//
//  Created by mac on 2017/4/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "UIProgessView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UISlider *progressView = [[UISlider alloc] init];
//    progressView.center = self.view.center;
//    progressView.bounds = CGRectMake(0., 0., 300., 45.);
    self.slider.minimumValue = 0.;
    self.slider.maximumValue = 100.;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
