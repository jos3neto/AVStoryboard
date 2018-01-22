//
//  InitialViewController.m
//  AVStoryboard
//
//  Created by Jose on 20/1/18.
//  Copyright © 2018 Jose. All rights reserved.
//

#import "InitialViewController.h"
#import "PageContainerController.h"
#import "ViewController.h"

@interface InitialViewController () <UIPageViewControllerDataSource>
@property (strong, nonatomic) PageContainerController* pageContainer;
@end

@implementation InitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Instantiate page container.
    self.pageContainer = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContainer"];
    self.pageContainer.dataSource = self;
    
    ViewController* viewControllerZero = [self viewControllerAtIndex:0];
    NSArray* viewControllersArray = @[viewControllerZero];

    [self.pageContainer setViewControllers:viewControllersArray direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageContainer.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageContainer];
    [_pageContainer didMoveToParentViewController:self];
    [self.view addSubview:_pageContainer.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index >= self.pageContainer.dataArray.count) || (index == NSNotFound))
    {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ViewController*) viewController).pageIndex;
    
    if ((index >= self.pageContainer.dataArray.count) || (index == NSNotFound))
    {
        return nil;
    }
    
    index++;
    
    return [self viewControllerAtIndex:index];
}

-(ViewController*) viewControllerAtIndex:(NSUInteger)index
{
    ViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContent"];
    viewController.pageIndex = index;
    viewController.dataObject = self.pageContainer.dataArray[index];
    
    return viewController;
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
