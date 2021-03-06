//
//  FoursquareAPIManager.m
//  FixaDaApp
//
//  Created by Michael Kavouras on 2/15/16.
//  Copyright © 2016 Michael Kavouras. All rights reserved.
//

#import "FoursquareAPIManager.h"
#import <AFNetworking/AFNetworking.h>

#define kFoursquareAPIClientID     @"GWKJBVWFYBJQ02T3TRBB4VBL24AIO4TCMJCGIQ5ADKVKJXGP"
#define kFoursquareAPIClientSecret @"2WMEZCDQNKNB5XAE5F4BY1VHBK1HITYRU1JEVCOAD2QRLXDJ"


@implementation FoursquareAPIManager

/**
 
 https://api.foursquare.com/v2/venues/search
 ?client_id=CLIENT_ID
 &client_secret=CLIENT_SECRET
 &v=20130815
 &ll=40.7,-74
 &query=sushi
 
**/

+ (void)findSomething:(NSString *)query
           atLocation:(CLLocation *)location
           completion:(void(^)(NSArray *data))completion
{
    #define query @"restaurant"
    
    NSString *baseURL = @"https://api.foursquare.com/v2/venues/search";
    NSString *url = [NSString stringWithFormat:@"%@?client_id=%@&client_secret=%@&v=20160215&ll=%f,%f&query=%@", baseURL, kFoursquareAPIClientID, kFoursquareAPIClientSecret, location.coordinate.latitude, location.coordinate.longitude, query];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject)
    {
        
        NSDictionary *results = responseObject[@"response"];
        NSArray *data = results[@"venues"];
        NSLog(@"%@", results);
        completion(data);
        
//         for (NSDictionary *result in docs) {
//             
//             NSString *venueName = [result objectForKey:@"name"];
//              NSLog(@"%@", venueName);
//              NSDictionary *venueLocation = [result objectForKey:@"location"];
//             double latitude = [[venueLocation objectForKey:@"lat"] doubleValue];
//              NSLog(@"%f", latitude);
//             double longitude = [[venueLocation objectForKey:@"lng"] doubleValue];
//              NSLog(@"%f", longitude);
//             
//             CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
            ////*****the code below is not needed*****////
            // completion(location);
             //        [self.tableView reloadData];
             
             
            // NSLog(@"response object: %@", responseObject);
//         }
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];

}

@end
