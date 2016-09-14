//
//  ViewController.h
//  MCCamleTools
//
//  Created by Marcus on 16/5/31.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *waybillNumberTextField;
- (IBAction)checkButtonClick:(NSButton *)sender;
@end

