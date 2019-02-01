//
//  ViewController.m
//  MapKitClusteringObjC
//
//  Created by Robert Ryan on 2/1/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
@import CoreLocation;

#import "CustomAnnotationView.h"
#import "ClusterAnnotationView.h"

@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *manager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocationServices];
    [self configureMapView];
}

- (void)configureMapView {
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    [self.mapView registerClass:[CustomAnnotationView class] forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier];
    [self.mapView registerClass:[ClusterAnnotationView class] forAnnotationViewWithReuseIdentifier:MKMapViewDefaultClusterAnnotationViewReuseIdentifier];
}

- (void)startLocationServices {
    self.manager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.manager requestWhenInUseAuthorization];
    }
}

- (IBAction)didTapSearchButton:(id)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"restaurant";
    request.region = self.mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        
        for (MKMapItem *mapItem in response.mapItems) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.coordinate = mapItem.placemark.coordinate;
            annotation.title = mapItem.name;
            annotation.subtitle = mapItem.placemark.thoroughfare;
            [self.mapView addAnnotation:annotation];
        }
    }];
}

@end

