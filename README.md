InfiniteScrollView
==================

Infinite Scrolling Of Views With paging enabled

Usage:

1. Drag and drop WAInfiniteTableView.h and WAInfiniteTableView.m files into your project.

2. Following modifications to your UIViewController. Look at InfiniteScrolling for example usage. 

    NSMutableArray *viewList = [[NSMutableArray alloc]initWithObjects:_view1,_view2,_view3,_view4,nil ];
   
    WAInfiniteTableView *_tableView = [[WAInfiniteTableView alloc]initWithFrame:self.view.bounds andCellWidth:ROW_WIDTH andviews:viewList];
    [self.view addSubview:_tableView];


