//
//  WDToolButton.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2011-2013 Steve Sprang
//

#import <Foundation/Foundation.h>

@class WDTool;
@class WDToolView;

@interface WDToolButton : UIButton {
    UIViewController *subtoolsPopover_;
}

@property (nonatomic, weak) WDTool  *tool;
@property (nonatomic, weak) NSArray  *tools;

+ (float) dimension;

- (void) didChooseTool:(WDToolView *)toolView;
- (void) dismissSubtoolsAnimated:(BOOL)animated;

@end
