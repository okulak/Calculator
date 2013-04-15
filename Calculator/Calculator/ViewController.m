//
//  ViewController.m
//  Calculator
//
//  Created by Oleksandr Kulakov on 4/12/13.
//  Copyright (c) 2013 Oleksandr Kulakov. All rights reserved.
//

#include <math.h>
#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation ViewController
@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain)
    {
        _brain = [[CalculatorBrain alloc]init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    NSLog(@"User touched %@", digit);
//    UILabel *myDisplay = self.display; //[self display]
//    NSString *currentDisplayText = self.display.text;
//    NSString *newDisplayText = [currentDisplayText stringByAppendingString:digit];
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
       self.display.Text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;

}


- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperetion:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}


- (IBAction)pointPressed:(UIButton *)sender
{
    NSString *point = [sender currentTitle];
    NSRange range = [self.display.text rangeOfString:point];
    if (range.length == 0)
    {
        self.display.Text = [self.display.text stringByAppendingString:point];
        self.userIsInTheMiddleOfEnteringANumber = YES;
   
    }

    
}

- (IBAction)piPressed:(UIButton *)sender
{
    NSString * pi = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.Text = [self.display.text stringByAppendingString:pi];
    }
    else
    {
        self.display.text = pi;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }

}
- (IBAction)cPressed
{
    self.brain = nil;
    self.display.text = [NSString stringWithFormat:@"0"];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)functionPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }

    NSString *function = [sender currentTitle];
    double result = [self.brain performFunction:function];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}


@end
