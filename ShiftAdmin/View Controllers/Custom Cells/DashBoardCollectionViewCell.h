//
//  DashBoardCollectionViewCell.h
//  ShiftAdmin
//
//  Created by Boyapati, Vinay on 2018/04/28.
//  Copyright © 2018 ANIL KUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashBoardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobsCountLbl;
@property (weak, nonatomic) IBOutlet UIImageView *jobTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *jobTypeLbl;
@property (weak, nonatomic) IBOutlet UIView  *backgroungColourView;
@property (weak, nonatomic) IBOutlet UIView  *moreInfoView;


@end
