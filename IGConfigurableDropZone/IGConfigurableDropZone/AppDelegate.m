//
//  AppDelegate.m
//  IGConfigurableDropZone
//
//  Created by Garet McKinley on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;


- (void) theDropAction
{
    [myDropZone fadeOut];
}

- (void) theDragEnteredAction
{
    [myDropZone fadeIn];
    [myDropZone setBackgroundImage:[NSImage imageNamed:@"IGDZBackground_Active.png"]];
}

- (void) theDragExitedAction
{
    [myDropZone setBackgroundImage:[NSImage imageNamed:@"IGDZBackground_Idle.png"]];
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [myDropZone setDropAction:@selector(theDropAction) target:self];
    [myDropZone setDragEnteredAction:@selector(theDragEnteredAction) target:self];
    [myDropZone setDragExitedAction:@selector(theDragExitedAction) target:self];
    
    [myDropZone setBackgroundImage:[NSImage imageNamed:@"IGDZBackground_Idle.png"]];
    
}

@end
