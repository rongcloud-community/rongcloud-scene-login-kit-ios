//
//  RCSCountryCodeTableViewCell.m
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "RCSCountryCodeTableViewCell.h"

@implementation RCSCountryCodeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        [self buildLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)buildLayout {
    self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
    }];
    
    [self.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.bottom.centerY.offset(0);
    }];
}

@end
