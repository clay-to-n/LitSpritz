//
//  USCBookListViewController.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Spritz. All rights reserved.
//

#import "USCBookListViewController.h"
#import "USCBookViewController.h"
#import "AutoCoding.h"
#import "USCBooksLibrary.h"

@interface USCBookListViewController ()

@property (strong, nonatomic) USCBooksLibrary *library;

@end

@implementation USCBookListViewController {

// append the filename to the documents path
    NSString *filePath;

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        filePath = [documentsPath stringByAppendingPathComponent:@"LitSpritzLibrary"];
        
        self.library = [USCBooksLibrary objectWithContentsOfFile:filePath];
        if (!self.library) {
            self.library = [[USCBooksLibrary alloc] init];
            
            USCBookModel *throughTheLookingGlass = [[USCBookModel alloc] initWithTitle:@"Through The Looking Glass" andFileName:[[NSBundle mainBundle] pathForResource:@"LewisCarrollThroughTheLookingGlass" ofType:@"txt"]];
            [self.library insertBook:throughTheLookingGlass atIndex:0];
            
            USCBookModel *thePictureOfDorianGray = [[USCBookModel alloc] initWithTitle:@"The Picture Of Dorian Gray" andFileName:[[NSBundle mainBundle] pathForResource:@"OscarWildeThePictureOfDorianGray" ofType:@"txt"]];
            
            [self.library insertBook:thePictureOfDorianGray atIndex:1];
            
            [self save];
        }
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.library numberOfBooks];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.library bookAtIndex:indexPath.row] title];
    
    return cell;
}

- (void) save {
    [self.library writeToFile:filePath atomically:TRUE];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"bookDetail" sender:[self.library bookAtIndex:[indexPath row]]];
}*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using
    
    USCBookViewController *bookView = [segue destinationViewController];
    if ([[segue identifier] isEqualToString: @"bookDetail"]) {
        if ([[segue destinationViewController] isKindOfClass: [USCBookViewController class]]) {
            NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
           // UITableViewCell *cell = (UITableViewCell *)sender;
            int index = indexPath.row;
            [bookView setBook:[self.library bookAtIndex:index]];
            // Now send this index to my bookviewcontroller so it knows what's up
            
        }

    }
}


@end
