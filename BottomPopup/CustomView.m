//
//  CustomView.m
//  BottomPopup
//
//  Created by 08liter on 2020/04/08.
//  Copyright © 2020 08liter. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()
@property (nonatomic, retain) WKWebView* webView;
@end

@implementation CustomView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self loadXib];
    [self initWebView];
    [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self loadNaver];
    }];
    return self;
}

- (void)loadXib{
    UIView* view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    [view setFrame:self.bounds];
    
    [self addSubview:view];
}

- (void)initWebView{
    WKWebViewConfiguration* config = [WKWebViewConfiguration new];
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    [_webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_webView setBackgroundColor:[UIColor lightGrayColor]];
    
    [_contentView addSubview:_webView];
    [_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_webView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f]];
    [_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_webView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f]];
    [_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_webView attribute:NSLayoutAttributeTrailing multiplier:1.f constant:0.f]];
    [_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_webView attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f]];
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
//    NSURLResponse* response = (NSURLResponse*)navigationResponse.response;
    NSHTTPURLResponse* response = (NSHTTPURLResponse*)navigationResponse.response;
    NSLog(@"response: %@", response.description);
    
    if([navigationResponse.response.URL.absoluteString containsString:@"https://nid.naver.com/signin/v3/finalize"]){
        [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self loadStatistics];
            NSLog(@"headerField : %@", response.allHeaderFields.description);
        }];
    }
    
    if([navigationResponse.response.URL.absoluteString containsString:@"https://blog.stat.naver.com/api/blog/visit/averageVisit"]){
        
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.documentElement.outerHTML.toString()" completionHandler:^(id _Nullable html, NSError * _Nullable error) {
        NSString* jsonString = [self stringByStrippingHTML:html];
        NSLog(@"evaluate : %@", jsonString);
        NSError* parseError = nil;
        NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&parseError];
        if(!parseError){
            NSDictionary* statDataList = [jsonDict objectForKey:@"result"];
            NSLog(@"PARSE : %@", statDataList);
        }
    }];
}

-(NSString *)stringByStrippingHTML:(NSString*)str
{
  NSRange r;
  while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location     != NSNotFound)
 {
    str = [str stringByReplacingCharactersInRange:r withString:@""];
}
 return str;
}

- (void)loadStatistics{
//    WKHTTPCookieStore* store = [[WKWebsiteDataStore defaultDataStore] httpCookieStore];
//    [store getAllCookies:^(NSArray<NSHTTPCookie *> * _Nonnull cookies) {
//        for(NSHTTPCookie* cookie in cookies){
//            NSLog(@"Domain : %@ - Cookie : %@",cookie.domain, cookie.value);
//        }
//    }];
//    NSString* today = [NSDate date]
//    NSString* url = [NSString stringWithFormat:@"https://blog.stat.naver.com/api/blog/visit/averageVisit?timeDimension=WEEK&startDate=%@&exclude=&_=%@",];
    NSString* url = @"https://blog.stat.naver.com/api/blog/visit/averageVisit?timeDimension=WEEK&startDate=2020-04-27&exclude=&_=1588831488353_62094";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)loadNaver{
    NSString* url = @"https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com";
    [_webView setNavigationDelegate:self];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)loadHtml{
    NSString* url = @"https://api.instagram.com/oembed?url=https://www.instagram.com/p/B-57zCEHdw-/";
//    NSString* url = @"https://api.instagram.com/oembed?url=https://www.instagram.com/p/fA9uwTtkSN/";
    NSURLSession* defaultSession = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [defaultSession dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            
        }else{
            NSLog(@"response : %@", response.description);
            NSError* parseError = nil;
            NSDictionary* jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
            if(parseError){
                
            }else{
                NSLog(@"jsonDic : %@", jsonDic.description);
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString* htmlString = [jsonDic objectForKey:@"html"];
                    //NSString* metaString = @"<meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=YES\">";
                    NSString* replaceString = [NSString stringWithFormat:@"max-width:%ldpx;",[[jsonDic objectForKey:@"width"] longValue]];
                    htmlString = [htmlString stringByReplacingOccurrencesOfString:replaceString withString:@""];
                    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:url]];
                    
                });
            }
        }
    }];
    [task resume];
}

@end
