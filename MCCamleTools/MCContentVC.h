//
//  MCContentVC.h
//  MCCamleTools
//
//  Created by Marcus on 16/6/1.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MCContentVC : NSViewController

{
    
    __weak IBOutlet NSScrollView *scrollView;
    
    __weak IBOutlet NSScrollView *logScrollView;
    
    __weak IBOutlet NSScrollView *scrollView2;
}


@property (nonatomic,copy) NSString *waybillnummber;
@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,retain) NSMutableArray		*tableData;
@property (nonnull,retain) NSArray *tableData2;
@property (nonnull,retain) NSArray *createdFenceData;
- (IBAction)traceCheck:(NSButton *)sender;
- (int)numberOfRowsInTableView:(NSTableView *)aTableView;

- (id)tableView: (NSTableView *)theTableView objectValueForTableColumn: (NSTableColumn *)theColumn row: (int)rowIndex;

@end
