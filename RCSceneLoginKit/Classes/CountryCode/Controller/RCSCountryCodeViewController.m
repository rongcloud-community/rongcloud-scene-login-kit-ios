//
//  RCSCountryCodeViewController.m
//  Pods-RCSceneLoginKit_Example
//
//  Created by 彭蕾 on 2022/6/2.
//

#import "RCSCountryCodeViewController.h"
#import "RCSPhoneCodeDataSource.h"
#import "RCSPhoneCodeSearchDataSource.h"
#import "RCSCountryCodePresenter.h"
#import "RCSCountryCodeTableViewCell.h"

@interface RCSCountryCodeViewController ()<UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, copy, nullable) NSString *searchText;
@property (nonatomic, assign) NSTimeInterval searchDelay;
@property (nonatomic, strong) RCSPhoneCodeDataSource *dataSource;
@property (nonatomic, strong) RCSPhoneCodeSearchDataSource *searchDataSource;
@property (nonatomic, strong) RCSCountryCodePresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RCSCountryCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchDelay = 0.5;
    [self buildLayout];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.searchController.active = NO;
}

- (void)buildLayout {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"选择国家和地区";
    UIImage *image = [RCSLoginImageNamed(@"back_indicator_image") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:image
                                             style:UIBarButtonItemStylePlain
                                             target:self action:@selector(back)];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
}

- (void)back {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchControllerDelegate
- (void)didDismissSearchController:(UISearchController *)searchController {
    self.tableView.dataSource = self.dataSource;
    [self.tableView reloadData];
}

#pragma mark - public method
- (void)showIn:(UIViewController *)controller {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [controller presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (!self.searchController.isActive) {
        [self cancelPendingSearch];
        self.searchText = @"";
        return;
    }
    
    NSString *text = self.searchController.searchBar.text;
    if ([self.searchText isEqualToString:text]) {
        return ;
    }
    
    [self cancelPendingSearch];
    
    if (text.length == 0) {
        [self performSearchForText:text];
    } else {
        [self performSearchForText:text afterDelay:self.searchDelay];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indexTitle = [self.presenter fetchIndexTitles][indexPath.section];
    NSArray *countryList = [self.presenter fetchCountryGroup][indexTitle];
    RCSCountryInfo *countryInfo = countryList[indexPath.row];
    !_selectedHandler ?: _selectedHandler(countryInfo);
    self.searchController.active = NO;
    [self back];
}

#pragma mark - private method
- (void)cancelPendingSearch {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)performSearchForText:(NSString *)text afterDelay:(NSTimeInterval )delay {
    [self performSelector:@selector(performSearchForText:) withObject:text afterDelay:delay];
}

- (void)performSearchForText:(NSString *)text {
    if (text.length == 0) {
        self.searchDataSource.searchResult = @[];
    } else {
        self.searchDataSource.searchResult = [self.presenter fetchCountryWithKeyWord:text];
    }
    self.tableView.dataSource = self.searchDataSource;
    [self.tableView reloadData];
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self.dataSource;
        _tableView.rowHeight = 44;
        _tableView.sectionHeaderHeight = 25;
        _tableView.tableHeaderView = self.searchController.searchBar;
        [_tableView registerClass:[RCSCountryCodeTableViewCell class] forCellReuseIdentifier:NSStringFromClass(RCSCountryCodeTableViewCell.class)];
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [UISearchController new];
        _searchController.obscuresBackgroundDuringPresentation = NO;
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.returnKeyType = UIReturnKeyDone;
        _searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchController.searchBar.enablesReturnKeyAutomatically = NO;
        _searchController.searchBar.tintColor = self.navigationController.navigationBar.tintColor;
    }
    return _searchController;
}

- (RCSPhoneCodeDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [RCSPhoneCodeDataSource new];
        _dataSource.indexTitles = [self.presenter fetchIndexTitles];
        _dataSource.countryGroup = [self.presenter fetchCountryGroup];
    }
    return _dataSource;
}

- (RCSPhoneCodeSearchDataSource *)searchDataSource {
    if (!_searchDataSource) {
        _searchDataSource = [RCSPhoneCodeSearchDataSource new];
        _searchDataSource.searchResult = @[];
    }
    return _searchDataSource;
}

- (RCSCountryCodePresenter *)presenter {
    if (!_presenter) {
        _presenter = [RCSCountryCodePresenter new];
    }
    return _presenter;
}

@end
