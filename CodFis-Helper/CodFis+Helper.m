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
    
    [resposeString appendString:[self getCodFisYear]];
    
    [resposeString appendString:[self getCodFisMonth]];
    
    [resposeString appendString:[self getCodFisDay]];
    
    [resposeString appendString:[self getCodFisPlace]];
    
    return [resposeString stringByReplacingOccurrencesOfString:@" " withString:@""];
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
    return [resultString uppercaseString];
}

- (NSString *) getCodFisYear {
    
    if (_birthYear < 100) {
        return [NSString stringWithFormat:@"%ld",_birthYear];
    }
    else {
        NSString * allDigits = [NSString stringWithFormat:@"%ld",_birthYear];
        return [allDigits substringWithRange:NSMakeRange(allDigits.length -2, 2)];
    }
    return nil;
}

- (NSString *) getCodFisMonth {
    
    NSArray *mounths = @[@"A",@"B",@"C",@"D",@"E",@"H",@"L",@"M",@"P",@"R",@"S",@"T"];
    
    if (_birthMonth <= 12) {
        return [mounths objectAtIndex:_birthMonth-1];
    }
    return nil;
}

- (NSString *) getCodFisDay {
    
    NSInteger increment = 0;
    switch (_gender) {
        case Gender_Woman:
            increment = 40;
            break;
        case Gender_Man:
        default: {
            increment = 0;
        }
            break;
    }
    
    BOOL checkMonth = NO;
    switch (_birthMonth) {
        case 2:{
            if(_birthDay < 29) {
                checkMonth = YES;
            }
        }
            break;
        case 4:
        case 6:
        case 9:
        case 11:{
            if(_birthDay < 30) {
                checkMonth = YES;
            }
        }
            break;
        default:{
            if(_birthDay < 31) {
                checkMonth = YES;
            }
        }
            break;
    }
    if (checkMonth) {
        return [NSString stringWithFormat:@"%02ld",_birthDay + increment];
    }
    
    return nil;
}

- (NSString *) getCodFisPlace {
    
    NSError *error = nil;
    
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSData alloc] initWithContentsOfFile:[self getCodFisPlaceListFile] options:NSDataReadingMappedAlways error:&error]];

    NSLog(@"%@",dict);
    
    return nil;
}

- (NSString*) getCodFisPlaceListFile {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"codFisCodes" ofType:@"json"];
    
    return filePath;
}

@end
