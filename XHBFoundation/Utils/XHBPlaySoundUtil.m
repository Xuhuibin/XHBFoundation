//
//  HBPlaySoundUtil.m
//  wq8
//
//  Created by weqia on 13-10-16.
//  Copyright (c) 2013year Weqia. All rights reserved.
//

#import "XHBPlaySoundUtil.h"

@implementation XHBPlaySoundUtil
-(id)initForPlayingVibrate
{
    self=[super init];
    if(self){
         soundID = kSystemSoundID_Vibrate; 
    }
    return self;
}
-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    self=[super init];
    _type=1;
    if(self){
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        if (path) {
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
    }
    return self;
}
-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    self=[super init];
    _type=2;
    if(self){
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
        {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
    }
    return self;
}

-(void)play
{
    AudioServicesPlaySystemSound(soundID);
}

+(id)shareForPlayingVibrate
{
    static XHBPlaySoundUtil * util=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util=[[XHBPlaySoundUtil alloc]initForPlayingVibrate];
    });
    return util;
}
+(id)sharePlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    static XHBPlaySoundUtil * util=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util=[[XHBPlaySoundUtil alloc]initForPlayingSystemSoundEffectWith:resourceName ofType:type];
    });
    return util;
}
+(id)shareForPlayingSoundEffectWith:(NSString *)filename;
{
    static XHBPlaySoundUtil * util=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util=[[XHBPlaySoundUtil alloc]initForPlayingSoundEffectWith:filename];
    });
    return util;
}
@end
