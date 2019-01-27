//
//  SharkerQRCodeScanner.h
//  SharkerQRViewController
//
//  Created by didi on 2019/1/27.
//  Copyright © 2019 Sharker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^ScannerResultBlock)(NSString *codeString);
typedef BOOL(^ScannerisAuthorization)(BOOL isAuthorization);
/**
 二维码扫描器
 */
@interface SharkerQRCodeScanner : NSObject
@property (nonatomic,copy,nullable) ScannerResultBlock resultBlock;
@property (nonatomic,copy) ScannerisAuthorization authorizationBlock;

- (instancetype)initWitchScannerSuperView:(UIView *)superView scanRect:(CGRect)scanRect;

- (void)startScan;
- (void)stopScan;

- (BOOL)isSwitchOn;
- (void)switchTorch:(BOOL)isOn;

- (void)scQrReaderForImage:(UIImage *)qrimage;

@end

NS_ASSUME_NONNULL_END
