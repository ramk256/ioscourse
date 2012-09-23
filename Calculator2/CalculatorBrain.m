//
//  CalculatorBrain.m
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University.
//  All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

//this is the getter for the program property
- (id)program
{
    return [self.programStack copy];
}

/**
 * This will give an appropriate description of what is stored on the program stack.
 */

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in Homework #2";
}

- (void)pushOperand:(NSString *)operand
{
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
    
    NSNumber *number = [numFormat numberFromString:operand];
    
    if (number) {
        [self.programStack addObject:number];
    } else {
        [self.programStack addObject:operand];
    }
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack usingVariableValues:(NSDictionary *)variableValues
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack usingVariableValues:variableValues] +
            [self popOperandOffProgramStack:stack usingVariableValues:variableValues];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack usingVariableValues:variableValues] *
            [self popOperandOffProgramStack:stack usingVariableValues:variableValues];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffProgramStack:stack usingVariableValues:variableValues];
            result = [self popOperandOffProgramStack:stack usingVariableValues:variableValues] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffProgramStack:stack usingVariableValues:variableValues];
            if (divisor) result = [self popOperandOffProgramStack:stack usingVariableValues:variableValues] / divisor;
        } else if ([operation isEqualToString:@"sin"]) {
            result = sin([self popOperandOffProgramStack:stack usingVariableValues:variableValues]);
        } else if ([operation isEqualToString:@"cos"]) {
            result = cos([self popOperandOffProgramStack:stack usingVariableValues:variableValues]);
        } else if ([operation isEqualToString:@"sqrt"]) {
            result = sqrt([self popOperandOffProgramStack:stack usingVariableValues:variableValues]);
        } else {
          //this case corresponds to operation being a variable, we return the value
          //it maps to in the dictionary
            if (!variableValues) {
                result = 0;
            } else {            
                result = [(NSNumber *)[variableValues objectForKey:operation] doubleValue];
            }
        }
    }
    
    return result;
}

- (void)clearStack
{
    //we just  the stack, thereby removing everything on there
    _programStack = Nil;
}


+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack usingVariableValues:Nil];
    
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack usingVariableValues:variableValues];
    
}

+ (NSSet *)variablesUsedInProgram:(id)program
{
    NSMutableArray * array = (NSMutableArray *)program;
    NSMutableSet * variableSet = [[NSMutableSet alloc] init];
    //just iterate through the program array and add variables as needed
    for (id stackArg in array) {
        if ([stackArg isKindOfClass:[NSString class]]) {
            if (![stackArg isEqualToString:@"+"] && 
                ![stackArg isEqualToString:@"-"] &&
                ![stackArg isEqualToString:@"*"] &&
                ![stackArg isEqualToString:@"/"] &&
                ![stackArg isEqualToString:@"cos"] &&
                ![stackArg isEqualToString:@"sin"] &&
                ![stackArg isEqualToString:@"sqrt"]) {
            NSString *variable = stackArg;
            [variableSet addObject:variable];
            }
        }
    }
    
    return [variableSet copy];
}

@end

