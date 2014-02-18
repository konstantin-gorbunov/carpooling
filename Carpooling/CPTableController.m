//
//  CPTableController.m
//  Carpooling
//
//  Created by Konstantin Gorbunov on 18/02/14.
//  Copyright (c) 2014 Konstantin Gorbunov. All rights reserved.
//

#import "CPTableController.h"

static const int defaultCountry = 1;

@implementation CPTableController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CPTableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

@end
