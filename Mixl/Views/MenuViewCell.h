//
//  MenuViewCell.h
//  Spark
//
//  Copyright (c) 2015 Spark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewCell : UITableViewCell

+ (CGFloat)cellHeight;

@property(nonatomic, weak) IBOutlet UIImageView* actionIcon;
@property(nonatomic, weak) IBOutlet UILabel* actionTitle;

@end
