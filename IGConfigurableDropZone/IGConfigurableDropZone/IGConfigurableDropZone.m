//
//  IGConfigurableDropZone.m
//  IGConfigurableDropZone
//
//  Created by Garet McKinley on 4/8/12.
//  Copyright (c) 2012 iGaret. All rights reserved.
//

#import "IGConfigurableDropZone.h"


@implementation IGConfigurableDropZone



- (void) setDropAction:(SEL)theAction target:(id)theTarget
{
    targetObject = theTarget;
    dropAction = theAction;
}

- (void) setDragEnteredAction:(SEL)theAction target:(id)theTarget
{
    targetObject = theTarget;
    dragEnteredAction = theAction;
}

- (void) setDragExitedAction:(SEL)theAction target:(id)theTarget
{
    targetObject = theTarget;
    dragExitedAction = theAction;
}


- (void) setBackgroundImage:(NSImage *)bgImage
{
    IGDZBackground = bgImage;
    [self setNeedsDisplay:YES];
}

- (void) fadeIn
{
    [[self animator] setAlphaValue:1.0];
}

- (void) fadeOut
{
    [[self animator] setAlphaValue:0.0];
}


- (void) addDragType:(NSString *)type
{
    [dragTypes addObject:type];
    [self registerForDraggedTypes:dragTypes];
}

- (void) removeDragType:(NSString *)type
{
    [dragTypes removeObject:type];
    [self registerForDraggedTypes:dragTypes];
}





- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    
    [self registerForDraggedTypes:[NSArray arrayWithObjects:NSPasteboardTypeTIFF, 
                                   NSFilenamesPboardType, nil]];
    
    dragTypes = [[NSMutableArray alloc] init];
    
    
    return self;
}

- (void)dealloc
{
    [targetObject release];
    [fileArray release];
    [self unregisterDraggedTypes];
    [super dealloc];
}




- (void)drawRect:(NSRect)dirtyRect
{
    if (IGDZBackground)
    {
        NSSize IGDZBackgroundSize = [IGDZBackground size];
        [IGDZBackground
                    drawInRect:[self bounds]
                    fromRect:NSMakeRect(0.0, 0.0, IGDZBackgroundSize.width, IGDZBackgroundSize.height)
                    operation: NSCompositeSourceOver
                    fraction:1.0];
    }
}




- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
        == NSDragOperationGeneric)
    {   
        if (dragEnteredAction)
            [targetObject performSelector:dragEnteredAction];
        [self setNeedsDisplay:YES];
        
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
        //to tell them we aren't interested
        return NSDragOperationNone;
    }
}


- (void)draggingExited:(id <NSDraggingInfo>)sender
{
    if (dragExitedAction)
        [targetObject performSelector:dragExitedAction];
}


- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
        == NSDragOperationGeneric)
    {
        return NSDragOperationGeneric;
    }
    else
    {
        return NSDragOperationNone;
    }
}


- (void)draggingEnded:(id <NSDraggingInfo>)sender
{
    if (dragExitedAction)
        [targetObject performSelector:dragExitedAction];
}


- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}




- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *paste = [sender draggingPasteboard];
    //gets the dragging-specific pasteboard from the sender
    NSArray *types = [NSArray arrayWithObjects:NSFilenamesPboardType, nil];
    //a list of types that we can accept
    NSString *desiredType = [paste availableTypeFromArray:types];
    NSData *carriedData = [paste dataForType:desiredType];
    
    if (nil == carriedData)
    {
        //the operation failed for some reason
        NSRunAlertPanel(@"Paste Error", @"Sorry, but the past operation failed", 
                        nil, nil, nil);
        return NO;
    }
    
    else
    {
        if ([desiredType isEqualToString:NSFilenamesPboardType])
        {
            
            fileArray = [[NSMutableArray alloc] initWithArray:[paste propertyListForType:@"NSFilenamesPboardType"]];
            
            if (dropAction)
                [targetObject performSelector:dropAction withObject:fileArray];
            
            [fileArray release];
        }
        else
        {
            NSAssert(NO, @"This can't happen");
            return NO;
        }
    }
    [self setNeedsDisplay:YES];
    return YES;
}


- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
    //re-draw the view with our new data
    [self setNeedsDisplay:YES];
}

@end
