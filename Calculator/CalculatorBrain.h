//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Ram Kandasamy on 8/26/12.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearStack;

@end
