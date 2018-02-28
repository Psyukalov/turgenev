//
//  PlaceStandaloneView.h
//  turgenev
//
//  Created by Vladimir Psyukalov on 19.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "StandaloneView.h"

#import "PlacesManager.h"


typedef NS_ENUM(NSUInteger, PlaceStandaloneViewAction) {
    PlaceStandaloneViewActionRoute = 0,
    PlaceStandaloneViewActionComment
};


@class PlaceStandaloneView;


@protocol PlaceStandaloneViewDelegate <NSObject>

@optional

- (void)placeStandaloneView:(PlaceStandaloneView *)placeStandaloneView didSelectAction:(PlaceStandaloneViewAction)action;

@end


@interface PlaceStandaloneView : StandaloneView <StandaloneViewProtocol>

@property (weak, nonatomic) id<PlaceStandaloneViewDelegate> delegate;

@property (strong, nonatomic) Place *place;

@end
