//
//  AKMgrService.h
//  AKAudioNoteBook
//
//  Created by Aka on 2017/9/9.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OBTAIN_MGR(mgr) ([[AKMgrService shared] serviceWithMgr:NSStringFromClass(mgr)])

@interface AKMgrService : NSObject

+ (instancetype)shared;
- (Class)serviceWithMgr:(NSString *)className;

@end
