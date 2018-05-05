
//
//  DashBoardViewController.m
//  ShiftAdmin
//
//  Created by kishore kumar on 27/04/18.
//  Copyright © 2018 ANIL KUMAR. All rights reserved.
//

#import "DashBoardViewController.h"
#import "DashBoardCollectionViewCell.h"
@interface DashBoardViewController ()

{
    NSMutableDictionary *employeeDict;
    NSArray *employeeCategeries;
    NSArray *imagesArray;
    NSArray *employeeCount;
    NSMutableDictionary *employeeValues;
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *dashBoardCollectionView;

@end
@implementation DashBoardViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dashBoardCollectionView registerNib:[UINib nibWithNibName:@"DashBoardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DashBoardCollectionViewCellID"];
    
    
    employeeDict = [[NSMutableDictionary alloc]init];
    employeeValues = [[NSMutableDictionary alloc]init];
    employeeCategeries = @[@"Employers",@"Jobseeker",@"Applied",@"Matched ",@"Jobs",@"Shortlisted"];
    imagesArray = @[@"Employees",@"Employees",@"Appiled",@"Matched",@"jobs",@"ShoertList"];
    [self getaData];
    
    
    
}
-(void)getaData
{
    NSURL *url = [NSURL URLWithString:@"http://54.169.86.42/shift/shiftAPI/public/api/v1/dashboard"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error) {
                                          NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                          NSLog(@"%@",strData);
                                          NSError*errorrs;
                                          
                                          employeeDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorrs];
                                          NSLog(@"%@",employeeDict);
                                          
                                          employeeValues = [employeeDict objectForKey:@"count"];
                                          employeeCount = [employeeValues  allValues];
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.dashBoardCollectionView reloadData];
                                          });
                                          
                                      }];
    [dataTask resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark collectionView Delegate Methods;

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return employeeCategeries.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DashBoardCollectionViewCell *cell = [self.dashBoardCollectionView dequeueReusableCellWithReuseIdentifier:@"DashBoardCollectionViewCellID" forIndexPath:indexPath];
    cell.jobTypeLbl.text = [employeeCategeries objectAtIndex:indexPath.row];
    cell.jobTypeImageView.image = [UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]];
    UIImage *image = [UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]];
    cell.jobTypeImageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    cell.jobsCountLbl.text = [NSString stringWithFormat:@"%@",[employeeCount objectAtIndex:indexPath.row]];
    
    cell.jobTypeImageView.tintColor= [UIColor colorWithRed:0.0f/255.0f
                                                     green:0.0f/255.0f
                                                      blue:0.0f/255.0f
                                                     alpha:0.15f];
    cell.moreInfoView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f
                                                        green:0.0f/255.0f
                                                         blue:0.0f/255.0f
                                                        alpha:0.1f];
    
    
    if (indexPath.row == 0) {
        cell.backgroungColourView.backgroundColor = [UIColor colorWithRed:72.0f/255.0f
                                                                    green:176.0f/255.0f
                                                                     blue:247.0f/255.0f
                                                                    alpha:1.0f];
        cell.jobsCountLbl.text = [NSString stringWithFormat:@"%@",[employeeValues objectForKey:@"employers" ]];
    }else if
        (indexPath.row == 1)
    {
        cell.backgroungColourView.backgroundColor = [UIColor colorWithRed:16.0f/255.0f
                                                                    green:207.0f/255.0f
                                                                     blue:189.0f/255.0f alpha:1.0f];
        cell.jobsCountLbl.text = [NSString stringWithFormat:@"%@",[employeeValues objectForKey:@"job_seekers"]];
        
        
    }else if (indexPath.row == 2)
    {
        cell.backgroungColourView.backgroundColor = [UIColor colorWithRed:243.0f/255.0f
                                                                    green:156.0f/255.0f
                                                                     blue:18.0f/255.0f
                                                                    alpha:1.0f];
        cell.jobsCountLbl.text = [NSString stringWithFormat:@"%@",[employeeValues objectForKey:@"applied"]];
        
        
    }else if (indexPath.row == 3)
    {
        cell.backgroungColourView.backgroundColor = [UIColor colorWithRed:96.0f/255.0f
                                                                    green:92.0f/255.0f
                                                                     blue:168.0f/255.0f
                                                                    alpha:1.0f];
        cell.jobsCountLbl.text = [NSString stringWithFormat:@"%@",[employeeValues objectForKey:@"matches" ]];
        
    }else if (indexPath.row == 4)
    {
        cell.backgroungColourView.backgroundColor = [UIColor colorWithRed:1.0f/255.0f
                                                                    green:255.0f/255.0f
                                                                     blue:112.0f/255.0f
                                                                    alpha:1.0f];
        cell.jobsCountLbl.text = [NSString stringWithFormat:@"%@",[employeeValues objectForKey:@"jobs"]];
        
    } else
    {
        cell.backgroungColourView.backgroundColor = [UIColor colorWithRed:245.0f/255.0f
                                                                    green:87.0f/255.0f
                                                                     blue:83.0f/255.0f
                                                                    alpha:1.0f];
        cell.jobsCountLbl.text = [NSString stringWithFormat:@"%@",[employeeValues objectForKey:@"shortlist"]];
        
    }
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfCellInRow = 2;
    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width/numberOfCellInRow;
    return CGSizeMake(cellWidth-10, cellWidth+25);
    
}
@end

