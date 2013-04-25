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
@property (nonatomic) BOOL topOfTheLine;
@property (nonatomic) BOOL checkForOperation;
@property (nonatomic) BOOL checkForVariables;

@end

@implementation ViewController
@synthesize display;
@synthesize secondDisplay;
@synthesize equal;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize topOfTheLine;
@synthesize brain = _brain;
@synthesize checkForOperation;
@synthesize checkForVariables;

- (CalculatorBrain *) brain
{
    if (!_brain)
    {
        _brain = [[CalculatorBrain alloc]init];
        [self.brain setTestVariableValue:[NSArray arrayWithObjects:[NSNumber numberWithDouble: 0], [NSNumber numberWithDouble: 0], [NSNumber numberWithDouble: 0], nil]];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    checkForOperation = NO;
    NSString *digit = [sender currentTitle];
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
    if (checkForVariables)
    {
        [self.brain pushVariable:self.display.text];
        checkForVariables = NO;
    }
    else
    {
        [self.brain pushOperand:[self.display.text doubleValue]];
    }
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;    
    if (topOfTheLine)
    {
        self.secondDisplay.text = [self.secondDisplay.text stringByAppendingString:@" "];
        self.secondDisplay.text = [self.secondDisplay.text stringByAppendingString:[self.brain lastObject]];        
    }
    else 
    {
        self.secondDisplay.text= [self.brain lastObject];
        topOfTheLine = YES;
    }
    checkForOperation = YES;
}


- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperetion:operation];
    NSString *secondResult = [self.brain performOperetion2];
    NSLog(@"secondResult = %@", secondResult);
        
    
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.secondDisplay.Text = [NSString stringWithFormat:@"%@", secondResult];

    checkForOperation = YES;
}


- (IBAction)pointPressed:(UIButton *)sender
{
    NSString *point = [sender currentTitle];
    NSRange range = [self.display.text rangeOfString:point];
    if (range.length == 0)
    {
        self.display.text = [self.display.text stringByAppendingString:point];
        self.userIsInTheMiddleOfEnteringANumber = YES;   
    }
}


- (IBAction)cPressed
{
    [self.brain clearMemory];
    self.display.text = [NSString stringWithFormat:@"0"];
    self.secondDisplay.text = [NSString stringWithFormat:@""];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.topOfTheLine = NO;
    checkForOperation = YES;
}

- (IBAction)setVariables:(id)sender
{
    NSArray *testValues;
    NSString *test = [sender currentTitle];
    if ([test isEqualToString:@"Test 1"])
    {
        testValues = [NSArray arrayWithObjects:[NSNumber numberWithDouble: 0], [NSNumber numberWithDouble: 0], [NSNumber numberWithDouble: 0], nil];
        [self.brain setTestVariableValue: testValues];
        self.variablesValue.text = [NSString stringWithFormat:@"x = %@  a = %@  b = %@", [testValues objectAtIndex:0], [testValues objectAtIndex:1], [testValues objectAtIndex: 2]];
        
    }
    else if ([test isEqualToString:@"Test 2"])
    {
        testValues = [NSArray arrayWithObjects: [NSNumber numberWithDouble: 0], [NSNumber numberWithDouble: 3], [NSNumber numberWithDouble: 4], nil];
        [self.brain setTestVariableValue: testValues];
        self.variablesValue.text = [NSString stringWithFormat:@"x = %@  a = %@  b = %@", [testValues objectAtIndex: 0], [testValues objectAtIndex: 1], [testValues objectAtIndex: 2]];
    }
    else if ([test isEqualToString:@"Test 3"])
    {
        testValues = [NSArray arrayWithObjects:[NSNumber numberWithDouble: -4], [NSNumber numberWithDouble: 3],  [NSNumber numberWithDouble: 0], nil];
        [self.brain setTestVariableValue: testValues];
        self.variablesValue.text = [NSString stringWithFormat:@"x = %@  a = %@  b = %@", [testValues objectAtIndex:0], [testValues objectAtIndex:1], [testValues objectAtIndex: 2]];
    }
}

- (IBAction)variablesPressed:(id)sender
{
    checkForVariables = YES;
    checkForOperation = NO;
    NSString *digit = [sender currentTitle];
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

@end
