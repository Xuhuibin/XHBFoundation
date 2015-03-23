//
//  XHBBaseTool.m
//  XHBFoundation
//
//  Created by weqia on 14-9-19.
//  Copyright (c) 2014year xhb. All rights reserved.
//

#import "XHBBaseTool.h"


@implementation XHBBaseTool
@synthesize initCallback,completeCallback,viewController;
-(void)operate:(UIViewController<XHBViewControllerToolOwnerDelegate>*)viewController1 initCallback:(XHBToolInitCallback)initCallback1 completeCallback:(XHBToolCompleteCallback)completeCallback1
{
    viewController=viewController1;
    initCallback=[initCallback1 copy];
    completeCallback=[completeCallback1 copy];
    if ([viewController1 respondsToSelector:@selector(setControlTool:)]) {
        viewController1.controlTool=self;
    }
}
@end
