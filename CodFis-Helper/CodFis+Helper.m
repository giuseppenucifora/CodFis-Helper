//
//  CodFis+self.m
//  Pods
//
//  Created by Giuseppe Nucifora on 08/07/15.
//
//

#import "CodFis+Helper.h"

#define DEF_SURNAME_COD_LENGHT 3
#define DEF_NAME_COD_LENGHT 3

@interface CodFis_Helper() {
    
    NSNumberFormatter* numberFormatter;
}

@property (nonatomic, strong) NSString *codFis;

@end

@implementation CodFis_Helper

+ (CodFisResponse*) calculateFromSurname:(NSString*) surname name:(NSString*) name birthDay:(NSInteger) birthDay birthMonth:(NSInteger) birthMonth birthYear:(NSInteger) birthYear gender:(Gender) gender state:(State) state place:(NSString*) place collision:(BOOL) collision {
    
    return [[[self alloc] initFromSurname:surname name:name birthDay:birthDay birthMonth:birthMonth birthYear:birthYear gender:gender state:state place:place collision:collision] calculate];
}

+ (BOOL) checkCodFisFromSurname:(NSString*) surname name:(NSString*) name birthDay:(NSInteger) birthDay birthMonth:(NSInteger) birthMonth birthYear:(NSInteger) birthYear gender:(Gender) gender state:(State) state place:(NSString*) place collision:(BOOL) collision andCodFis:(NSString*) codFis {
    
    return [[[self alloc] initFromSurname:surname name:name birthDay:birthDay birthMonth:birthMonth birthYear:birthYear gender:gender state:state place:place collision:collision] check:codFis];
}

- (instancetype) initFromSurname:(NSString*) surname name:(NSString*) name birthDay:(NSInteger) birthDay birthMonth:(NSInteger) birthMonth birthYear:(NSInteger) birthYear gender:(Gender) gender state:(State) state place:(NSString*) place collision:(BOOL) collision {
    
    self = [super init];
    
    if (self) {
        
        [self setSurname:surname];
        
        [self setName:name];
        
        [self setBirthDay:birthDay];
        
        [self setBirthMonth:birthMonth];
        
        [self setBirthYear:birthYear];
        
        [self setGender:gender];
        
        [self setState:state];
        
        [self setPlace:place];
    }
    return self;
}



- (CodFisResponse*) calculate {
    
    NSError *error;
    
    NSMutableString *resposeString = [[NSMutableString alloc] init];
    
    NSString *tempResponse = [self getCodFisSurname];
    
    if (!tempResponse) {
        error = [NSError errorWithDomain:NSLocalizedString(@"Bad Request in Surname", @"") code:ResponseStatusBadRequest userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:ResponseStatusBadRequest],@"Code",NSLocalizedString(@"Bad Request in Surname", @""),@"Message", nil],@"Meta", nil]];
    }
    else {
        [resposeString appendString:tempResponse];
    }
    
    tempResponse = [self getCodFisName];
    
    if (!tempResponse) {
        error = [NSError errorWithDomain:NSLocalizedString(@"Bad Request in Name", @"") code:ResponseStatusBadRequest userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:ResponseStatusBadRequest],@"Code",NSLocalizedString(@"Bad Request in Name", @""),@"Message", nil],@"Meta", nil]];
    }
    else {
        [resposeString appendString:tempResponse];
    }
    
    tempResponse = [self getCodFisYear];
    
    if (!tempResponse) {
        error = [NSError errorWithDomain:NSLocalizedString(@"Bad Request in Year", @"") code:ResponseStatusBadRequest userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:ResponseStatusBadRequest],@"Code",NSLocalizedString(@"Bad Request in Year", @""),@"Message", nil],@"Meta", nil]];
    }
    else {
        [resposeString appendString:tempResponse];
    }

    tempResponse = [self getCodFisMonth];
    
    if (!tempResponse) {
        error = [NSError errorWithDomain:NSLocalizedString(@"Bad Request in Month", @"") code:ResponseStatusBadRequest userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:ResponseStatusBadRequest],@"Code",NSLocalizedString(@"Bad Request in Month", @""),@"Message", nil],@"Meta", nil]];
    }
    else {
        [resposeString appendString:tempResponse];
    }
    
    tempResponse = [self getCodFisDay];
    
    if (!tempResponse) {
        error = [NSError errorWithDomain:NSLocalizedString(@"Bad Request in Day", @"") code:ResponseStatusBadRequest userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:ResponseStatusBadRequest],@"Code",NSLocalizedString(@"Bad Request in Day", @""),@"Message", nil],@"Meta", nil]];
    }
    else {
        [resposeString appendString:tempResponse];
    }
    
    tempResponse = [self getCodFisPlace];
    
    if (!tempResponse) {
        error = [NSError errorWithDomain:NSLocalizedString(@"Bad Request in Place", @"") code:ResponseStatusBadRequest userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:ResponseStatusBadRequest],@"Code",NSLocalizedString(@"Bad Request in Place", @""),@"Message", nil],@"Meta", nil]];
    }
    else {
        [resposeString appendString:tempResponse];
    }
    
    
    
    _codFis = [resposeString stringByReplacingOccurrencesOfString:@" " withString:@""];;
    
    [resposeString appendString:[self getCodFisControlCode]];
    
    return [[CodFisResponse alloc] initWithResponse:resposeString andError:error];
}

- (BOOL) check:(NSString*) codFis {
    
    return [[[self calculate] response] isEqualToString:[codFis uppercaseString]];
}

- (NSString *) getCodFisSurname {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSMutableArray *consonantsArray = [NSMutableArray arrayWithArray:[self getConsonantArray:_surname]];
    
    NSMutableArray *vowelArray = [NSMutableArray arrayWithArray:[self getVowelsArray:_surname]];
    
    for (NSString *chr in consonantsArray) {
        if (![chr isEqualToString:@""]) {
            [resultString appendString:chr];
        }
    }
    
    if ([resultString length] > DEF_SURNAME_COD_LENGHT) {
        return [[resultString substringToIndex:DEF_SURNAME_COD_LENGHT] uppercaseString];
    }
    
    for (NSString *chr in vowelArray) {
        if (![chr isEqualToString:@""]) {
            [resultString appendString:chr];
        }
    }
    
    if ([resultString length] > DEF_SURNAME_COD_LENGHT) {
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
    
    NSMutableArray *consonantsArray = [NSMutableArray arrayWithArray:[self getConsonantArray:_name]];
    
    NSMutableArray *vowelArray = [NSMutableArray arrayWithArray:[self getVowelsArray:_name]];
    
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
        
        if ([resultString length] > DEF_SURNAME_COD_LENGHT) {
            return [[resultString substringToIndex:DEF_SURNAME_COD_LENGHT] uppercaseString];
        }
        
        for (NSString *chr in vowelArray) {
            if (![chr isEqualToString:@""]) {
                [resultString appendString:chr];
            }
        }
        
        if ([resultString length] > DEF_SURNAME_COD_LENGHT) {
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
        return [NSString stringWithFormat:@"%ld",(long)_birthYear];
    }
    else {
        NSString * allDigits = [NSString stringWithFormat:@"%ld",(long)_birthYear];
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
        return [NSString stringWithFormat:@"%02ld",(long)_birthDay + increment];
    }
    
    return nil;
}

- (NSArray*) getConsonantArray:(NSString*) string {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([A,Á,Ã,E,É,Ê,I,Í,O,Ô,Ó,Õ,U,Û,Ü,Ú]?)" options:NSRegularExpressionCaseInsensitive error:nil];
    
    string = [[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *resultString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
    
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [resultString length]; i++) {
        [responseArray addObject:[resultString substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return responseArray;
}

- (NSArray*) getVowelsArray:(NSString *) string {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([Q,W,R,T,Y,P,S,D,F,G,H,J,K,L,Z,X,C,V,B,N,M]?)" options:NSRegularExpressionCaseInsensitive error:nil];
    
    string = [[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *resultString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
    
    NSMutableArray *responseArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [resultString length]; i++) {
        [responseArray addObject:[resultString substringWithRange:NSMakeRange(i, 1)]];
    }
    
    return responseArray;
}

- (NSString *) getCodFisPlace {
    
    NSString *responseString;
    
    NSError *error = nil;
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:[self getCodFisPlaceListFile] options:NSDataReadingMappedAlways error:&error];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    @try {
        responseString = [json objectForKey:[_place uppercaseString]];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        if (responseString) {
            return responseString;
        }
    }
    return nil;
}

- (NSString *) getCodFisControlCode {
    
    NSArray *contributeCode = @[@"1",@"0",@"5",@"7",@"9",@"13",@"15",@"17",@"19",@"21",@"2",@"4",@"18",@"20",@"11",@"3",@"6",@"8",@"12",@"14",@"16",@"10",@"22",@"25",@"24",@"23"];
    
    NSArray *reponseCode = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    
    NSInteger tempIndex = 0;
    
    NSInteger index = 1;
    for (NSString *chr in [self getcodFisArray]) {
        
        if ([self isNumeric:chr]) {
            
            if (index%2 == 0) {
                tempIndex += [chr integerValue];            }
            else {
                tempIndex += [[contributeCode objectAtIndex:[chr integerValue]] integerValue];
            }
        }
        else {
            if (index%2 == 0) {
                tempIndex += [self getAlphabetContributeCode:chr];
            }
            else {
                tempIndex += [[contributeCode objectAtIndex:[self getAlphabetContributeCode:chr]] integerValue];
            }
        }
        
        index++;
    }
    return [reponseCode objectAtIndex:ceil((int)tempIndex%26)];
}

- (NSInteger) getAlphabetContributeCode:(NSString *) chr {
    
    unichar c = [chr characterAtIndex:0];
    
    return (NSInteger)(((short)c)-65);
}


- (NSString*) getCodFisPlaceListFile {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"codFisCodes" ofType:@"json"];
    
    return filePath;
}

- (NSArray *) getcodFisArray
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i=0; i < _codFis.length; i++) {
        NSString *tmp_str = [_codFis substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:[tmp_str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return arr;
}

-(BOOL) isNumeric:(NSString*) hexText
{
    if (!numberFormatter) {
        numberFormatter = [[NSNumberFormatter alloc] init];
    }
    
    NSNumber* number = [numberFormatter numberFromString:hexText];
    
    if (number != nil) {
        return true;
    }
    
    return false;
}
@end
