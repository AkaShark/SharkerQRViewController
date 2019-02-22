//
//  SharkerQRViewController.h
//  SharkerQRViewController
//
//  Created by didi on 2019/1/27.
//  Copyright © 2019 Sharker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SharkerQRCodeScanner.h"

NS_ASSUME_NONNULL_BEGIN


/**
 二维码扫描VC 包含二维码扫描 扫描结果展示
 */
@interface SharkerQRViewController : UIViewController

@property (nonatomic,copy) ScannerResultBlock resultBlock;

@property (nonatomic,assign) BOOL isAlbum;

/**
 初始化方法

 @param overTime 设置超时时间 小于0则为无超时时间
 @return 返回扫码控制器对象
 */
- (instancetype)initWithOverTime:(NSUInteger)overTime;

@end

NS_ASSUME_NONNULL_END
