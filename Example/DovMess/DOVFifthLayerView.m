//
//  DOVFifthLayerView.m
//  DovMess
//
//  Created by 圣迪 on 15/10/21.
//  Copyright © 2015年 cendywang. All rights reserved.
//

#import "DOVFifthLayerView.h"
#import <DOVMess/DOVMessageBus.h>
#import <DovMess/DOVMessage.h>

@implementation DOVFifthLayerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Touch!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor blackColor]];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(10, 20, 70, 40)];
    [self addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"Touch!" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button2 setBackgroundColor:[UIColor blackColor]];
    [button2 addTarget:self action:@selector(buttonClicked2) forControlEvents:UIControlEventTouchUpInside];
    [button2 setFrame:CGRectMake(10, 70, 70, 40)];
    [self addSubview:button2];
}

- (void)buttonClicked {
    DOVMessage *message = [[DOVMessage alloc] initWithName:@"ViewController.holy" from:self];
    [DOVMessageBus sendMessage:message];
    
    DOVMessage *messageNotArri = [[DOVMessage alloc] initWithName:nil from:nil];
    [DOVMessageBus sendMessage:messageNotArri];
}

- (void)buttonClicked2 {
    DOVMessage *message = [[DOVMessage alloc] initWithName:@"Helloworld" from:self];
    message.callback = ^{
        NSLog(@"Message from callback");
    };
    [DOVMessageBus sendMessage:message];
}

@end
