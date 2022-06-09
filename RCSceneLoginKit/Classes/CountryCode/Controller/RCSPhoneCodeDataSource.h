//
//  RCSPhoneCodeDataSource.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import <Foundation/Foundation.h>
#import "RCSCountryInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCSPhoneCodeDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, copy) NSArray<NSString *> *indexTitles;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<RCSCountryInfo *> *> *countryGroup;

@end

NS_ASSUME_NONNULL_END
