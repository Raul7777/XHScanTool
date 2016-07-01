//
//  ViewController.m
//  XHScanTool
//
//  Created by TianGeng on 16/6/24.
//  Copyright © 2016年 bykernel. All rights reserved.
//

#import "ViewController.h"
#import "XHScanToolController.h"

@interface ViewController ()<XHScanToolControllerDelegate>
@property (nonatomic, weak)  XHScanToolController *vc ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
//    XHScallTool *tool = [[XHScallTool alloc] init];
//    tool.frame = CGRectMake(50, 100, 200, 200);
//    [self.view addSubview:tool];
//    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 200, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"scan" forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scanError) name:@"scanError" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)buttonClick{
    XHScanToolController *vc = [[XHScanToolController alloc] init];

    
    NSLog(@"11");
    
    
    
    if (vc.isCameraValid && vc.isCameraAllowed) {
        self.vc = vc;
        vc.scanDelegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        if (!vc.isCameraAllowed) {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设备的设置-隐私-相机中允许访问相机。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

            [alertView show];
        }else if (!vc.isCameraValid){
           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查你的摄像头。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }

    }
    
}

- (void)scanToolController:(XHScanToolController *)scanToolController completed:(NSString *)result{
    [scanToolController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",result);
}

@end
