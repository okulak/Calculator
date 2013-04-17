//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Oleksandr Kulakov on 4/12/13.
//  Copyright (c) 2013 Oleksandr Kulakov. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()
@property (nonatomic) BOOL topOfTheLine;

@property (strong, nonatomic) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;
@synthesize topOfTheLine;

- (NSMutableArray *) operandStack
{
    if (!_operandStack)
    {
        _operandStack = [[NSMutableArray alloc]init];
    }
    return _operandStack;
}

- (void) pushOperand: (double) operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double) popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject)
    {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}


- (double) performOperetion: (NSString*) operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand]+[self popOperand];
    }
    else if ([operation isEqualToString:@"*"])
    {
        result = [self popOperand]*[self popOperand];
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor)
        {
            result = [self popOperand]/divisor;
        }        
    }
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        if (subtrahend!=0)
        {
           result = [self popOperand]-subtrahend;
        }     
    }
    [self pushOperand:result];
    return result;
}


- (double) performFunction: (NSString*) function
{
    double result = 0;
    
    if ([function isEqualToString:@"sin"])
    {
        result = (double) sin([self popOperand]);
       
    }
    else if ([function isEqualToString:@"cos"])
    {
        result = (double) cos([self popOperand]);
    }
    else if ([function isEqualToString:@"sqrt"])
    {
        if ([self.operandStack lastObject] >= 0)
        {
            result = (double) sqrt([self popOperand]);
        }
        else
        {
            return 0;
        }  
    }
    else if ([function isEqualToString:@"log"])
    {
        result = (double) log([self popOperand]);
    }
    else if ([function isEqualToString:@"e"])
    {
        result = (double) M_E;
    }
    if ([function isEqualToString:@"π"])
    {
       result = (double) M_PI;
    }
    [self pushOperand:result];
    return result;
}

- (int) lastValueLengh
{
    NSString * lastValue = [NSString stringWithFormat: @"%@", [self.operandStack lastObject]];
    int lastValueLenght = lastValue.length;
    NSLog(@"%i",lastValueLenght);
    return lastValueLenght;    
}

- (NSString *) lastObject
{
    NSNumber *object = [self.operandStack lastObject];
    NSString *result = [NSString stringWithFormat:@"%@", object];
    NSLog(@"%@", result);
    return result;
}

- (void) clearMemory
{
    [self.operandStack removeAllObjects];
}

- (double) plusMinus: (double) operation
{
    if (operation)
    {
        return -operation;
    }
    else
    {
        return 0;
    }    
}

@end
