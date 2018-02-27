//
//  DOVViewController.m
//  DovMess
//
//  Created by cendywang on 10/21/2015.
//  Copyright (c) 2015 cendywang. All rights reserved.
//

#import "DOVViewController.h"
#import <DovMess/DOVMessage.h>

@interface DOVViewController ()

@end

@implementation DOVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

DOVE_MESSAGE_HANDLER2(ViewController, holy, message) {
    NSLog(@"I'm ViewController , I already handled this message");
}

@end
