//
//  ViewController.h
//  AVStoryboard
//
//  Created by Jose on 18/1/18.
//  Copyright © 2018 Jose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DataObject.h"

@interface ViewController : UIViewController
@property (nonatomic) NSUInteger pageIndex;
@property (strong, nonatomic) DataObject* dataObject;
@end

