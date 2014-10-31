//
//  ViewController.m
//  ImageFilterTest
//
//  Created by Muhammad Naviwala on 10/25/14.
//  Copyright (c) 2014 Muhammad Naviwala. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageToFilter;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property UIImage* originalImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(750, 76)];
    self.originalImage = self.imageToFilter.image;
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.center = CGPointMake(380, 880);
    self.spinner.hidesWhenStopped = YES;
    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    self.spinner.transform = transform;
    [self.view addSubview:self.spinner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)revertToOriginalImage:(id)sender {
    self.imageToFilter.image = self.originalImage;
}
- (IBAction)toggleFilterRow:(UIButton *)sender {
    NSLog(@"Button clicked");
    sender.layer.zPosition = 4;
    
    if (self.scrollView.frame.origin.x < -100) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.scrollView.frame = CGRectMake(0, 914, 700, 90);
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        sender.frame = CGRectMake(700, 914, 70, 90);
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.scrollView.frame = CGRectMake(-700, 914, 700, 90);
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        sender.frame = CGRectMake(0, 914, 70, 90);
        [UIView commitAnimations];
    }
}


- (IBAction)filterSepia:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageToFilter.image)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageToFilter.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
    
}

- (IBAction)filterMono:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageToFilter.image)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectMono" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageToFilter.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterVignette:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageToFilter.image)];
        CIContext *context = [CIContext contextWithOptions:nil];
   
        float imageHeight = self.imageToFilter.image.size.height;
        float imageWidth = self.imageToFilter.image.size.width;
        
        CIFilter *filter = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues: kCIInputImageKey, beginImage, kCIInputCenterKey, [CIVector vectorWithX:imageWidth/2 Y:imageHeight/2], nil];
        [filter setValue:[NSNumber numberWithFloat:imageWidth/2.1] forKey:kCIInputRadiusKey];
        
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageToFilter.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterChrome:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageToFilter.image)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectChrome" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageToFilter.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterInvert:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageToFilter.image)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageToFilter.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterPixellate:(id)sender {
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageToFilter.image)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIPixellate" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageToFilter.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
}

- (IBAction)filterDotScreen:(id)sender {
    
    [self.spinner startAnimating];
    dispatch_queue_t queue = dispatch_get_global_queue(0,0);
    
    dispatch_async(queue, ^{
        
        CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageToFilter.image)];
        CIContext *context = [CIContext contextWithOptions:nil];
        CIFilter *filter = [CIFilter filterWithName:@"CIDotScreen" keysAndValues: kCIInputImageKey, beginImage, nil];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageToFilter.image = [UIImage imageWithCGImage:cgimg];
            CGImageRelease(cgimg);
            [self.spinner stopAnimating];
        });
    });
    
}



@end
