//
//  XHScanToolController.h
//  XHScanTool
//
//  Created by TianGeng on 16/6/27.
//  Copyright © 2016年 bykernel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHScanToolController;

@protocol XHScanToolControllerDelegate <NSObject>
/**
 *  扫描成功的回掉函数
 *
 *  @param scanToolController 控制器
 *  @param result             扫描的内容
 */
- (void)scanToolController:(XHScanToolController *)scanToolController completed:(NSString *)result;

@end

@interface XHScanToolController : UIViewController

@property (nonatomic, weak) id <XHScanToolControllerDelegate> scanDelegate;

/**
 *  判断相机摄像头可用状态
 */
-(BOOL)isCameraAllowed;
/**
 * 判断权限
 */
-(BOOL)isCameraValid;

@end
