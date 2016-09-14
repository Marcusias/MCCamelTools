//
//  MCLoginView.h
//  运单分析
//
//  Created by Marcus on 16/9/14.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MCLoginView : NSViewController
@property (weak) IBOutlet NSTextField *accountTextfield;
@property (weak) IBOutlet NSTextField *passwordTextField;
- (IBAction)cancelButtonClick:(NSButton *)sender;
- (IBAction)loginButtonClick:(NSButton *)sender;

@end
