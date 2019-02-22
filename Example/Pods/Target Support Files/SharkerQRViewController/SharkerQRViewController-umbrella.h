#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SharkerQRCodeScanner.h"
#import "SharkerQRViewController.h"
#import "SharkerScanBackgroundView.h"
#import "UIButton+verticalImageAndTitle.h"

FOUNDATION_EXPORT double SharkerQRViewControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char SharkerQRViewControllerVersionString[];

