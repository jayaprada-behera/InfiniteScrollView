//
//  WAInfiniteTableView.h
//  TableViewTransformDemo
//
//  Created by Jayaprada Behera on 04/02/14.
//  Copyright (c) 2014 Webileapps. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ROW_WIDTH                 260.f
#define TOTAL_NUMBER_OF_ROWS      500

@interface WAInfiniteTableView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *infiniteTableView;

-(id)initWithFrame:(CGRect)frame andCellWidth:(CGFloat)width andviews:(NSArray *)views_;
@end
