//
//  MapViewController.m
//  turgenev
//
//  Created by Vladimir Psyukalov on 13.02.18.
//  Copyright © 2018 YOUROCK INC. All rights reserved.
//


#import "MapViewController.h"

#import "Macros.h"

#import "UIView+Custom.h"

#import "PlaceStandaloneView.h"

#import "MapView.h"
#import "TCollectionView.h"

#import "TileOverlay.h"
#import "Annotation.h"

#import "InfoCollectionViewCell.h"

#import "PlacesManager.h"


#define kCollectionViewSpacing (4.f)

#define kStartLatitude (0.f)
#define kStartLongitude (0.f)

#define kStartLatitudeDelta (1.f)
#define kStartLongitudeDelta (1.f)


@interface MapViewController () <MKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    BOOL isPlacesListButtonAction;
}

@property (weak, nonatomic) IBOutlet MapView *mapView;

@property (weak, nonatomic) IBOutlet TCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet PlaceStandaloneView *placeStandaloneView;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *placesListButton;

@property (strong, nonatomic) NSMutableArray<Place *> *places;

@end


@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    BOOL condition = [overlay isKindOfClass:[TileOverlay class]];
    return condition ? [[MKTileOverlayRenderer alloc] initWithTileOverlay:overlay] : [[MKOverlayRenderer alloc] initWithOverlay:overlay];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // TODO:
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // TODO:
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    // TODO:
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    // TODO:
}

#pragma mark -  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _places.count;
}

- (UICollectionViewCell *)collectionView:(CollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithIndex:0 forIndexPath:indexPath];
    Place *place;
    NSString *imageURL;
    @try {
        place = _places[indexPath.row];
    }
    @finally { }
    @try {
        imageURL = place.imageURLs.firstObject;
    }
    @finally { }
    cell.imageURL = imageURL;
    cell.name = place.name;
    cell.address = place.address;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _placesListButton.selected = YES;
    isPlacesListButtonAction = NO;
    [_placeStandaloneView setHidden:NO animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width / 2.2f;
    CGFloat height = collectionView.frame.size.height - 2.f * kCollectionViewSpacing;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSUInteger count = _places.count;
    CGFloat totalCellsWidth = count * (collectionView.frame.size.height - 2.f * kCollectionViewSpacing);
    CGFloat totalSpacingWidth = (count - 1) * kCollectionViewSpacing;
    CGFloat totalWidth = totalCellsWidth + totalSpacingWidth;
    if (totalWidth >= collectionView.frame.size.width) {
        return UIEdgeInsetsZero;
    }
    CGFloat value = (collectionView.frame.size.width - totalWidth) / 2.f;
    return UIEdgeInsetsMake(0.f, value, 0.f, value);
}

#pragma mark - Actions

- (IBAction)menuButton_TUI:(UIButton *)sender {
    
}

- (IBAction)placesListButton_TUI:(UIButton *)sender {
    if (sender.selected) {
        if (isPlacesListButtonAction) {
            [_collectionView setHidden:YES animated:YES completion:nil];
        } else {
            isPlacesListButtonAction = YES;
            [_placeStandaloneView setHidden:YES animated:YES completion:nil];
            return;
        }
    } else {
        [_collectionView setHidden:NO animated:YES completion:nil];
    }
    sender.selected = !sender.selected;
}

#pragma mark - Other methods

- (void)setup {
    _places = [NSMutableArray new];
    for (NSUInteger i = 0; i <= 9; i++) {
        [_places addObject:[Place new]];
    }
    isPlacesListButtonAction = YES;
    TileOverlay *tileOverlay = [[TileOverlay alloc] initWithURLTemplate:kGoogleMapStyleURLTemplate];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(kStartLatitude, kStartLongitude);
    MKCoordinateSpan span = MKCoordinateSpanMake(kStartLatitudeDelta, kStartLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView addOverlay:tileOverlay];
    [_mapView setRegion:region animated:YES];
    [_collectionView setHidden:YES animated:NO completion:nil];
    [_collectionView registerCellClass:[InfoCollectionViewCell class]];
}

@end
