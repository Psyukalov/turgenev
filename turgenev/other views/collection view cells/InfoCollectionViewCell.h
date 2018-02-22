//
//  InfoCollectionViewCell.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "ImageCollectionViewCell.h"


@interface InfoCollectionViewCell : ImageCollectionViewCell

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;

@end
