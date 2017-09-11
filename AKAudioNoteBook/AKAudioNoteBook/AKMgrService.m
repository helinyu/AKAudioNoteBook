//
//  AKMgrService.m
//  AKAudioNoteBook
//
//  Created by Aka on 2017/9/9.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "AKMgrService.h"



@interface AKMgrService ()

@property (nonatomic, strong) NSMutableDictionary *mgrs;

@end

@implementation AKMgrService

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mgrs = [NSMutableDictionary new];
    }
    return self;
}

- (Class)serviceWithMgr:(NSString *)className {
    Class aClass = [_mgrs objectForKey:className];
    if (!aClass) {
        aClass = NSClassFromString(className);
        [_mgrs setObject:aClass forKey:className];
    }
    return aClass;
}

//- (void)test:(Class)aClass {
//    [[AKMgrService shared] serviceWithMgr:NSStringFromClass(aClass)];
//}

@end
