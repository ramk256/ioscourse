//
//  CalculatorBrain.h
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(NSString *)operand;
- (double)performOperation:(NSString *)op
       usingVariableValues:(NSDictionary *)variableValues;
- (void)clearStack;

@property (nonatomic, readonly) id program;



+ (NSString *)descriptionOfProgram:(id)program;

//runProgram is just popping off the top of the stack. if it is an operand, return the operand
//if it is an operator, evaluate the operator
+ (double)runProgram:(id)program;

+ (double)runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues;

+ (NSSet *)variablesUsedInProgram:(id)program;

@end
