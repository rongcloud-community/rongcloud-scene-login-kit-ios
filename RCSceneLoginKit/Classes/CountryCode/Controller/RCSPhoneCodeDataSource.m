//
//  RCSPhoneCodeDataSource.m
//  RCSceneLoginKit
//
//  Created by 彭蕾 on 2022/6/8.
//

#import "RCSPhoneCodeDataSource.h"
#import "RCSCountryCodeTableViewCell.h"

@implementation RCSPhoneCodeDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RCSCountryCodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RCSCountryCodeTableViewCell.class)
                                                                        forIndexPath:indexPath];
    NSString *indexTitle = self.indexTitles[indexPath.section];
    NSArray *countryList = self.countryGroup[indexTitle];
    RCSCountryInfo *countryInfo = countryList[indexPath.row];
    cell.textLabel.text = countryInfo.en;
    cell.detailTextLabel.text = countryInfo.code;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *indexTitle = self.indexTitles[section];
    NSArray *countryList = self.countryGroup[indexTitle];
    return countryList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexTitles.count;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexTitles;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section >= self.indexTitles.count) {
        return @"";
    }
    return self.indexTitles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return 36;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont systemFontOfSize:14.0];
}

@end
