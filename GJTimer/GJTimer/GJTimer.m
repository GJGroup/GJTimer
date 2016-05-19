
#import "GJTimer.h"
#import <objc/runtime.h>

@interface NSObject(GJTimerTarget)

@end

@implementation NSObject(GJTimerTarget)

- (void)gjw_dealloc {
    u_int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString *ivarName = [[NSString alloc] initWithCString:ivar_getTypeEncoding(ivars[i]) encoding:NSUTF8StringEncoding];
        if ([ivarName rangeOfString:@"NSTimer"].location != NSNotFound) {
            NSTimer *tempTimer = (NSTimer *)object_getIvar(self, ivars[i]);
            if (tempTimer.isValid) {
                [tempTimer invalidate];
            }
        }
    }
    [self gjw_dealloc];
}

@end


@implementation NSTimer(GJWeakTimer)

#pragma mark - public methods
+ (NSTimer *)gjw_scheduledWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(GJSimpleBlock)block target:(id)aTarget {
    NSTimer *tempTimer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(p_blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([aTarget class], NSSelectorFromString(@"dealloc")), class_getInstanceMethod([aTarget class], @selector(gjw_dealloc)));
    });
    return tempTimer;
}

- (void)gjw_pauseTimer {
    if (self.isValid) {
        [self setFireDate:[NSDate distantFuture]];
    }
}

- (void)gjw_resumeTimer {
    [self gjw_resumeTimerAfterTimeInterval:0];
}

- (void)gjw_resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
    }
}

#pragma mark - private methods
+ (void)p_blockInvoke:(NSTimer *)sender {
    GJSimpleBlock block = sender.userInfo;
    if (block) {
        block();
    }
}

@end
