//
//  PageContainerController.h
//  AVStoryboard
//
//  Created by Jose on 20/1/18.
//  Copyright © 2018 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataObject.h"

@interface PageContainerController : UIPageViewController
@property (strong, nonatomic) NSArray<DataObject*>* dataArray;
@end
