//
//  XHBPrecompile.h
//  Weqia
//
//  Created by weqia on 14-10-27.
//  Copyright (c) 2014年 xhb. All rights reserved.
//

#ifndef Weqia_XHBPrecompile_h
#define Weqia_XHBPrecompile_h

#ifdef DEBUG
#define DLog						NSLog(@"%s-%d", __PRETTY_FUNCTION__, __LINE__);
#define DLogArgs(format, ... ) 	NSLog(@"%s-%d: %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__] );

#else
#define DLog						{}
#define DLogArgs(format, ... )		{}
#endif


#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue] // 系统版本

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) // 屏幕宽度

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) // 屏幕高度

#define MAX_IMAGE_SIZE 1024*1024*2      //  允许显示最大图片的size

#define UPLOAD_MAX_IMAGE_SIZE 1024*1024*2



#endif
