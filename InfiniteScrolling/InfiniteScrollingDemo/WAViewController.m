//
//  WAViewController.m
//  TableViewTransformDemo
//
//  Created by Jayaprada Behera on 30/01/14.
//  Copyright (c) 2014 Webileapps. All rights reserved.
//

#import "WAViewController.h"
#import "WAInfiniteTableView.h"


@interface WAViewController ()
@end

@implementation WAViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *fullURL1 = @"http://google.com";
    NSURL *url1= [NSURL URLWithString:fullURL1];
    NSURLRequest *requestObj1 = [NSURLRequest requestWithURL:url1];

    NSString *fullURL2 = @"http://yahoo.com";
    NSURL *url2 = [NSURL URLWithString:fullURL2];
    NSURLRequest *requestObj2 = [NSURLRequest requestWithURL:url2];

    NSString *fullURL3 = @"http://gmail.com";
    NSURL *url3 = [NSURL URLWithString:fullURL3];
    NSURLRequest *requestObj3 = [NSURLRequest requestWithURL:url3];

    NSString *fullURL4 = @"http://facebook.com";
    NSURL *url4 = [NSURL URLWithString:fullURL4];
    NSURLRequest *requestObj4 = [NSURLRequest requestWithURL:url4];

    UIWebView *_webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_webView1 loadRequest:requestObj1];
    UIWebView *_webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_webView2 loadRequest:requestObj2];
    UIWebView *_webView3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_webView3 loadRequest:requestObj3];
    UIWebView *_webView4 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_webView4 loadRequest:requestObj4];
  
    
    NSMutableArray *viewList = [[NSMutableArray alloc]initWithObjects:_webView1,_webView2,_webView3,_webView4,nil ];
   
    WAInfiniteTableView *_tableView = [[WAInfiniteTableView alloc]initWithFrame:self.view.bounds andCellWidth:ROW_WIDTH andviews:viewList];
    [self.view addSubview:_tableView];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
