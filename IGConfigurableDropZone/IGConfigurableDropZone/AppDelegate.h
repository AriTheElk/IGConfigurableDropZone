//
//  AppDelegate.h
//  IGConfigurableDropZone
//
//  Created by Garet McKinley on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IGConfigurableDropZone.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet IGConfigurableDropZone *myDropZone;
}

@property (assign) IBOutlet NSWindow *window;

@end
