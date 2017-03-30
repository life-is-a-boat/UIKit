
//
//  AsynImageView.m
//  chepao
//
//  Created by ht on 14-8-27.
//  Copyright (c) 2014年 maxingxing. All rights reserved.
//

#import "AsynImageView.h"

@implementation AsynImageView
@synthesize imageURL = _imageURL;
@synthesize placeholderImage = _placeholderImage;
@synthesize fileName = _fileName;
@synthesize imageData=_imageData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.borderColor = [[UIColor grayColor] CGColor];
        self.layer.borderWidth = 0;
        self.placeholderImage = [UIImage imageNamed:@"acitvity_default_icon"];
    }
    return self;
}


-(void)awakeFromNib
{
    self.placeholderImage = [UIImage imageNamed:@"acitvity_default_icon"];
}

//重写placeholderImage的Setter方法
-(void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if(placeholderImage != _placeholderImage)
    {
        _placeholderImage = placeholderImage;
        self.image = _placeholderImage;    //指定默认图片
    }
}


-(void)setImageData:(NSData *)imageData
{
    if(imageData !=_imageData)
    {
        _imageData=imageData;
        self.image=[UIImage imageWithData:imageData];
    }
}


//重写imageURL的Setter方法
-(void)setImageURL:(NSString *)imageURL
{
    if(imageURL != _imageURL)
    {
       // self.image = _placeholderImage;    //指定默认图片
    }
    _imageURL = imageURL;
    if(imageURL.length>0)
    {
        //确定图片的缓存地址
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir=[path objectAtIndex:0];
        NSString *tmpPath=[docDir stringByAppendingPathComponent:@"AsynImage"];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if(![fm fileExistsAtPath:tmpPath])
        {
            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSArray *lineArray = [self.imageURL componentsSeparatedByString:@"/"];
        self.fileName = [NSString stringWithFormat:@"%@/%@", tmpPath, [lineArray objectAtIndex:[lineArray count] - 1]];
        
        //判断图片是否已经下载过，如果已经下载到本地缓存，则不用重新下载。如果没有，请求网络进行下载。
        if(![[NSFileManager defaultManager] fileExistsAtPath:_fileName])
        {
            if (testActivityIndicator==nil)
            {
                testActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            }
            testActivityIndicator.center = self.center;//只能设置中心，不能设置大小
            testActivityIndicator.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);//不建议这样设置，因为UIActivityIndicatorView是不能改变大小只能改变位置，这样设置得到的结果是控件的中心在（100，100）上，而不是和其他控件的frame一样左上角在（100， 100）长为100，宽为100.
            [self addSubview:testActivityIndicator];
            
            
            testActivityIndicator.color = [UIColor grayColor]; // 改变圈圈的颜色为红色； iOS5引入
            //[testActivityIndicator startAnimating]; // 开始旋转
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               //下载图片，保存到本地缓存中
                               [self loadImage];
                           });
        }
        else
        {
            //本地缓存中已经存在，直接指定请求的网络图片
            UIImage * img = [UIImage imageWithContentsOfFile:_fileName];
            if (img) {
                self.image = img;
            }
        }
    }else{
        self.image=[UIImage imageNamed:@"acitvity_default_icon"];
        
    }
}


//网络请求图片，缓存到本地沙河中
-(void)loadImage
{
    //[loadingSpinner stopAnimating];
    //对路径进行编码
    @try {
        //请求图片的下载路径
        //定义一个缓存cache
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        /*设置缓存大小为1M*/
        [urlCache setMemoryCapacity:1*124*1024];
        
        //设子请求超时时间为30s
        if(!self.imageURL){
            return;
        }
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.imageURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0*5];
        
        //从请求中获取缓存输出
        NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
        if(response != nil)
        {
            //            NSLog(@"如果又缓存输出，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        
        /*创建NSURLConnection*/
        if(!connection)
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        //开启一个runloop，使它始终处于运行状态
        
        UIApplication *app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = YES;
//
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    @catch (NSException *exception)
    {
        //        NSLog(@"没有相关资源或者网络异常");
    }
    @finally {
        ;//.....
    }
}

#pragma mark - NSURLConnection Delegate Methods
//请求成功，且接收数据(每接收一次调用一次函数)
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(loadData==nil)
    {
        loadData=[[NSMutableData alloc]initWithCapacity:2048];
    }
    [loadData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
    //    NSLog(@"将缓存输出");
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    //    NSLog(@"即将发送请求");
    return request;
}

//下载完成，将文件保存到沙河里面

-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    [testActivityIndicator stopAnimating]; // 结束旋转
    [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    [testActivityIndicator removeFromSuperview];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"DownLoadImageFinish" object:nil];
    
    //图片已经成功下载到本地缓存，指定图片
    if([loadData writeToFile:_fileName atomically:YES])
    {
        [self.delegate requestImageUrl:_fileName];
        UIImage * img = [UIImage imageWithContentsOfFile:_fileName];
        
        if (img && [img isKindOfClass:[UIImage class]])
        {
            [self setImage:img];
        }
    }
    connection = nil;
    loadData = nil;
}
//下面两段是重点，要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
    // NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
        
    }
    
}

//网络连接错误或者请求成功但是加载数据异常
-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    [testActivityIndicator stopAnimating]; // 结束旋转
    [testActivityIndicator setHidesWhenStopped:YES]; //当旋转结束时隐藏
    [testActivityIndicator removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DownLoadImageFail" object:self];

    //如果发生错误，则重新加载
    connection = nil;
    loadData = nil;
    //[self loadImage];
    //self.image = _placeholderImage;
    
}
@end
