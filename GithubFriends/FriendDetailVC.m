//
//  FriendDetailVC.m
//  GithubFriends
//
//  Created by Richard Tyran on 1/8/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

#import "FriendDetailVC.h"

//  Add property to this class .h called "friendInfo"

//  Grab the request code from NewFriendVC.m

//  Change the url to https ://api.github.com/users/USERNAME/repos

//  make USERNAME dynamic based on friendInfo[@"login"]

//  the return will be an NSAArray of repos

//  log the repos array

//  Extra: make selecting a cell push to FriendDetailVC

@interface FriendDetailVC () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation FriendDetailVC

{
    NSArray * repos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        
    [self save];
   
        
       
}

-(void)save {
    
    // This is creating a string called gitHubusername that accessess friendInfo dictionary for username to insert into URL below
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * githubUsername = self.friendInfo[@"login"];
    
    // This inserts the gitHubusername into the URL string
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", githubUsername];
    
    // This transforms the URL string into a URL
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    // Requests userdata with the URL
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    // Just a necessary step (it takes the data after the request is made)
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //  transforms the data into a JSON array
    
    NSArray * repos = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    // prints the JSON repos file
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 320, 368)];
    
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    NSLog(@"%@", repos);

}

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
        return repos.count;
    }
        

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowIndexPath:(NSIndexPath *)
indexPath{
    
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    
    
    cell.textLabel.text = repos[indexPath.row][@"name"];
    
    cell.detailTextLabel.text = repos[indexPath.row][@"description"];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
