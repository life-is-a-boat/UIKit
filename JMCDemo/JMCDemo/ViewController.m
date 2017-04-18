//
//  ViewController.m
//  JMCDemo
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_tableView;
    NSArray         *_items;
}
@end

@implementation ViewController
static NSString *identifer = @"UITableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifer];
    [self.view addSubview:_tableView];

    _items = [[NSArray alloc] initWithObjects:@"JMCKit",@"AsyImageView",@"BaiduMapKit",@"CAPSPageMenu",@"DBModel",@"DBValidator",@"HMSegmentedControl",@"KeychainItemWrapper",@"WeiXinSDK",@"AFNetworking",@"BTLabel",@"FMDB",@"GCPlaceholder",@"JCore",@"JGProgressHUD",@"JSONModel",@"LCCoolHUD",@"LCLoadingHUD",@"Masonry",@"MBProgressHUD",@"MJRefresh",@"Reachability",@"SDAutoLayout",@"SDCycleScrollView",@"SDWebImage",@"TPKeyboardAvoiding",@"VPImageCropper",@"XHPopMenu",@"YYKit",nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
