//
//  WDSelectionView.m
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2010-2013 Steve Sprang
//

#import "WDBezierNode.h"
#import "WDCanvas.h"
#import "WDDrawingController.h"
#import "WDLayer.h"
#import "WDPath.h"
#import "WDSelectionTool.h"
#import "WDSelectionView.h"
#import "WDToolManager.h"
#import "WDUtilities.h"
#import "UIColor+Additions.h"

@implementation WDSelectionView

@synthesize canvas = canvas_;
// @synthesize context;  // Disabled - no more EAGLContext

+ (Class) layerClass
{
    // TODO: PHASE 2 - Consider CALayer or custom drawing layer
    return [CALayer class];  // Changed from CAEAGLLayer
}

- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return self.superview;  // Keep touch handling
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    // TODO: PHASE 2/3 - Replace with modern rendering setup
    /*
    // DISABLED: OpenGL setup
    CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
    eaglLayer.opaque = NO;
    eaglLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking: @NO,
                                    kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8};
    
    context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    if (!context || ![EAGLContext setCurrentContext:context]) {
        return nil;
    }
    
    glGenFramebuffersOES(1, &defaultFramebuffer);
    glGenRenderbuffersOES(1, &colorRenderbuffer);
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    
    glClearColor(0, 0, 0, 0);
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnableClientState(GL_VERTEX_ARRAY);
    */
    
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode = UIViewContentModeCenter;
    self.contentScaleFactor = [UIScreen mainScreen].scale;
    
    return self;
}

- (CGRect) convertRectFromCanvas:(CGRect)rect
{
    // Keep coordinate conversion - this might be needed by other code
    rect.origin = WDSubtractPoints(rect.origin, [canvas_ visibleRect].origin);
    rect = CGRectApplyAffineTransform(rect, self.canvas.canvasTransform);
    rect = WDFlipRectWithinRect(rect, self.frame);
    
    return rect;
}

// PHASE 1: All rendering methods stubbed out
- (void) renderMarquee
{
    // TODO: PHASE 2 - Implement with Core Graphics
    // Selection marquee disabled temporarily
}

- (void) renderDocumentBorder
{
    // TODO: PHASE 2 - Implement with Core Graphics
    // Document border disabled temporarily
}

- (float) effectiveGridSpacing
{
    // Keep the calculation logic - might be used elsewhere
    float   gridSpacing = self.drawing.gridSpacing;
    CGRect  testRect = CGRectMake(0, 0, gridSpacing, gridSpacing);
    float   adjustmentFactor = 1;
    
    testRect = [canvas_ convertRectToView:testRect];
    
    float minSpacing = 10.0f / [UIScreen mainScreen].scale;
    
    if (CGRectGetWidth(testRect) < minSpacing) {
        adjustmentFactor = minSpacing / CGRectGetWidth(testRect);
    }
    
    return gridSpacing * adjustmentFactor;
}

- (void) renderGrid
{
    // TODO: PHASE 2 - Implement with Core Graphics
    // Grid rendering disabled temporarily
}

- (void) drawView
{
    // TODO: PHASE 2/3 - Complete rewrite with modern graphics
    // ALL VISUAL FEEDBACK DISABLED TEMPORARILY
    
    // App will compile and run, but users won't see:
    // - Selection highlights
    // - Grid
    // - Marquee selection
    // - Editing handles
    // - Document borders
    
    return; // Early return - no rendering
    
    /*
    // DISABLED: Entire OpenGL rendering pipeline
    [EAGLContext setCurrentContext:context];
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    float scale = [UIScreen mainScreen].scale;
    glOrthof(0, backingWidth / scale, 0, backingHeight / scale, -1, 1);
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    // ... hundreds of lines of OpenGL rendering code ...
    
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
    */
}

- (void)reshapeFramebuffer
{
    // TODO: PHASE 2 - Replace with modern buffer management
    // Framebuffer management disabled
}

- (void)layoutSubviews
{
    // Keep the layout trigger, but no rendering for now
    // [self reshapeFramebuffer];  // Disabled
    // [self drawView];            // Disabled - returns early anyway
}

- (void)dealloc
{
    // TODO: PHASE 2 - Modern cleanup
    /*
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
    */
}

- (WDDrawing *) drawing
{
    return self.canvas.drawing;
}

@end
