//
//  UITableViewCellConfiguration.h
//  GVWalletMain
//
//  Created by Sangbill on 2018/9/27.
//  Copyright © 2018 Sangbill. All rights reserved.
//

#ifndef UITableViewCellConfiguration_h
#define UITableViewCellConfiguration_h

@class GVTableViewRow;

@protocol UITableViewCellConfigration <NSObject>
- (void)setupRowModel:(__kindof GVTableViewRow *)row;
@end

#endif /* UITableViewCellConfiguration_h */
