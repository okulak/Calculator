//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Oleksandr Kulakov on 4/12/13.
//  Copyright (c) 2013 Oleksandr Kulakov. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain ()

@property (strong, nonatomic) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

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
        result = [self popOperand]-[self popOperand];
    }
    
    [self pushOperand:result];
    return result;
}


@end
