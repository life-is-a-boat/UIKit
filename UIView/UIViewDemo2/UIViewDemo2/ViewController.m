//
//  ViewController.m
//  UIViewDemo2
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "UIHistogramView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIHistogramView *brokenLineView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.brokenLineView.frame = CGRectMake(15., 44., self.view.bounds.size.width - 30., 225.);
    self.brokenLineView.backgroundColor = [UIColor brownColor];
    [self.brokenLineView YearHistogramView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
