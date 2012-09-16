//
//  ViewController.m
//  Calculator
//
//  Created by Ram Kandasamy on 8/25/12.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL hasDecimalPoint;

@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController
@synthesize display = _display;
@synthesize stackDisplay = _stackDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize hasDecimalPoint = _hasDecimalPoint;
@synthesize brain = _brain;


- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if ([digit isEqualToString:@"."]) {
        if (!self.hasDecimalPoint) {
            self.hasDecimalPoint = YES;
        } else {
            return;
        }
    }
    
  //  NSLog(@"user touched %@", digit);
    if (self.userIsInTheMiddleOfEnteringANumber) {
    
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
                    
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}


- (IBAction)enterPressed {
    double value = [self.display.text doubleValue];
    NSString *valueString = [NSString stringWithFormat:@"%@ ", self.display.text];
    
     [self.brain pushOperand:value];
    self.stackDisplay.text = [self.stackDisplay.text stringByAppendingString:valueString];
    
     self.userIsInTheMiddleOfEnteringANumber = NO;
    self.hasDecimalPoint = NO;
}


- (IBAction)clearEverything {
    self.display.text = @"0";
    self.stackDisplay.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.hasDecimalPoint = NO;
    
    [self.brain clearStack];
}
 


- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    NSString *operationStack = [NSString stringWithFormat:@"%@ ", operation];
    
    self.stackDisplay.text = [self.stackDisplay.text stringByAppendingString:operationStack];
    
    double result = [self.brain performOperation:operation];
    
    self.display.text = [NSString stringWithFormat:@"%g", result];
}



- (void)viewDidUnload {
    [self setStackDisplay:nil];
    [super viewDidUnload];
}
@end
