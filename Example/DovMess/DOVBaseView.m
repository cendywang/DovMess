//
//  DOVBaseView.m
//  DovMess
//
//  Created by 圣迪 on 15/10/21.
//  Copyright © 2015年 cendywang. All rights reserved.
//

#import "DOVBaseView.h"
#import <DovMess/DOVMessage.h>

@implementation DOVBaseView

DOVE_MESSAGE_HANDLER1(Helloworld, message) {
    NSLog(@"I'm in DOVBaseView, handled this message");
    if (message.callback) {
        message.callback();
    }
}

@end
