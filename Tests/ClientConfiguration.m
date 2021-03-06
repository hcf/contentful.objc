//
//  ClientConfiguration.m
//  ContentfulSDK
//
//  Created by Boris Bügling on 01/10/14.
//
//

#import "ContentfulBaseTestCase.h"

@interface ClientConfiguration : ContentfulBaseTestCase

@end

#pragma mark -

@implementation ClientConfiguration

-(void)testClientCanBeInstantiatedWithoutSpaceKey {
    CDAClient* client1 = [[CDAClient alloc] initWithSpaceKey:nil accessToken:@"yolo"];
    CDAClient* client2 = [[CDAClient alloc] initWithSpaceKey:nil
                                                 accessToken:@"yolo"
                                               configuration:[CDAConfiguration defaultConfiguration]];

    XCTAssertNotNil(client1);
    XCTAssertNotNil(client2);
}

-(void)testDefaultUserAgent {
    CDARequest* request = [self.client fetchEntriesWithSuccess:^(CDAResponse *response,
                                                                 CDAArray *array) { }
                                                       failure:nil];
    NSString* userAgent = request.request.allHTTPHeaderFields[@"User-Agent"];

    XCTAssertTrue([userAgent hasPrefix:@"contentful.objc"], @"");
}

-(void)testCustomUserAgent {
    CDAConfiguration* configuration = [CDAConfiguration defaultConfiguration];
    configuration.userAgent = @"CustomUserAgent/foo";
    self.client = [[CDAClient alloc] initWithSpaceKey:@"test"
                                          accessToken:@"test"
                                        configuration:configuration];

    CDARequest* request = [self.client fetchEntriesWithSuccess:^(CDAResponse *response,
                                                                 CDAArray *array) { }
                                                       failure:nil];
    NSString* userAgent = request.request.allHTTPHeaderFields[@"User-Agent"];

    XCTAssertTrue([userAgent hasPrefix:@"CustomUserAgent/foo"], @"");
}

@end
