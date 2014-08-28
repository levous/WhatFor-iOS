#import <Foundation/Foundation.h>

#ifdef __OBJC__
typedef NS_ENUM(NSUInteger, RZActivityStatus) {
    RZActivityStatusUnknown,
    RZActivityStatusInProgress,
    RZActivityStatusComplete,
    RZActivityStatusBlocked
};
#endif