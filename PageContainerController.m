//
//  PageContainerController.m
//  AVStoryboard
//
//  Created by Jose on 20/1/18.
//  Copyright © 2018 Jose. All rights reserved.
//

#import "PageContainerController.h"

@interface PageContainerController ()

@end

@implementation PageContainerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DataObject* dataObject0 = [DataObject new];
    DataObject* dataObject1 = [DataObject new];
    DataObject* dataObject2 = [DataObject new];
    DataObject* dataObject3 = [DataObject new];
    DataObject* dataObject4 = [DataObject new];
    
    self.dataArray = @[dataObject0, dataObject1, dataObject2, dataObject3, dataObject4];
}

- (void)didReceiveMemoryWarning
{
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
