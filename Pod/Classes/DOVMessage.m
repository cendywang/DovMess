//
//  DOVMessage.m
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


#import "DOVMessage.h"
@import UIKit;


#if !__has_feature(objc_arc)
#error DovMess must be built with ARC.
// You can turn on ARC for only DovMess files by adding -fobjc-arc to the build phase for each of its files.
#endif

@implementation DOVMessage

- (instancetype)initWithName:(NSString *)name from:(id)source {
    self = [super init];
    if (self) {
        NSString *nameString = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (!name || !source || [nameString isEqualToString:@""]) {
            return nil;
        }
        if (![source isKindOfClass:[UIResponder class]]) {
            return nil;
        }
        NSArray *nameArray = [nameString componentsSeparatedByString:@"."];
        int count = (int)[nameArray count];
        if (count <= 0) {
            return nil;
        }
        self.name = count == 1 ? [NSString stringWithFormat:@"%@.%@", DOVE_MESSAGE_PREFIX,
                                  [nameArray[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]
                                : [NSString stringWithFormat:@"%@.%@.%@", DOVE_MESSAGE_PREFIX,
                                   [nameArray[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
                                   [nameArray[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        self.source = source;
    }
    return self;
}

#if DOV_MESS_TEST
- (void)dealloc {
    NSLog(@"Message %@ dealloc", self.name);
}
#endif

@end
