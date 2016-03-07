//
//  ViewController.m
//  CoreMotionDemo
//
//  Created by yz on 16/3/7.
//  Copyright © 2016年 DeviceOne. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
{
    CMMotionManager *mgr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化传感器管理类
    mgr = [[CMMotionManager alloc]init];
    
//    [self testAccelerometer];
    
//    [self testGyro];
    
//    [self testAltimeter];
    
//    [self testMagnetometer];
    [self testPedometer];
}
//加速度
- (void)testAccelerometer
{
    //判断是否可用
    if (!mgr.accelerometerAvailable) {
        return;
    }
    //设置更新的时间间隔
    mgr.accelerometerUpdateInterval = 0.1f;
    //开始更新数据
    [mgr startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        double x = accelerometerData.acceleration.x;
        double y = accelerometerData.acceleration.y;
        double z = accelerometerData.acceleration.z;
        
        NSLog(@"x = %f, y = %f, z= %f",x,y,z);
    }];

}
//陀螺仪
- (void)testGyro
{
    if (!mgr.gyroAvailable) {
        return;
    }
    mgr.gyroUpdateInterval = 0.1f;
    [mgr startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        double x = gyroData.rotationRate.x;
        double y = gyroData.rotationRate.y;
        double z = gyroData.rotationRate.z;
        NSLog(@"x = %f, y = %f, z= %f",x,y,z);
    }];
}
// 海拔
- (void)testAltimeter
{
    CMAltimeter *altimeter = [[CMAltimeter alloc]init];
    if (![CMAltimeter isRelativeAltitudeAvailable]) {
        return;
    }
    [altimeter startRelativeAltitudeUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAltitudeData * _Nullable altitudeData, NSError * _Nullable error) {
        NSLog(@"%@",altitudeData.relativeAltitude);
    }];
}
// 磁力
- (void) testMagnetometer
{
    if(!mgr.magnetometerAvailable)
    {
        return;
    }
    [mgr startMagnetometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
        double x = magnetometerData.magneticField.x;
        double y = magnetometerData.magneticField.y;
        double z = magnetometerData.magneticField.z;
        NSLog(@"x = %f, y = %f, z= %f",x,y,z);

    }];
}
- (void)testPedometer
{
    CMPedometer * pedometer = [[CMPedometer alloc]init];
    if (![CMPedometer isStepCountingAvailable]) {
        return;
    }
    [pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        //步数
        NSNumber * numberOfSteps = pedometerData.numberOfSteps;
        NSLog(@"numberOfSteps = %@",numberOfSteps);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
