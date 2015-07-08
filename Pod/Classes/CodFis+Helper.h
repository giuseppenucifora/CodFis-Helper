//
//  CodFis+Helper.h
//  Pods
//
//  Created by Giuseppe Nucifora on 08/07/15.
//
//

#import <Foundation/Foundation.h>

@interface CodFis_Helper : NSObject

typedef enum {
    Italy,
    OtherCountries
} State;

typedef enum {
    Gender_Woman,
    Gender_Man
} Gender;


@property (nonatomic, strong)   NSString *surname;
@property (nonatomic, strong)   NSString *name;
@property (nonatomic, strong)	NSString *birthDay;
@property (nonatomic, strong)	NSString *birthMonth;
@property (nonatomic, strong)	NSString *birthYear;
@property (nonatomic, assign)	Gender	gender;
@property (nonatomic, assign)   State	state;
@property (nonatomic, strong)   NSString *place;

- (NSString*) calculate;

- (BOOL) check:(NSString*) codFis;





@end
