//
//  CustomAnnotationView.m
//  MapKitClusteringObjC
//
//  Created by Robert Ryan on 2/1/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

#import "CustomAnnotationView.h"

static NSString *identifier = @"com.domain.clusteringIdentifier";

@implementation CustomAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])) {
        self.clusteringIdentifier = identifier;
        self.collisionMode = MKAnnotationViewCollisionModeCircle;
    }
    
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    
    self.clusteringIdentifier = identifier;
}

@end
