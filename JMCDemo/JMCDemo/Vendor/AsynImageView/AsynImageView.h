//
//  AsynImageView.h
//  chepao
//
//  Created by ht on 14-8-27.
//  Copyright (c) 2014年 maxingxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol requestSucessDelegate;
@interface AsynImageView : UIImageView
{
    NSURLConnection *connection;
    NSMutableData *loadData;
    UIActivityIndicatorView *testActivityIndicator;
}



//图片对应的缓存在沙河中的路径
@property (nonatomic, strong) NSString *fileName;
@property(nonatomic,assign)id<requestSucessDelegate>delegate;
//指定默认未加载时，显示的默认图片
@property (nonatomic, strong) UIImage *placeholderImage;
//请求网络图片的URL
@property (nonatomic, strong) NSString *imageURL;
@property(nonatomic,retain)NSData *imageData;

@end
@protocol requestSucessDelegate <NSObject>

-(void)requestImageUrl:(NSString *)filename;

@end
