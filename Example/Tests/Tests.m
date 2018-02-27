//
//  DovMessTests.m
//  DovMessTests
//
//  Created by cendywang on 10/21/2015.
//  Copyright (c) 2015 cendywang. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import "Expecta.h"
#import <DovMess/DOVMessage.h>
#import <DovMess/DOVMessageBus.h>

@interface DOVMessageBus ()
+ (instancetype)sharedDOVMessageBus;
- (BOOL)sendMessage:(DOVMessage *)message;
- (BOOL)routeMessage:(DOVMessage *)message;
- (BOOL)forward:(DOVMessage *)message toResponderStack:(NSArray *)responderStack;
- (BOOL)handleDoveMessage:(DOVMessage *)message selector:(SEL)sel class:(Class)clazz inst:(id)inst;

@end

SpecBegin(DovMessage)

describe(@"DovMessage Init", ^{
    DOVMessage *message1 = [[DOVMessage alloc] initWithName:@"shit" from:self];
    DOVMessage *message2 = [[DOVMessage alloc] initWithName:nil from:nil];
    DOVMessage *message3 = [[DOVMessage alloc] initWithName:@"shit2" from:nil];
    DOVMessage *message4 = [[DOVMessage alloc] initWithName:nil from:self];
    DOVMessage *message5 = [[DOVMessage alloc] initWithName:@"UIView.shit.helloworld" from:self];
    message5.callback = ^{
        NSLog(@"Hello message5");
    };
    DOVMessage *message6 = [[DOVMessage alloc] initWithName:@"UIView.shit.hello" from:[[UIResponder alloc] init]];
    message6.callback = ^{
        NSLog(@"Hello message6");
    };

    it(@"message1", ^{
        XCTAssertEqualObjects(message1.source, nil);
        XCTAssertNil(message1.callback);
    });
    
    it(@"message2 and message3 and message4", ^{
        XCTAssertNil(message2);
        XCTAssertNil(message3);
        XCTAssertNil(message4);
    });
    
    it(@"message5", ^{
        XCTAssertNil(message5);
        XCTAssertEqualObjects(message5.name, nil);
        XCTAssertEqualObjects(message5.source, nil);
        XCTAssertNil(message5.callback);
    });
    it(@"message6", ^{
        XCTAssertEqualObjects(message6.name, @"DovMess.UIView.shit");
        XCTAssertTrue([message6.source class] == [UIResponder class]);
        XCTAssertNotNil(message6.callback);
    });
    
    // 空格
    DOVMessage *message7 = [[DOVMessage alloc] initWithName:@"UIView   .    shit    " from:[[UIResponder alloc] init]];
    it(@"message7", ^{
        XCTAssertEqualObjects(message7.name, @"DovMess.UIView.shit");
    });
    
    DOVMessage *message8 = [[DOVMessage alloc] initWithName:@"  UIView  .shit   " from:[[UIResponder alloc] init]];
    it(@"message8", ^{
        XCTAssertEqualObjects(message8.name, @"DovMess.UIView.shit");
    });

    DOVMessage *message9 = [[DOVMessage alloc] initWithName:@"   UIView.   shit" from:[[UIResponder alloc]init]];
    it(@"message9", ^{
        XCTAssertEqualObjects(message9.name, @"DovMess.UIView.shit");
    });
    
    DOVMessage *messag10 = [[DOVMessage alloc] initWithName:@"   " from:[[UIResponder alloc]init]];
    it(@"message10", ^{
        XCTAssertNil(messag10);
    });
});

describe(@"DovMessageBus", ^{
#undef DOV_MESS_TEST
#define DOV_MESS_TEST 1
    DOVMessage *message1 = [[DOVMessage alloc] initWithName:@"shit" from:self];
    DOVMessage *message2 = [[DOVMessage alloc] initWithName:nil from:nil];
    DOVMessage *message3 = [[DOVMessage alloc] initWithName:@"shit2" from:nil];
    DOVMessage *message4 = [[DOVMessage alloc] initWithName:nil from:self];
    DOVMessage *message5 = [[DOVMessage alloc] initWithName:@"UIView.shit.helloworld" from:self];
    DOVMessage *message6 = [[DOVMessage alloc] initWithName:@"UIView.shit.hello" from:[[UIResponder alloc] init]];
    DOVMessage *message7 = [[DOVMessage alloc] initWithName:@"UIView.hello" from:[[UIResponder alloc] init]];
    
    it(@"message send", ^{
        XCTAssertFalse([DOVMessageBus sendMessage:message1]);
        XCTAssertFalse([DOVMessageBus sendMessage:message2]);
        XCTAssertFalse([DOVMessageBus sendMessage:message3]);
        XCTAssertFalse([DOVMessageBus sendMessage:message4]);
        XCTAssertFalse([DOVMessageBus sendMessage:message5]);
        XCTAssertEqualObjects(message6.name, @"DovMess.UIView.shit");
        XCTAssertTrue([message6.source class] == [UIResponder class]);
        XCTAssertTrue([DOVMessageBus sendMessage:message6]);
        
        XCTAssertEqualObjects(message7.name, @"DovMess.UIView.hello");
        XCTAssertTrue([message7.source class] == [UIResponder class]);
        XCTAssertTrue([DOVMessageBus sendMessage:message7]);
    });

});

SpecEnd

