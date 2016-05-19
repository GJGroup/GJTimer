/*!
 @header     GJTimer.h
 @abstract   NSTimer's category
 @discussion NSTimer会强引用target而导致有可能出现循环引用的问题，该Category主要解决循环引用
             并简单的实现自释放功能，一个对象的timer属性或变量并不需要考虑在合适的时机调用invalidate
             timer会在该对象销毁的时候自动invalidate。
 @author     guoxiaoliang
 */

#import <Foundation/Foundation.h>

typedef void (^GJSimpleBlock)();

@interface NSTimer(GJWeakTimer)

/**
 *  创建timer对象
 *  @param ti      timeInterval
 *  @param yesOrNo repeat
 *  @param block   timer处理具体事件的回调
 *  @param aTarget 持有timer作为属性或字段的类
 *  @return timer对象
 */
+ (NSTimer *)gjw_scheduledWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(GJSimpleBlock)block target:(id)aTarget;

/**
 *  暂停
 */
- (void)gjw_pauseTimer;

/**
 *  复位
 */
- (void)gjw_resumeTimer;

/**
 *  delay interval 之后复位
 *  @param interval timeInterval
 */
- (void)gjw_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
