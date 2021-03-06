//
//  ViewController.h
//  Calculator
//
//  Created by Ram Kandasamy on 8/25/12.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *stackDisplay;
@property (weak, nonatomic) IBOutlet UILabel *variableDisplay;

@property (nonatomic, strong) NSDictionary *testVariableValues;

- (NSString *)getVariableValues;
@end
