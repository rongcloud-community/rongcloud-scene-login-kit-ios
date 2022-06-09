//
//  RCSCountryCodePresenter.h
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import <Foundation/Foundation.h>
#import "RCSCountryInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCSCountryCodePresenter : NSObject

- (NSArray<NSString *> *)fetchIndexTitles;
- (NSDictionary<NSString *, NSArray<RCSCountryInfo *> *> *)fetchCountryGroup;
- (NSArray<RCSCountryInfo *> *)fetchCountryWithKeyWord:(NSString *)keyword;

@end

NS_ASSUME_NONNULL_END
