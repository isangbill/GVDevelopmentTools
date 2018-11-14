//
//  GVTableViewAdapter.h
//  GVTableViewAdapterVersionTwo
//
//  Created by Sangbill on 2018/8/27.
//  Copyright © 2018年 Sangbill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GVTableViewSection.h"
#import <UIKit/UIKit.h>

@protocol GVTableViewAdapterDelegate <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView configuredCell:(UITableViewCell *)cell withRow:(GVTableViewRow *)row atIndexPath:(NSIndexPath *)indexPath;

@required
- (NSMutableArray<__kindof GVTableViewSection *> *)sectionsForTableView:(UITableView *)tableView;
//- (NSSet<NSString *> *)tableViewCellIdentifiterSetForTableView:(UITableView *)tableView;

@end

@interface GVTableViewAdapter : NSObject {
    NSSet<NSString *> *_cellIdentifierSet;
    NSMutableArray<__kindof GVTableViewSection *> *_sections;
    UITableView *_tableView;
}

@property (nonatomic, strong, readonly) NSMutableArray<__kindof GVTableViewSection *> *sections;
//@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id<GVTableViewAdapterDelegate> delegate;
@property (nonatomic, strong, readonly) NSSet<NSString *> *cellIdentifierSet;
@property (nonatomic, strong, readonly) UITableView *tableView;

- (instancetype)initWithViewTableView:(UITableView *)tableView;
- (void)reloadData;
@end
