//
//  MCContentVC.m
//  MCCamleTools
//
//  Created by Marcus on 16/6/1.
//  Copyright © 2016年 Marcus. All rights reserved.
//
#define FULLSIZE (NSViewMinXMargin | NSViewWidthSizable | NSViewMaxXMargin | NSViewMinYMargin | NSViewHeightSizable | NSViewMaxYMargin)

#import "MCContentVC.h"
#import "MCHTTPRequest.h"
#import "Fence.h"
#import "MCLoginView.h"

@interface MCContentVC ()<NSTableViewDataSource,NSTableViewDelegate>
{
    NSTableView *tableView;
    NSTableView *logTableView;
    NSTableView *tableView2;
   
}

@end

@implementation MCContentVC

//
- (void)addColumn:(NSString*)newid withTitle:(NSString*)title withWidth:(int)width withTableView:(NSTableView *)tableview
{
    NSTableColumn *column=[[NSTableColumn alloc] initWithIdentifier:newid];
    [[column headerCell] setStringValue:title];
    [[column headerCell] setAlignment:NSCenterTextAlignment];
    [column setWidth:width];
    [column setMinWidth:50];
    [column setEditable:YES];
    [column setResizingMask:NSTableColumnAutoresizingMask | NSTableColumnUserResizingMask];
    [tableview addTableColumn:column];
}

- (void)awakeFromNib
{
    self.title =@"结果显示";
    NSLog(@"__________%@",self.tableData);
    tableView = [[NSTableView alloc] initWithFrame:scrollView.frame];
    tableView.tag = 10010;
    [tableView setAutosaveName:@"tiggerFenceTableView"];
    
    tableView2 = [[NSTableView alloc] initWithFrame:scrollView2.frame];
    tableView2.tag = 10012;
    scrollView2.backgroundColor = [NSColor redColor];
    [tableView2 setAutosaveName:@"creatFenceTableView"];
    
    logTableView = [[NSTableView alloc] initWithFrame:logScrollView.frame];
    logTableView.tag = 10011;
    [logTableView setAutosaveName:@"logTableView"];
    

    
    NSTableHeaderView *tableHeadView=[[NSTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 450, 30)];
    [tableView setHeaderView:tableHeadView];
    
    NSTableHeaderView *headView2=[[NSTableHeaderView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, 450, 30)];
    [tableView2 setHeaderView:headView2];
    
    
    NSTableHeaderView *HeadView=[[NSTableHeaderView alloc] initWithFrame:CGRectMake(450, 0, 450, 30)];
    [logTableView setHeaderView:HeadView];
    
    
    
    //[tableView setAutoresizesSubviews:FULLSIZE];
    [tableView setBackgroundColor:[NSColor whiteColor]];
    [tableView setGridColor:[NSColor lightGrayColor]];
    [tableView setGridStyleMask: NSTableViewSolidHorizontalGridLineMask];
    [tableView setUsesAlternatingRowBackgroundColors:YES];
    [tableView setAutosaveTableColumns:YES];
    [tableView setAllowsEmptySelection:YES];
    [tableView setAllowsColumnSelection:YES];
    
    
    
    //[tableView2 setAutoresizesSubviews:FULLSIZE];
    [tableView2 setBackgroundColor:[NSColor whiteColor]];
    [tableView2 setGridColor:[NSColor lightGrayColor]];
    [tableView2 setGridStyleMask: NSTableViewSolidHorizontalGridLineMask];
    [tableView2 setUsesAlternatingRowBackgroundColors:YES];
    [tableView2 setAutosaveTableColumns:YES];
    [tableView2 setAllowsEmptySelection:YES];
    [tableView2 setAllowsColumnSelection:YES];
    
    [logTableView setAutoresizesSubviews:FULLSIZE];
    [logTableView setBackgroundColor:[NSColor whiteColor]];
    [logTableView setGridColor:[NSColor lightGrayColor]];
    [logTableView setGridStyleMask: NSTableViewSolidHorizontalGridLineMask];
    [logTableView setUsesAlternatingRowBackgroundColors:YES];
    [logTableView setAutosaveTableColumns:YES];
    [logTableView setAllowsEmptySelection:YES];
    [logTableView setAllowsColumnSelection:YES];
    
    [self addColumn:@"1" withTitle:@"围栏名称" withWidth: 85 withTableView: tableView];
    [self addColumn:@"2" withTitle:@"围栏ID" withWidth: 60 withTableView: tableView];
    [self addColumn:@"3" withTitle:@"围栏半径" withWidth: 30 withTableView: tableView];
    [self addColumn:@"4" withTitle:@"触发类型" withWidth: 30 withTableView: tableView];
    [self addColumn:@"5" withTitle:@"围栏坐标" withWidth: 40 withTableView: tableView];
    [self addColumn:@"6" withTitle:@"触发时间" withWidth:135 withTableView:tableView];
    [tableView setDataSource:self];
    [scrollView setDocumentView:tableView];
    
    
    
    [self addColumn:@"1" withTitle:@"围栏名称" withWidth: 210 withTableView: tableView2];
    [self addColumn:@"2" withTitle:@"围栏ID" withWidth: 60 withTableView: tableView2];
    [self addColumn:@"3" withTitle:@"围栏半径" withWidth: 40 withTableView: tableView2];
    [self addColumn:@"4" withTitle:@"观察者" withWidth: 95 withTableView: tableView2];
    [self addColumn:@"5" withTitle:@"围栏坐标" withWidth:65 withTableView: tableView2];
    [tableView2 setDataSource:self];
    [scrollView2 setDocumentView:tableView2];
    
    
    [self addColumn:@"1" withTitle:@"时间" withWidth: 140 withTableView: logTableView];
    [self addColumn:@"2" withTitle:@"日志类型" withWidth: 90 withTableView: logTableView];
    [self addColumn:@"3" withTitle:@"手机型号" withWidth: 70 withTableView: logTableView];
    [self addColumn:@"4" withTitle:@"坐标信息" withWidth: 70 withTableView: logTableView];
    [self addColumn:@"5" withTitle:@"版本信息" withWidth: 70 withTableView: logTableView];
    [logTableView setDataSource:self];
    [logScrollView setDocumentView:logTableView];
    

    
}

//查看轨迹
- (IBAction)traceCheck:(NSButton *)sender
{
    MCLoginView *loginVC = [MCLoginView new];
    
    [self presentViewControllerAsModalWindow:loginVC];
}
- (void)selfShowWarning
{
    //NSAlert *alert = [NSAlert];
    
}
#pragma mark NSTableViewDataSource Delegate


- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if (aTableView.tag == 10010)
    {
         return (int)_tableData.count;
    }
    else if(aTableView.tag == 10011)
    {
        return (int)_tableData2.count;
    }
    else
    {
        NSLog(@"______%d", (int)_createdFenceData.count);
        return (int)_createdFenceData.count;
    }
   
}

- (id)tableView: (NSTableView *)theTableView objectValueForTableColumn: (NSTableColumn *)theColumn row: (int)rowIndex
{
    if (theTableView.tag == 10010)
    {
        NSParameterAssert(rowIndex >= 0 && rowIndex < [_tableData count]);
        if (_tableData.count >0) {
            return [[_tableData objectAtIndex:rowIndex] objectForKey:[theColumn identifier]];
        }
        else
        {
            return nil;
        }
 
    }
    else if (theTableView.tag == 10011)
    {
        NSParameterAssert(rowIndex >= 0 && rowIndex < [_tableData2 count]);
        if (_tableData2.count >0) {
            return [[_tableData2 objectAtIndex:rowIndex] objectForKey:[theColumn identifier]];
        }
        else
        {
            return nil;
        }
    }
    else
    {
         NSParameterAssert(rowIndex >= 0 && rowIndex < [_createdFenceData count]);
        if (_createdFenceData.count >0) {
            return [[_createdFenceData objectAtIndex:rowIndex] objectForKey:[theColumn identifier]];
        }
        else
        {
            return nil;
        }
    }
    
}


#pragma mark NSApplication Delegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application 
}


@end
