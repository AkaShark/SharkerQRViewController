//
//  SharkerQRCodeScanner.m
//  SharkerQRViewController
//
//  Created by didi on 2019/1/27.
//  Copyright © 2019 Sharker. All rights reserved.
//

#import "SharkerQRCodeScanner.h"
#import <AVFoundation/AVFoundation.h>

@interface SharkerQRCodeScanner()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong) UIView *scannerSuperView;
@property (nonatomic,assign) CGRect availableScanRect;
@property (nonatomic,strong) AVCaptureDevice *device;
@property (nonatomic,strong) AVCaptureDeviceInput *input;
@property (nonatomic,strong) AVCaptureMetadataOutput *outupt;
@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation SharkerQRCodeScanner

- (void)dealloc{
    self.resultBlock = nil;
}
- (instancetype)initWitchScannerSuperView:(UIView *)superView scanRect:(CGRect)scanRect{
    self = [super init];
    if (self) {
        self.scannerSuperView = superView;
        scanRect.origin.y -= 64;
        self.availableScanRect = scanRect;
        [self setupScanner];
    }
    return self;
}

- (void)setupScanner{
//    camera authorization
    if (self.authorizationBlock) {
        if ([self isAuthorization]) {
            self.authorizationBlock(YES);
        }else{
            self.authorizationBlock(NO);
            return;
        }
    }
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    _outupt = [[AVCaptureMetadataOutput alloc] init];
    [_outupt setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    if ([_session canAddOutput:_outupt]) {
        [_session addOutput:_outupt];
    }
    _outupt.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = _scannerSuperView.layer.bounds;
    [_scannerSuperView.layer insertSublayer:_previewLayer atIndex:0];
    
    
}
- (BOOL)isAuthorization{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((status == AVAuthorizationStatusRestricted) || (status == AVAuthorizationStatusDenied)) {
        return NO;
    }else{
        return YES;
    }
}

- (void)startScan{
    if (!_session.isRunning) {
        [_session startRunning];
    }
}
- (void)stopScan{
    if (_session.isRunning) {
        [_session stopRunning];
    }
}
- (BOOL)isSwitchOn{
    if (_device.hasTorch && (AVCaptureTorchModeOn == _device.torchMode)) {
        return YES;
    }
    return NO;
}

- (void)switchTorch:(BOOL)isOn{
    if (_device.hasTorch) {
        NSError *error;
        BOOL b = [_device lockForConfiguration:&error];
        if (!b) {
            if (error) {
                NSLog(@"lock torch configuration error:%@",error.localizedDescription);
            }
            return;
        }
        _device.torchMode = isOn?AVCaptureTorchModeOn:AVCaptureTorchModeOff;
        [_device unlockForConfiguration];
    }
}

- (void)scQrReaderForImage:(UIImage *)qrimage{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detctor = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:qrimage.CGImage];
    NSArray *features = [detctor featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    NSString *stringValue = feature.messageString;
    if (self.resultBlock) {
        self.resultBlock(stringValue);
    }
}

#pragma mark - AVcaptureMatadataOutputObjectsDeleagte

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue = nil;
    if (metadataObjects.count >0 ) {
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *codeObject = [metadataObjects objectAtIndex:0];
        
        stringValue = codeObject.stringValue;
        if (self.resultBlock) {
            self.resultBlock(stringValue);
        }
    }
}


@end
