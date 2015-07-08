//
//  CodFis+Helper.m
//  Pods
//
//  Created by Giuseppe Nucifora on 08/07/15.
//
//

#import "CodFis+Helper.h"

#define DEF_SURNAME_COD_LENGHT 3
#define DEF_NAME_COD_LENGHT 3

@implementation CodFis_Helper

- (instancetype) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString*) calculate {
    
    NSMutableString *resposeString = [[NSMutableString alloc] init];
    
    [resposeString appendString:[self getCodFisSurname]];
    
    [resposeString appendString:[self getCodFisName]];
    
    return resposeString;
}

- (BOOL) check:(NSString*) codFis {
    return YES;
}

- (NSString *) getCodFisSurname {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSString *vowels = @"aeiouàèìòùáéíóúäëïöü";
    NSString *chars = @"qwrtypsdfghjklzxcvbnm";
    
    NSArray* consonantsArray  = [[_surname lowercaseString] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:vowels]];
    NSArray* vowelArray = [[_surname lowercaseString] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:chars]];
    
    for (NSString *chr in consonantsArray) {
        if (![chr isEqualToString:@""]) {
            [resultString appendString:chr];
        }
    }
    
    if ([resultString length] >= DEF_SURNAME_COD_LENGHT) {
        return [[resultString substringToIndex:DEF_SURNAME_COD_LENGHT] uppercaseString];
    }
    
    for (NSString *chr in vowelArray) {
        if (![chr isEqualToString:@""]) {
            [resultString appendString:chr];
        }
    }
    
    if ([resultString length] >= DEF_SURNAME_COD_LENGHT) {
        [resultString setString:[resultString substringToIndex:DEF_SURNAME_COD_LENGHT]];
    }
    else {
        for(NSUInteger i = [resultString length]; i< DEF_SURNAME_COD_LENGHT;i++){
            [resultString appendString:@"x"];
        }
    }
    return [resultString uppercaseString];
}

- (NSString *) getCodFisName {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSString *vowels = @"aeiouàèìòùáéíóúäëïöü";
    NSString *chars = @"qwrtypsdfghjklzxcvbnm";
    
    NSMutableArray* consonantsArray  = [NSMutableArray arrayWithArray:[[_name lowercaseString] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:vowels]]];
    NSArray* vowelArray = [NSMutableArray arrayWithArray:[[_name lowercaseString] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:chars]]];
    
    for (NSString *chr in [consonantsArray mutableCopy]) {
        if ([chr isEqualToString:@""]) {
            [consonantsArray removeObject:chr];
        }
    }
    
    if ([consonantsArray count] > DEF_NAME_COD_LENGHT) {
        [resultString appendString:[consonantsArray objectAtIndex:0]];
        [resultString appendString:[consonantsArray objectAtIndex:2]];
        [resultString appendString:[consonantsArray objectAtIndex:3]];
    }
    else {
        for (NSString *chr in consonantsArray) {
            if (![chr isEqualToString:@""]) {
                [resultString appendString:chr];
            }
        }
        
        if ([resultString length] >= DEF_SURNAME_COD_LENGHT) {
            return [[resultString substringToIndex:DEF_SURNAME_COD_LENGHT] uppercaseString];
        }
        
        for (NSString *chr in vowelArray) {
            if (![chr isEqualToString:@""]) {
                [resultString appendString:chr];
            }
        }
        
        if ([resultString length] >= DEF_SURNAME_COD_LENGHT) {
            [resultString setString:[resultString substringToIndex:DEF_SURNAME_COD_LENGHT]];
        }
        else {
            for(NSUInteger i = [resultString length]; i< DEF_SURNAME_COD_LENGHT;i++){
                [resultString appendString:@"x"];
            }
        }
    }
    
    /*for (NSString *chr in consonantsArray) {
        if (![chr isEqualToString:@""]) {
            [resultString appendString:chr];
        }
    }
    
    if ([resultString length] >= DEF_SURNAME_COD_LENGHT) {
        return [[resultString substringToIndex:DEF_SURNAME_COD_LENGHT] uppercaseString];
    }
    
    for (NSString *chr in vowelArray) {
        if (![chr isEqualToString:@""]) {
            [resultString appendString:chr];
        }
    }
    
    if ([resultString length] >= DEF_SURNAME_COD_LENGHT) {
        [resultString setString:[resultString substringToIndex:DEF_SURNAME_COD_LENGHT]];
    }
    else {
        for(NSUInteger i = [resultString length]; i< DEF_SURNAME_COD_LENGHT;i++){
            [resultString appendString:@"x"];
        }
    }*/
    return [resultString uppercaseString];
}

@end
