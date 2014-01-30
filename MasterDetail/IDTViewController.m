//
//  IDTViewController.m
//  MasterDetail
//
//  Created by Josh Brown on 12/17/13.
//  Copyright (c) 2013 iOS Dev Training. All rights reserved.
//

#import "IDTViewController.h"
#import "IDTDetailViewController.h"

#define kMoviesSegment 0
#define kBooksSegment 1

#define kMoviesURL  @"https://itunes.apple.com/us/rss/topmovies/limit=15/json"
#define kBooksURL @"https://itunes.apple.com/us/rss/toppaidebooks/limit=15/json"

@interface IDTViewController ()

@property NSArray *entries;

@end

@implementation IDTViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.entries = @[];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadFromURL:kMoviesURL];
}

- (void)loadFromURL:(NSString *)urlString;
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask =
    [session dataTaskWithURL:url
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         NSError *jsonError = nil;
         id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
         
         NSDictionary *feed = [json objectForKey:@"feed"];
         self.entries = [feed objectForKey:@"entry"];
         
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }];
    
    [dataTask resume];
}

- (IBAction)didChangeSegment:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;

    if (control.selectedSegmentIndex == kMoviesSegment)
    {
        [self loadFromURL:kMoviesURL];
    }
    else if (control.selectedSegmentIndex == kBooksSegment)
    {
        [self loadFromURL:kBooksURL];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    NSDictionary *entry = [self.entries objectAtIndex:indexPath.row];
    cell.textLabel.text = [entry valueForKeyPath:@"im:name.label"];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    IDTDetailViewController *vc = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    vc.entry = [self.entries objectAtIndex:indexPath.row];
}

@end
