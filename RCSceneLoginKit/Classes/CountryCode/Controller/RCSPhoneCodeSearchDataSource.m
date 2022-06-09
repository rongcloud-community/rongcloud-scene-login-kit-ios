//
//  RCSPhoneCodeSearchDataSource.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import "RCSPhoneCodeSearchDataSource.h"
#import "RCSCountryCodeTableViewCell.h"

@implementation RCSPhoneCodeSearchDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RCSCountryCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RCSCountryCodeTableViewCell.class)
                                                                        forIndexPath:indexPath];
    RCSCountryInfo *countryInfo = self.searchResult[indexPath.row];
    cell.textLabel.text = countryInfo.en;
    cell.detailTextLabel.text = countryInfo.code;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResult.count;
}

@end
