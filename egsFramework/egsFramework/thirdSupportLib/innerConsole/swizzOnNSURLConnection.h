//
//  PDAFNetworkDomainController.h
//  PonyDebugger
//
//  Created by Mike Lewis on 2/27/12.
//
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.
//

//#import "PDDomainController.h"
//#import "PDNetworkTypes.h"
//#import "PDNetworkDomain.h"


//@protocol PDPrettyStringPrinting;

@interface swizzOnNSURLConnection : NSObject //<PDNetworkCommandDelegate>

//@property (nonatomic, strong) PDNetworkDomain *domain;

+ (swizzOnNSURLConnection *)defaultInstance;
+ (void)injectIntoAllNSURLConnectionDelegateClasses;
+ (void)injectIntoDelegateClass:(Class)cls;

//+ (void)registerPrettyStringPrinter:(id<PDPrettyStringPrinting>)prettyStringPrinter;
//+ (void)unregisterPrettyStringPrinter:(id<PDPrettyStringPrinting>)prettyStringPrinter;

@end


@interface swizzOnNSURLConnection (NSURLConnectionHelpers)

- (void)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end


 

@interface NSURLResponse (PDNetworkHelpers)

- (NSString *)PD_responseType;

@end
