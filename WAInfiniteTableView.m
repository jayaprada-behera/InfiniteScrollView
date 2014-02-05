//
//  WAInfiniteTableView.m
//  TableViewTransformDemo
//
//  Created by Jayaprada Behera on 04/02/14.
//  Copyright (c) 2014 Webileapps. All rights reserved.
//

#import "WAInfiniteTableView.h"

@interface WAInfiniteTableView (){
    float currOffsetY;
    NSMutableArray *views;
    UIPageControl *pageControl_;
    BOOL neg_velocity;
    BOOL isFastScrolling;
    
}
@end

@implementation WAInfiniteTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        views = [[NSMutableArray alloc] init];
        neg_velocity = NO;
        isFastScrolling = NO;

    }
    return self;
}
-(id)initWithFrame:(CGRect)frame andCellWidth:(CGFloat )width andviews:(NSArray *)views_{
    
    self = [self initWithFrame:frame];
    if (self != nil) {
        
    // Initialization code
    _infiniteTableView = [[UITableView alloc] init] ;
        pageControl_  = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        pageControl_.numberOfPages = views_.count;
        pageControl_.currentPage = 0;
        
        pageControl_.backgroundColor = [UIColor blackColor];
        [self addSubview:pageControl_];

    CGRect frame1 = frame;
    _infiniteTableView.transform = CGAffineTransformMakeRotation(-M_PI/2.0);
    _infiniteTableView.frame = frame1;
    
    [_infiniteTableView setDataSource: self];
    [_infiniteTableView setDelegate:self];
    
    [self addSubview:_infiniteTableView];
    
    [_infiniteTableView setShowsVerticalScrollIndicator:NO];

    for (int i= 1; i <= TOTAL_NUMBER_OF_ROWS/views_.count; i++) {
        [views addObjectsFromArray:views_];
    }
    
    //Scroll the tableview  to the middle of total number of  rows

    int row = TOTAL_NUMBER_OF_ROWS/2-(TOTAL_NUMBER_OF_ROWS/2%views_.count);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [_infiniteTableView scrollToRowAtIndexPath:indexPath
                              atScrollPosition:UITableViewScrollPositionMiddle
                                      animated:YES];
    }
    return self;
}
#pragma mark - UITABLEVIEW


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return TOTAL_NUMBER_OF_ROWS;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI/2.0);
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.contentView addSubview:[views objectAtIndex:indexPath.row]];
    return cell;
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ROW_WIDTH;
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView {
    NSArray *visibleCells = [tableView visibleCells];
    
    if (visibleCells.count == 2) {//If scroll is stopped at the middle of the two cells then scroll to a particual position to in the middle of 3 cells
        
        NSIndexPath *indexPath = [_infiniteTableView indexPathForRowAtPoint:CGPointMake(_infiniteTableView.contentOffset.x, _infiniteTableView.contentOffset.y + ROW_WIDTH)];
        [_infiniteTableView scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionMiddle
                                          animated:YES];
        
    }else if (isFastScrolling) {
        
        isFastScrolling = NO;
        NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:CGPointMake(tableView.contentOffset.x, tableView.contentOffset.y +ROW_WIDTH)];
        [tableView scrollToRowAtIndexPath:indexPath
                         atScrollPosition:UITableViewScrollPositionMiddle
                                 animated:YES];
    }
    //page control current page calculation
    
    [self setCurrentPageForPageControl];
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    NSLog(@"Scroll Contectoffset:%f", scrollView.contentOffset.y);
    currOffsetY = scrollView.contentOffset.y;
}

-(void) scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset {
        
    NSLog(@"offset %f,velocity.x %f,targetcontentOffset %f",scrollView.contentOffset.y,fabs(velocity.y),targetContentOffset->y);
   
    CGFloat multipleFactor = 1.0f;
    if (velocity.y <0) {
        neg_velocity = YES;

        multipleFactor = -1.0f;
    }else{
        neg_velocity = NO;

    }
    if (fabs(velocity.y) > 0.5f && fabs(velocity.y) < 1.5f  ) {
        
        targetContentOffset->y = currOffsetY+ multipleFactor*ROW_WIDTH;
        NSLog(@"target Contectoffset:%f", targetContentOffset->y);
    }else if (fabs(velocity.y)> 1.5f ){
        targetContentOffset->y = ( currOffsetY+2 * multipleFactor*ROW_WIDTH);
        NSLog(@"2page move");
    }else if (velocity.y == 0){
        //        NSLog(@"0page move");
        //if user drag and  finger up. no scrollDidEndDecelerating method is called as scrollview is not getting scrolled.
        
        NSIndexPath *indexPath = [_infiniteTableView indexPathForRowAtPoint:CGPointMake(_infiniteTableView.contentOffset.x,  targetContentOffset->y + ROW_WIDTH)];
        [_infiniteTableView scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionMiddle
                                          animated:YES];
        //Set the page control while only draging.
        [self setCurrentPageForPageControl];
    }else{
        // when user scrolls very fast
        isFastScrolling = YES;
    }
}


-(void)setCurrentPageForPageControl{
    
    NSInteger v_tag  = 0;
    NSMutableArray *subViewArray  =[NSMutableArray new];
    
    NSArray *visibleCells = [_infiniteTableView visibleCells];
    
    [visibleCells enumerateObjectsUsingBlock:^(UITableViewCell *cell, NSUInteger idx, BOOL *stop) {
        if (idx == visibleCells.count) {
            *stop = YES;
        }
        [subViewArray addObject: cell.contentView.subviews];
    }];
    
    NSMutableArray *array_ = [NSMutableArray new];
    
    for (NSArray *arr in subViewArray) {
        [array_ addObject:[arr lastObject]];
    }
    //array_ contains all the visible subviews
    
    UILabel *v = [array_ objectAtIndex:1];
    NSLog(@"text :%@",v.text);
    v_tag = v.tag;
    
    pageControl_.currentPage = v_tag ;
    
}


@end
