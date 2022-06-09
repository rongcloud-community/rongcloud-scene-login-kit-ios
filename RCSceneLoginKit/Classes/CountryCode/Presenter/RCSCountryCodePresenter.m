//
//  RCSCountryCodePresenter.m
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "RCSCountryCodePresenter.h"

@interface RCSCountryCodePresenter ()

@property (nonatomic, copy) NSArray<NSString *> *firstLetters;
@property (nonatomic, strong) NSArray<RCSCountryInfo *> *countryList;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<RCSCountryInfo *> *> *countryGroup;

@end

@implementation RCSCountryCodePresenter

- (instancetype)init {
    if (self = [super init]) {
        [self loadCountry];
    }
    return self;
}

- (void)loadCountry {
    NSString *bundles = [[NSBundle bundleForClass:self.class] resourcePath];
    NSString *string = [[NSBundle bundleWithPath:bundles] pathForResource:RCSLoginBundleName ofType:@"bundle"];
    NSString *path = [[NSBundle bundleWithPath:string] pathForResource:@"countrycode" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    self.countryList = [NSArray yy_modelArrayWithClass:RCSCountryInfo.class json:data];
    self.firstLetters = [self firstLetterArray:self.countryList];
    self.countryGroup = [self sortObjectArray:self.countryList];
}

#pragma mark - public method
- (NSArray<NSString *> *)fetchIndexTitles {
    return self.firstLetters;
}

- (NSDictionary<NSString *, NSArray<RCSCountryInfo *> *> *)fetchCountryGroup {
    return self.countryGroup;
}

- (NSArray<RCSCountryInfo *> *)fetchCountryWithKeyWord:(NSString *)keyword {
    NSString *searchKey = [keyword stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *filterArr = @[];
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\+?\\d+$"];
    BOOL numExist = [numberPredicate evaluateWithObject:searchKey];
    
    NSPredicate *letterPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z]+$"];
    BOOL letterExist = [letterPredicate evaluateWithObject:searchKey];
    
    NSPredicate *chinesePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\\u4e00-\\u9fa5]+$"];
    BOOL chineseExit = [chinesePredicate evaluateWithObject:searchKey];
    
    if (numExist) {
        filterArr = [self.countryList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(RCSCountryInfo *evaluatedObject, NSDictionary *bindings) {            
            return [evaluatedObject.code containsString:searchKey];;
        }]];
        return filterArr;
    } else if (letterExist) {
        filterArr = [self.countryList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(RCSCountryInfo *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.en containsString:searchKey];;
        }]];
        return filterArr;
    } else if (chineseExit) {
        filterArr = [self.countryList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(RCSCountryInfo *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.cn containsString:searchKey];;
        }]];
        return filterArr;
    }
    
    return filterArr;
}

#pragma mark - private method
//- (BOOL)

- (NSArray<NSString *> *)firstLetterArray:(NSArray<RCSCountryInfo *> *)arr {
    NSMutableSet *set = [NSMutableSet new];
    for (RCSCountryInfo *obj in arr) {
        NSString *firstLetter = [obj.en.uppercaseString substringToIndex:1];
        [set addObject:firstLetter];
    }
    
    return [[set allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

/// 给对象数组排序
- (NSDictionary<NSString *, NSArray<RCSCountryInfo *> *> *)sortObjectArray:(NSArray<RCSCountryInfo *> *)objectArray {
    NSMutableDictionary *tempDic = [NSMutableDictionary new];
    NSArray *sortFirstLetterArr = self.firstLetters;
    for (NSString *firstLetter in sortFirstLetterArr) {
        NSMutableArray *temArr = tempDic[firstLetter] ?: [NSMutableArray new];
        for (RCSCountryInfo *model in objectArray) {
            NSString *modelFirstLetter = [model.en.uppercaseString substringToIndex:1];
            if ([modelFirstLetter isEqualToString:firstLetter]) {
                [temArr addObject:model];
                [tempDic setValue:temArr forKey:firstLetter];
            }
        }
    }
    return tempDic;
}

@end
