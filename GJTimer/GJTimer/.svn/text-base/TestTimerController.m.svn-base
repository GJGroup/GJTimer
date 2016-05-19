//
//  TestTimerController.m
//  GJTimer
//
//  Created by 二亮子 on 16/4/21.
//  Copyright © 2016年 二亮子. All rights reserved.
//

#import "TestTimerController.h"
#import "GJTimer.h"

@interface TestTimerController ()

@end

@implementation TestTimerController {
    __weak IBOutlet UILabel *_testLabel;
    __weak NSTimer *_retainCycleTimer;
    NSTimer *_autoReleaseTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"type:%d", self.testType);
    
//    if (TestTypeRetainCycle == _testType) {
//        self.title = @"retain cycle!";
//        _retainCycleTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
//    } else if (TestTypeAutoRelease ==_testType) {
//        self.title = @"auto release";
//        __weak typeof(self) weakSelf = self;
//        _autoReleaseTimer = [NSTimer gjw_scheduledWithTimeInterval:1 repeats:YES block:^{
//            [weakSelf timerHandle];
//        } target:self];
//    }
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];
    
}

- (void)timerHandle {
    NSString *testStr = [NSString stringWithFormat:@"%@", @(arc4random() % 10000)];
    _testLabel.text = testStr;
    NSLog(@"testStr:%@", testStr);
}

- (void)dealloc {
    if (_retainCycleTimer.isValid) {
        [_retainCycleTimer invalidate];
    }
    
    [_autoReleaseTimer invalidate];
    
    NSLog(@"testTimerControlelr dealloc!");
}

@end
