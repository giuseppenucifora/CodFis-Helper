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
@property (nonatomic)	NSInteger birthDay;
@property (nonatomic)	NSInteger birthMonth;
@property (nonatomic)	NSInteger birthYear;
@property (nonatomic, assign)	Gender	gender;
@property (nonatomic, assign)   State	state;
@property (nonatomic, strong)   NSString *place;
@property (nonatomic) BOOL collision;

- (NSString*) calculate;

- (BOOL) check:(NSString*) codFis;





@end
