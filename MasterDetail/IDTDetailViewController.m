//
//  IDTDetailViewController.m
//  MasterDetail
//
//  Created by Josh Brown on 12/17/13.
//  Copyright (c) 2013 iOS Dev Training. All rights reserved.
//

#import "IDTDetailViewController.h"

@interface IDTDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *genreLabel;
@property (nonatomic, weak) IBOutlet UILabel *summaryLabel;

@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation IDTDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = [self.entry valueForKeyPath:@"im:name.label"];
    self.nameLabel.text = [self.entry valueForKeyPath:@"im:artist.label"];
    self.genreLabel.text = [self.entry valueForKeyPath:@"category.attributes.label"];
    self.summaryLabel.text = [self.entry valueForKeyPath:@"summary.label"];
    
    NSString *urlString = [[[self.entry valueForKeyPath:@"im:image"] lastObject] valueForKey:@"label"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!self.urlSession) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

        self.urlSession = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              __strong typeof(self) strongSelf = weakSelf;
                                              
                                              strongSelf.imageView.image = [UIImage imageWithData:data];
                                          });
                                      }];
    
    [dataTask resume];
}

- (void)dealloc {
    
    /*
     * NSURLSessions should be deallocated when they are no longer
     * used.
     * see: https://github.com/AFNetworking/AFNetworking/issues/1528
     */
    [self.urlSession invalidateAndCancel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
