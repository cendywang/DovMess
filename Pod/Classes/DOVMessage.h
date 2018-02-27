//
//  DOVMessage.h
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
//
/**
 *  @header      DOVMessage
 *  @abstract    Dove Message 的消息格式
 *  @author      圣迪
 *  @version     0.1
 *  @discussion  还需要对不同的应用场景来确定更多附带信息
 */
#import <Foundation/Foundation.h>

#ifndef NS_DESIGNATED_INITIALIZER
#if __has_attribute(objc_designated_initializer)
#define NS_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
#else
#define NS_DESIGNATED_INITIALIZER
#endif
#endif


#define DOV_MESS_TEST 0

// Dove Message Handler Macro
/**
 *  Dove Message Handler Macro
 *
 *  @param __message_name 声明接收消息的名称
 *  @param message        收到的消息名称, 默认message即可
 *  @descriptions
 *     一条名为 "Helloworld"的消息，则可定义本函数为：
 *       DOVE_MESSAGE_HANDLER(Helloworld, message)
 *       其中， message 为接收到的DOVMessage.
 *
 *  @return void
 */
#define DOVE_MESSAGE_HANDLER1( __message_name, message ) \
    - (void)handleDoveMessage_##__message_name:(DOVMessage *)message

// Dove Message Handler Macro
/**
 *  Dove Message Handler Macro
 *
 *  @param __class_name   声明消息接收的类名称
 *  @param __message_name 声明接收消息的名称
 *  @param message        收到的消息名称, 默认message即可
 *  @descriptions
 *     一条名为 "ViewController.Helloworld"的消息，则可定义本函数为：
 *       DOVE_MESSAGE_HANDLER(ViewController, Helloworld, message)
 *       其中， message 为接收到的DOVMessage.
 *
 *  @return void
 */
#define DOVE_MESSAGE_HANDLER2( __class_name, __message_name, message ) \
        - (void)handleDoveMessage_##__class_name##_##__message_name:(DOVMessage *)message

// Dove Message Header
// Dove Message would display like "DovMess.CLASSNAME.MESSAGENAME"
#define DOVE_MESSAGE_PREFIX @"DovMess"

typedef	void (^DOVHandleBlock)( void );

@interface DOVMessage : NSObject

@property (nonatomic, copy,   nonnull)  NSString *name;           // 消息名称
@property (nonatomic, strong, nonnull) id source;                 // 消息源,需要是UIResponder 类
@property (nonatomic, copy,   nullable) DOVHandleBlock callback;  // 消息中包含的可执行block

- (nullable instancetype)init NS_UNAVAILABLE;

/**
 *  新建一个消息
 *
 *  @param name   消息的名称；
 *  @param source 消息来源，一般为self; UIResponder 子类
 *  @description
 *          一条消息的组成为：
 *              CLASSNAME.MESSAGENAME   for example: ViewController.Helloworld
 *               其中，CLASSNAME 为消息想要发送到的对象；如想发给ViewController, 则CLASSNAME 设为 ViewController
 *                    MESSAGENAME 为本条消息的UUID, 如设定名为Helloworld.
 *
 *  @return 返回新建成功后的消息
 */
- (nullable instancetype)initWithName:(nonnull NSString *)name from:(nonnull id)source NS_DESIGNATED_INITIALIZER;

@end
