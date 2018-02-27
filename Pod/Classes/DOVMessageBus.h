//
//  DOVMessageBus.h
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

/**
 *  @header      DOVMessageBus
 *  @abstract    Dove Message Bus 用来处理和发送相关的消息给UIResponderChain上的对象
 *  @author      圣迪
 *  @version     0.1
 *  @discussion  还需根据不同的应用场景决定需暴露的函数
 */
#import <Foundation/Foundation.h>
@class DOVMessage;

@interface DOVMessageBus : NSObject

/**
 *  发送需要的指定的message
 *
 *  @param message 需要发送的message
 */
+ (BOOL)sendMessage:(nonnull DOVMessage *)message;

@end
