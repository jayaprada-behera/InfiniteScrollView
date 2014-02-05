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

    UIWebView *_view1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_view1 loadRequest:requestObj1];
    UIWebView *_view2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_view2 loadRequest:requestObj2];
    UIWebView *_view3 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_view3 loadRequest:requestObj3];
    UIWebView *_view4 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
    [_view4 loadRequest:requestObj4];
  
    
//    UILabel *_view1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
//    UILabel *_view2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
//    UILabel *_view3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
//    UILabel *_view4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];
//    
//    UILabel *_view5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ROW_WIDTH, self.view.bounds.size.height)];

    _view1.tag = 0;
    _view2.tag = 1;
    _view3.tag = 2;
    _view4.tag = 3;

//    view1.text =[NSString stringWithFormat:@"Tag %ld",(long)_view1.tag];
//    view2.text =[NSString stringWithFormat:@"Tag %ld",(long)_view2.tag];
//    view3.text = [NSString stringWithFormat:@"Tag %ld",(long)_view3.tag];
//    view4.text =[NSString stringWithFormat:@"Tag %ld",(long)_view4.tag];

    _view1.backgroundColor = [UIColor lightGrayColor];
    _view2.backgroundColor = [UIColor grayColor];
    _view3.backgroundColor = [UIColor greenColor];
    _view4.backgroundColor = [UIColor redColor];

    NSMutableArray *viewList = [[NSMutableArray alloc]initWithObjects:_view1,_view2,_view3,_view4, nil ];
   
    WAInfiniteTableView *_tableView = [[WAInfiniteTableView alloc]initWithFrame:self.view.bounds andCellWidth:ROW_WIDTH andviews:viewList];
    [self.view addSubview:_tableView];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutoRotate
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
