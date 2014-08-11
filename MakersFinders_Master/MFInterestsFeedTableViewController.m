//
//  MFInterestsFeedTableViewController.m
//  
//
//  Created by Daniel Sun on 8/11/14.
//
//

#import "MFInterestsFeedTableViewController.h"
#import "MFDataStore.h"
#import "MFAPIClient.h"
#import "FISCustomPugCell.h"
#import "MFUser.H"

@interface MFInterestsFeedTableViewController ()

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) MFDataStore *store;
@property (nonatomic) NSInteger counter;
@end

@implementation MFInterestsFeedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    static NSString *CellIdentifier = @"pugCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"FISCustomPugCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
    
    self.store = [MFDataStore sharedStore];
    self.items = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 50; i ++)
    {
        MFItem *blankItem = [self.store createItem];
        [self.items addObject:blankItem];
    }
    
    self.counter = 0;
    
    [MFAPIClient getInterestFeedItemForIdNumber:self.currentInterest.uniqueID WithCompletion:^(NSArray *items) {
        for (NSDictionary *eachItem in items)
        {
            MFItem *item = [self.store createItem];
            item.name = eachItem[@"name"];
            item.uniqueID = eachItem[@"id"];
            item.loves = eachItem[@"loves"];
            item.itemType = eachItem[@"make_or_find"];
            item.imageURL = eachItem[@"images"][@"retina"]; //NOTE THIS IS INCONSISTENT WITH OTHER IMAGEURLS
            MFUser *itemUser = [self.store createUser];
            itemUser.name = eachItem[@"user"][@"name"];
            itemUser.uniqueID = eachItem[@"user"][@"id"];
            itemUser.profileImageURL = eachItem[@"images"][@"thumb_retina"]; //NOTE THIS IS INCONSISTENT WITH OTHER IMAGEURLS
            item.user = itemUser;
            
            [self.items replaceObjectAtIndex:self.counter withObject:item];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.counter inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            self.counter++;
        }
    }];
    
    
    
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
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISCustomPugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pugCell" forIndexPath:indexPath];
    
    MFItem *item = self.items[indexPath.row];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.imageURL]]];
    cell.pugCellImageView.image = image;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
