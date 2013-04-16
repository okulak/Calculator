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

@end

@implementation ViewController
@synthesize display;
@synthesize secondDisplay;
@synthesize equal;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize topOfTheLine;
@synthesize brain = _brain;
@synthesize checkForOperation;

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
    checkForOperation = NO;
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
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:[sender currentTitle]];
    self.equal.text = @"=";
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

    self.secondDisplay.text = [self.secondDisplay.text stringByAppendingString:[sender currentTitle]];
}


- (IBAction)cPressed
{
    self.brain = nil;
    self.display.text = [NSString stringWithFormat:@"0"];
    self.secondDisplay.text = [NSString stringWithFormat:@""];
    self.equal.text = @"";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.topOfTheLine = NO;
    checkForOperation = YES;
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
    self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:[sender currentTitle]];
    self.equal.text = @"=";
    topOfTheLine = YES;
    
}

- (IBAction)backspacePressed
{
    if (self.display.text.length)
    {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
    }
    

    
    
}

- (IBAction)plusMinusPressed:(UIButton *)sender
{
    if (!checkForOperation)
    {
        if (self.userIsInTheMiddleOfEnteringANumber)
        {
            [self enterPressed];
        }
        NSString *operation = [sender currentTitle];
        double lenght = [self.brain lastValueLengh];
        self.secondDisplay.text = [self.secondDisplay.text substringToIndex:[self.secondDisplay.text length]-(lenght)];
        self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:@"(-"];
        self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:[self.brain lastObject]];
        self.secondDisplay.Text = [self.secondDisplay.text stringByAppendingString:@")"];
        NSLog(@"%g", lenght);
        double result = [self.brain performOperetion:operation];
        self.display.text = [NSString stringWithFormat:@"%g", result];
        checkForOperation = YES;
        }
    }


@end
