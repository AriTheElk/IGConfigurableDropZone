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
    
    NSMutableArray *dragTypes;
}



- (void) setDropAction:(SEL)theAction target:(id)theTarget;
- (void) setDragEnteredAction:(SEL)theAction target:(id)theTarget;
- (void) setDragExitedAction:(SEL)theAction target:(id)theTarget;

- (void) setBackgroundImage:(NSImage*)bgImage;


- (void) fadeIn;
- (void) fadeOut;

- (void) addDragType:(NSString*)type;
- (void) removeDragType:(NSString*)type;

@end
