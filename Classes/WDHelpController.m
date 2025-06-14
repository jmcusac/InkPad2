//
//  WDHelpController.m
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2011-2013 Steve Sprang
//

#import "WDHelpController.h"
#import <WebKit/WebKit.h>

@implementation WDHelpController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!self) {
        return nil;
    }
    
    NSString *version = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey];
    
    // don't need to localize the app name
    self.navigationItem.title = [NSString stringWithFormat:@"Inkpad %@", version];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:NSLocalizedString(@"Print", @"Print")
                                             style:UIBarButtonItemStylePlain  // Changed from Bordered
                                             target:self
                                             action:@selector(printContent:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                               target:self
                                               action:@selector(dismissView:)];
    return self;
}

- (NSURL *) helpURL
{
    NSString *resource = NSLocalizedString(@"index", @"Name of Help html file");
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"html" inDirectory:@"Help"];
    return [NSURL fileURLWithPath:path isDirectory:NO];
}

- (void)loadView
{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = webView;
    [webView loadRequest:[NSURLRequest requestWithURL:[self helpURL]]];
}

- (void)dismissView:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)printContent:(id)sender
{
    // TODO: MODERNIZATION - Printing disabled, WKWebView doesn't support viewPrintFormatter
    // Help content printing temporarily unavailable
}

@end
