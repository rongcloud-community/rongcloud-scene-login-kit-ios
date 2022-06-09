//
//  RCSPhoneCodeSearchDataSource.h
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import <Foundation/Foundation.h>
#import "RCSCountryInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCSPhoneCodeSearchDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSArray<RCSCountryInfo *> *searchResult;

@end

NS_ASSUME_NONNULL_END
