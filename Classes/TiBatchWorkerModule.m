/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiBatchWorkerModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiViewProxy.h"

@implementation TiBatchWorkerModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"a04137b2-6d2a-4455-8d54-62132b822c9d";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.batch.worker";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(void)applyProperties:(id)args
{
    NSArray * items;
	ENSURE_UI_THREAD_1_ARG(args);
	ENSURE_ARG_AT_INDEX(items, args, 0, NSArray);
    TiViewProxy * parent = NULL;
    for (NSDictionary * item in items) {
        id _proxy = [item objectForKey:@"proxy"];
        id _props = [item objectForKey:@"properties"];
        TiViewProxy * proxy = (TiViewProxy *) _proxy;
        ENSURE_TYPE_OR_NIL(_props, NSDictionary);
        if (parent != NULL && [proxy parent] != parent ) {
            [parent finishLayout:NULL];
            parent = NULL;
        }
        if (parent == NULL) {
            parent = [proxy parent];
            [parent startLayout:NULL];
        }
        [proxy setValuesForKeysWithDictionary:_props];
    }
    if (parent != NULL) {
        [parent finishLayout:NULL];
    }
}

-(void)batchAnimate:(id)args
{
    NSArray * items;
    ENSURE_UI_THREAD_1_ARG(args);
	ENSURE_ARG_AT_INDEX(items, args, 0, NSArray);
    for (NSDictionary * item in items) {
        id _proxy = [item objectForKey:@"proxy"];
        id _aprops = [item objectForKey:@"animate"];
        TiViewProxy * proxy = (TiViewProxy *) _proxy;
        ENSURE_TYPE_OR_NIL(_aprops, NSDictionary);
        [proxy animate:_aprops];
    }
}


@end
