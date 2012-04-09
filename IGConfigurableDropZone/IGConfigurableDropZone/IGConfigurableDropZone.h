//
//  IGConfigurableDropZone.h
//  IGConfigurableDropZone
//
//  Created by Garet McKinley on 4/8/12.
//  Copyright (c) 2012 iGaret. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IGConfigurableDropZone : NSView
{
    NSImage *IGDZBackground;
    
    NSMutableArray *fileArray;
    
    SEL dropAction;
    SEL dragEnteredAction;
    SEL dragExitedAction;
    
    NSObject* targetObject;
}



- (void) setDropAction:(SEL)theAction target:(id)sender;
- (void) setDragEnteredAction:(SEL)theAction target:(id)sender;
- (void) setDragExitedAction:(SEL)theAction target:(id)sender;

- (void) setBackgroundImage:(NSImage*)bgImage;


- (void) fadeIn;
- (void) fadeOut;

@end
