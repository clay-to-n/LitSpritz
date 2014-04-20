//
//  USCBookListViewController.m
//  LitSpritz
//
//  Created by Clayton on 4/12/14.
//  Copyright (c) 2014 Clayton Brand. All rights reserved.
//

#import "USCBookListViewController.h"
#import "USCBookViewController.h"
#import "AutoCoding.h"
#import "USCBooksLibrary.h"
#import "DownloadHelper.h"



@interface USCBookListViewController () <USCBookViewControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate, USCBooksLibraryDelegate>

@property (strong, nonatomic) USCBooksLibrary *library;
    
- (IBAction)addButtonPressed:(id)sender;

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
            
            USCBookModel *throughTheLookingGlass = [[USCBookModel alloc] initWithTitle:@"Through The Looking Glass" andAuthor: @"Lewis Carroll" andFileName:[[NSBundle mainBundle] pathForResource:@"LewisCarrollThroughTheLookingGlass" ofType:@"txt"]];
            [self.library insertBook:throughTheLookingGlass];
            
            USCBookModel *thePictureOfDorianGray = [[USCBookModel alloc] initWithTitle:@"The Picture Of Dorian Gray" andAuthor:@"Oscar Wilde" andFileName:[[NSBundle mainBundle] pathForResource:@"OscarWildeThePictureOfDorianGray" ofType:@"txt"]];
            [self.library insertBook:thePictureOfDorianGray];
            
            
            [self save];
        }
        [self.library setDelegate:self];

        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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
    cell.detailTextLabel.text = [[self.library bookAtIndex:indexPath.row] author];
    //cell.detailTextLabel.text = @"Weee";
    
    return cell;
}

- (IBAction)addButtonPressed:(id)sender {
    // Create the action sheet for adding books
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:self
                                     cancelButtonTitle:@"Cancel"
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"From URL", @"From Dropbox", @"From Google Drive", nil];
    [actionSheet showInView:self.view];

}

// This action sheet appears when the click the Add button
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {  // URL
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter a URL:" message:@".epub and .txt formats accepted" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];
        
    }
    else if (buttonIndex == 1) { // Dropbox
        
    }
    else if (buttonIndex == 2) { // Google Drive
        
    }
}
   
// This is the method called when they enter a URL
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        UITextField * alertTextField = [alertView textFieldAtIndex:0];
        NSString *extension = [[alertTextField.text lastPathComponent] pathExtension];
        if ([extension isEqualToString:@"txt"] || [extension isEqualToString:@"utf-8"] || [extension isEqualToString:@"epub"]) {
            [self.library addBookFromURLString:alertTextField.text];
        } else {
            // if they didn't supply a .txt or .epub file
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The URL must end in .txt or .epub" delegate:self cancelButtonTitle:@"Back" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    // do whatever you want to do with this UITextField.
}
    
    
// delegate method for uscbookslibrary
- (void) didUpdateLibrary {
    [self.tableView reloadData];
    
}
    
- (void) save {
    [self.library writeToFile:filePath atomically:TRUE];
}

    




// Override to support conditional editing of the table view.
    /*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}*/



// Override to support editing the table view.
   /*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}*/



// Override to support rearranging the table view.
    /*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}*/


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
            USCBookViewController *vc = segue.destinationViewController;
            vc.delegate = self;
            NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
           // UITableViewCell *cell = (UITableViewCell *)sender;
            int index = indexPath.row;
            [bookView setBook:[self.library bookAtIndex:index]];
            // Now send this index to my bookviewcontroller so it knows what's up
            
        }

    }
}

- (void) onPauseDelegation{
    [self save];
}

@end
