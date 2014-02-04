//
//  WAInfiniteTableView.m
//  TableViewTransformDemo
//
//  Created by Jayaprada Behera on 04/02/14.
//  Copyright (c) 2014 Webileapps. All rights reserved.
//

#import "WAInfiniteTableView.h"


@implementation WAInfiniteTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        views = [[NSMutableArray alloc] init];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame andCellWidth:(CGFloat )width andviews:(NSArray *)views_{
    
    self = [self initWithFrame:frame];
    if (self != nil) {
        
    // Initialization code
    _infiniteTableView = [[UITableView alloc] init] ;

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
    NSLog(@"Didend decelerating Contectoffset:%f", tableView.contentOffset.y);
    
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    NSLog(@"Scroll Contectoffset:%f", scrollView.contentOffset.y);
    currOffsetY = scrollView.contentOffset.y;
}

-(void) scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset {
        
    NSLog(@"offset %f,velocity.x %f,targetcontentOffset %f",scrollView.contentOffset.y,fabs(velocity.y),targetContentOffset->y);
   
    CGFloat multipleFactor = 1.0f;
    if (velocity.y <0) {
        multipleFactor = -1.0f;
    }
    if (fabs(velocity.y) > 0.5f && fabs(velocity.y) < 1.5f  ) {
        
        targetContentOffset->y = currOffsetY+ multipleFactor*ROW_WIDTH;
        NSLog(@"target Contectoffset:%f", targetContentOffset->y);
    }else if (fabs(velocity.y)> 1.5f ){
        targetContentOffset->y = ( currOffsetY+2 * multipleFactor*ROW_WIDTH);
        NSLog(@"2page move");
    }else{
        targetContentOffset->y =  currOffsetY; // Should not move in this case
        NSLog(@"0page move");
    }
    
}

@end
