#import <Foundation/Foundation.h>

#ifdef __OBJC__
typedef NS_ENUM(NSUInteger, RZActivityStatus) {
    RZActivityStatusBlocked,
    RZActivityStatusNotStarted,
    RZActivityStatusInProgress,
    RZActivityStatusComplete
};
#endif