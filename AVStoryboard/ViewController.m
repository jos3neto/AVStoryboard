//
//  ViewController.m
//  AVStoryboard
//
//  Created by Jose on 18/1/18.
//  Copyright © 2018 Jose. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
//why nav controller delegate?
@property (weak, nonatomic) IBOutlet UIImageView* imageView;
@property (strong, nonatomic) UIImagePickerController* picker;
@property (strong, nonatomic) AVAudioRecorder* recorder;
@property (strong, nonatomic) AVAudioPlayer* player;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.dataObject = [DataObject new];
    
    //Set up picker object
    self.picker = [UIImagePickerController new];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.picker.sourceType];
    
    NSLog(@"Created picker with source %ld and media Types %@", self.picker.sourceType, self.picker.mediaTypes);
    
    self.picker.delegate = self;
    
    //Set up audio URL
    NSURL* audioDir = [[[NSFileManager defaultManager]
                           URLsForDirectory:NSDocumentDirectory
                           inDomains:NSUserDomainMask]
                          firstObject];
    
    NSLog(@"URL for our recording %@", audioDir);
    
    self.dataObject.audioURL = [audioDir URLByAppendingPathComponent:@"recording.m4a"];
    
    //Set up audio recorder
    NSError* recErr = nil;
    self.recorder = [[AVAudioRecorder alloc]
                     initWithURL:self.dataObject.audioURL
                     settings:@{AVSampleRateKey: @(44100),
                                AVFormatIDKey: @(kAudioFormatMPEG4AAC),
                                AVNumberOfChannelsKey: @(2)}
                     error:&recErr];
    if (recErr)
    {
        NSLog(@"Error creating recorder %@", recErr.localizedDescription);
    }
    
    //Set up audio player
    NSError* playErr = nil;
    self.player = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:self.dataObject.audioURL
                   error:&playErr];
    if (playErr)
    {
        NSLog(@"Error creating player %@", playErr.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapImage:(UITapGestureRecognizer*)sender
{
    if (self.player.isPlaying)
    {
        // stop player
        [self.player stop];
    } else
    {
        // start player
        [self.player play];
    }

}

- (IBAction)recButton:(UIButton *)sender
{
    if (self.recorder.isRecording)
    {
        // stop recording
        [sender setTitle:@"Record" forState:UIControlStateNormal];
        [self.recorder stop];
    } else
    {
        // start recording
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [self.recorder record];
    }
}

- (IBAction)imageButton:(UIButton *)sender
{
    /*UIImagePickerController* picker = [UIImagePickerController new];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    
    NSLog(@"Created picker with source %ld and media Types %@", picker.sourceType, picker.mediaTypes);
    
    picker.delegate = self;*/
    
    [self presentViewController:self.picker animated:YES completion:
    ^{
        NSLog(@"Picker is now showing");
    }];

}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //NSLog(@"Got info: %@", info);
    self.dataObject.image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{ NSLog(@"Picker gone"); }];
}


@end
