//
//  DOVMessageBus.m
//
//  Created by 圣迪 on 15/10/20.
//  Copyright © 2015年 
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "DOVMessageBus.h"
#import "DOVMessage.h"
#import <objc/runtime.h>
#import <objc/message.h>
@import UIKit;

#if !__has_feature(objc_arc)
#error DovMess must be built with ARC.
// You can turn on ARC for only DovMess files by adding -fobjc-arc to the build phase for each of its files.
#endif


typedef void (*IMPFuncType)(id, SEL, void *);

@implementation DOVMessageBus

#pragma mark - Initialize
+ (instancetype)sharedDOVMessageBus {
    static DOVMessageBus *sharedDOVMessageBus = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDOVMessageBus = [[super alloc] init];
    });
    return sharedDOVMessageBus;
}

#pragma mark - Send Message
+ (BOOL)sendMessage:(DOVMessage *)message {
    if (!message) {
        return NO;
    }
    return [[DOVMessageBus sharedDOVMessageBus] sendMessage:message];
}

- (BOOL)sendMessage:(DOVMessage *)message {
    if (!message) {
        return NO;
    }
    if (!message.name ||
        [[message.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
#if DOV_MESS_TEST
        NSLog(@"Message.name Can't be nil");
#endif
        return NO;
    }
    if (!message.source) {
#if DOV_MESS_TEST
        NSLog(@"Message.source Can't be nil");
#endif
        return NO;
    }
    [self routeMessage:message];
    return YES;
}

#pragma mark - Inner Methods
- (BOOL)routeMessage:(DOVMessage *)message {
    if (!message) {
        return NO;
    }
    
    Class sourceClass = [message.source class];
    if (![sourceClass isSubclassOfClass:[UIResponder class]]) {
        return NO;
    }
    UIResponder *messageResponder = (UIResponder *)message.source;
    
    NSMutableArray *responderStackMut = [[NSMutableArray alloc]init];;
    do {
        [responderStackMut insertObject:messageResponder atIndex:0];
        
        messageResponder = [messageResponder nextResponder];
        
        if (!messageResponder ||
            [messageResponder isMemberOfClass:[UIApplication class]]) {
            break;
        }
    } while (1);
    NSArray *responderStack = [[responderStackMut reverseObjectEnumerator] allObjects];
    return [self forward:message toResponderStack:responderStack];
}

- (BOOL)forward:(DOVMessage *)message toResponderStack:(NSArray *)responderStack {
    if (!message) {
        return NO;
    }
    
    static int msg_with_class    = 3;  // include Class and message name
    static int msg_without_class = 2;  // just include message name
    
    BOOL isHandled = NO;
    if (message.name && [message.name hasPrefix:DOVE_MESSAGE_PREFIX]) {
        /**
         *  解析名称
         */
        NSString *messagePrefix = nil;
        NSString *messageClassName  = nil;
        NSString *messageRealName  = nil;
        
        NSArray *nameArray = [message.name componentsSeparatedByString:@"."];
        int nameCount      = (int)[nameArray count];
        
        if (nameCount == msg_with_class || nameCount == msg_without_class) {
            messagePrefix    = [nameArray objectAtIndex:0];
            messageClassName = [nameArray objectAtIndex:1];
            if (nameCount == msg_with_class) {
                messageRealName  = [nameArray objectAtIndex:2];
            }
            
            unsigned long count = (unsigned long)[responderStack count];
            NSString *	selectorName = nil;
            SEL			selector     = nil;
            for (int i = 0; i < count; ++i) {
                UIResponder *responder = [responderStack objectAtIndex:i];
                if (messageClassName && messageRealName) {
                    selectorName = [NSString stringWithFormat:@"handleDoveMessage_%@_%@:", messageClassName, messageRealName];
                    selector     = NSSelectorFromString(selectorName);
                    
                    isHandled    = [self handleDoveMessage:message selector:selector
                                                     class:[responder class] inst:responder];
                    if (isHandled) {
                        break;
                    }
                }
                if (messageClassName) {
                    selectorName = [NSString stringWithFormat:@"handleDoveMessage_%@:", messageClassName];
                    selector     = NSSelectorFromString(selectorName);
                    
                    isHandled    = [self handleDoveMessage:message selector:selector
                                                     class:[responder class] inst:responder];
                    if (isHandled) {
                        break;
                    }
                }
            }
        }
    }
    return isHandled;
}

- (BOOL)handleDoveMessage:(DOVMessage *)message selector:(SEL)sel class:(Class)clazz inst:(id)inst {
    if (!message || !sel || !clazz || !inst) {
        return NO;
    }
    
    BOOL isHandled = NO;
    if ([inst respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [inst performSelector:sel withObject:message];
#pragma clang diagnostic pop
        isHandled = YES;
    } else {
        Method method = class_getInstanceMethod(clazz, sel);
        if (method) {
            IMPFuncType imp = (IMPFuncType)method_getImplementation(method);
            
            if (imp) {
                imp ( clazz, sel, (__bridge void *)(message) );
                isHandled = YES;
            }
        }
    }
    
    return isHandled;
}

@end
