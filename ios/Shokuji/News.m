//
//  News.m
//  Shokuji
//
//  Created by Kevin Frans on 9/5/15.
//  Copyright © 2015 Kevin Frans. All rights reserved.
//

#import "News.h"
#import "DetailView.h"

@interface News ()

@end

@implementation News
{
    UIImage* image;
    UIImageView* imageView;
    UIView* popup;
    UIView* bg;
    float margin;
    ViewController* myParent;
    UIView* scroll;
    UILabel* loadLabel;
    UILabel* title;
    UIView* tbar;
}

#define dWidth self.view.frame.size.width
#define dHeight self.view.frame.size.height
#define margin 270

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

-(void) setImage:(UIImage*)theimg
{
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
    imageView.image = theimg;
    [self.view insertSubview:imageView atIndex:0];
}

-(void) setupJson:(NSDictionary*) json
{
    
    
    bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
    bg.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:bg];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, self.view.frame.size.width, 100)];
    title.font = [UIFont fontWithName:@"Roboto-Bold" size:40];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"kenko";
    [self.view addSubview:title];
    
    tbar = [[UIView alloc] initWithFrame:CGRectMake(100, -10+80, self.view.frame.size.width - 200, 2)];
    tbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tbar];
    
    
    
    scroll = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
//    scroll.contentSize = CGSizeMake(dWidth, dHeight);
    [self.view addSubview:scroll];
//    [scroll setShowsVerticalScrollIndicator:NO];
    
//    [scroll addGestureRecognizer:dr/agGestureRecognizer];
    //    [scroll sets]
    
    float sidem = 0;
    popup = [[UIView alloc] initWithFrame:CGRectMake(0, margin+dHeight, dWidth, dHeight-margin)];
    popup.backgroundColor = [UIColor colorWithRed:242/255.0 green:38/255.0 blue:9/255.0 alpha:0.50];
    [scroll addSubview:popup];
    
    //    UIView* leftbridge = [[UIView alloc] initWithFrame:CGRectMake(-100, 0, 100, dHeight)];
    //    [self.view addSubview:leftbridge];
    //    CAGradientLayer *gradient3 = [CAGradientLayer layer];
    //    gradient3.frame = leftbridge.bounds;
    //    gradient3.startPoint = CGPointMake(0.0, 0.5);
    //    gradient3.endPoint = CGPointMake(1.0, 0.5);
    //    gradient3.cornerRadius = 7;
    //    gradient3.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:0.0] CGColor], (id)[[[UIColor blackColor] colorWithAlphaComponent:0.8] CGColor], nil];
    //    [leftbridge.layer insertSublayer:gradient3 atIndex:0];
    
    
    float loadsize = 50;
//    loadingView = [[BALoadingView alloc] initWithFrame:CGRectMake((dWidth-sidem*2)/2 - loadsize/2, 20, loadsize, loadsize)];
//    [popup addSubview:loadingView];
//    loadingView.segmentColor = [UIColor whiteColor];
//    [loadingView initialize];
//    [loadingView startAnimation:BACircleAnimationFullCircle];
    
//    loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70, (dWidth-sidem*2), 30)];
//    loadLabel.text = @"Processing Image";
//    loadLabel.textColor = [UIColor whiteColor];
//    loadLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
//    loadLabel.textAlignment = NSTextAlignmentCenter;
//    [popup addSubview:loadLabel];
    
    [UIView animateWithDuration:0.01 animations:^{
        popup.frame = CGRectMake(0, margin, dWidth, dHeight-margin);
    }];
    
    
    
    
//    NSData *tdata = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    id json = [NSJSONSerialization JSONObjectWithData:tdata options:0 error:nil];
    
    NSString *str = @"data:image/jpeg;base64,";
    str = [str stringByAppendingString:json[@"imageB64"]];
    NSURL *url = [NSURL URLWithString:str];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *ret = [UIImage imageWithData:imageData];
    [self setImage:ret];
    
    if(json[@"result"][@"data"][@"fields"][@"nf_calories"] != NULL)
    {
    
    
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+5, dWidth - 105, 20)];
    title.text = json[@"result"][@"object_name"];
    //    title.text = @"adjasd asd asdas dasd sad sad as das das dsad";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Roboto-Bold" size:20];
    //    title.numberOfLines = 1;
    title.adjustsFontSizeToFitWidth = NO;
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    [scroll addSubview:title];
    //    [title sizeToFit];
    
    UILabel* calories = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+5, dWidth - 20, 20)];
    calories.text = [NSString stringWithFormat:@"%@ Cal",json[@"result"][@"data"][@"fields"][@"nf_calories"]];
    calories.textAlignment = NSTextAlignmentRight;
    calories.textColor = [UIColor whiteColor];
    calories.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:20];
    calories.numberOfLines = 1;
    [scroll addSubview:calories];
    //    [calories sizeToFit];
    
    UILabel* serving = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+25, dWidth - 20, 20)];
    serving.text = [NSString stringWithFormat:@"Serving Size: %@ %@ (%@)",json[@"result"][@"data"][@"fields"][@"nf_serving_size_qty"],json[@"result"][@"data"][@"fields"][@"nf_serving_size_unit"],json[@"result"][@"data"][@"fields"][@"nf_serving_weight_grams"]];
    serving.textAlignment = NSTextAlignmentLeft;
    serving.textColor = [UIColor whiteColor];
    serving.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    serving.numberOfLines = 1;
    [scroll addSubview:serving];
    
    UILabel* confidence = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+25, dWidth - 20, 20)];
    confidence.text = [NSString stringWithFormat:@"Confidence: %@",json[@"result"][@"confidence"]];
    confidence.textAlignment = NSTextAlignmentRight;
    confidence.textColor = [UIColor whiteColor];
    confidence.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    confidence.numberOfLines = 1;
    [scroll addSubview:confidence];
    
    UIView* bar = [[UIView alloc] initWithFrame:CGRectMake(0, margin+50, dWidth, 2)];
    bar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [scroll addSubview:bar];
    
    UILabel* fat = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+55, dWidth - 35, 20)];
    fat.text = [NSString stringWithFormat:@"Total Fat: %@",json[@"result"][@"data"][@"fields"][@"nf_total_fat"]];
    fat.textAlignment = NSTextAlignmentLeft;
    fat.textColor = [UIColor whiteColor];
    fat.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:fat];
    
    UILabel* sat = [[UILabel alloc] initWithFrame:CGRectMake(30,margin+75, dWidth - 35, 20)];
    sat.text = [NSString stringWithFormat:@"Saturated Fat: %@",json[@"result"][@"data"][@"fields"][@"nf_saturated_fat"]];
    sat.textAlignment = NSTextAlignmentLeft;
    sat.textColor = [UIColor whiteColor];
    sat.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:sat];
    
    UILabel* trans = [[UILabel alloc] initWithFrame:CGRectMake(30,margin+95, dWidth - 35, 20)];
    trans.text = [NSString stringWithFormat:@"Trans Fat: %@",json[@"result"][@"data"][@"fields"][@"nf_trans_fatty_acid"]];
    trans.textAlignment = NSTextAlignmentLeft;
    trans.textColor = [UIColor whiteColor];
    trans.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:trans];
    
    UILabel* cholestrol = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+115, dWidth - 35, 20)];
    cholestrol.text = [NSString stringWithFormat:@"Cholesterol: %@",json[@"result"][@"data"][@"fields"][@"nf_cholesterol"]];
    cholestrol.textAlignment = NSTextAlignmentLeft;
    cholestrol.textColor = [UIColor whiteColor];
    cholestrol.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:cholestrol];
    
    UILabel* sodium = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+135, dWidth - 35, 20)];
    sodium.text = [NSString stringWithFormat:@"Sodium: %@",json[@"result"][@"data"][@"fields"][@"nf_sodium"]];
    sodium.textAlignment = NSTextAlignmentLeft;
    sodium.textColor = [UIColor whiteColor];
    sodium.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:sodium];
    
    UILabel* carb = [[UILabel alloc] initWithFrame:CGRectMake(10 + dWidth/2,margin+55, dWidth - 35, 20)];
    carb.text = [NSString stringWithFormat:@"Total Carbs: %@",json[@"result"][@"data"][@"fields"][@"nf_total_carbohydrate"]];
    carb.textAlignment = NSTextAlignmentLeft;
    carb.textColor = [UIColor whiteColor];
    carb.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:carb];
    
    UILabel* diet = [[UILabel alloc] initWithFrame:CGRectMake(10 + dWidth/2,margin+75, dWidth - 35, 20)];
    diet.text = [NSString stringWithFormat:@"Dietary Fiber: %@",json[@"result"][@"data"][@"fields"][@"nf_dietary_fiber"]];
    diet.textAlignment = NSTextAlignmentLeft;
    diet.textColor = [UIColor whiteColor];
    diet.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:diet];
    
    UILabel* sugar = [[UILabel alloc] initWithFrame:CGRectMake(10 + dWidth/2,margin+95, dWidth - 35, 20)];
    sugar.text = [NSString stringWithFormat:@"Sugars: %@",json[@"result"][@"data"][@"fields"][@"nf_sugars"]];
    sugar.textAlignment = NSTextAlignmentLeft;
    sugar.textColor = [UIColor whiteColor];
    sugar.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:sugar];
    
    UILabel* protein = [[UILabel alloc] initWithFrame:CGRectMake(10 + dWidth/2,margin+115, dWidth - 35, 20)];
    protein.text = [NSString stringWithFormat:@"Protein: %@",json[@"result"][@"data"][@"fields"][@"nf_protein"]];
    protein.textAlignment = NSTextAlignmentLeft;
    protein.textColor = [UIColor whiteColor];
    protein.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:protein];
    
    UIButton* order = [[UIButton alloc] initWithFrame:CGRectMake(0, margin+194, dWidth, 50)];
    order.backgroundColor = [UIColor colorWithRed:41/255.0 green:128/255.0 blue:185/255.0 alpha:0.65];
    [scroll addSubview:order];
    [order addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* orderlabel = [[UILabel alloc] initWithFrame:order.frame];
    orderlabel.text = @"Order This For Me";
    orderlabel.textAlignment = NSTextAlignmentCenter;
    orderlabel.textColor = [UIColor whiteColor];
    orderlabel.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:18];
    [scroll addSubview:orderlabel];
    
    UIButton* health = [[UIButton alloc] initWithFrame:CGRectMake(0, margin+248, dWidth, 50)];
    health.backgroundColor = [UIColor colorWithRed:41/255.0 green:128/255.0 blue:185/255.0 alpha:0.65];
    [scroll addSubview:health];
    
    UILabel* healthLabel = [[UILabel alloc] initWithFrame:health.frame];
    healthLabel.text = @"Save to Health Kit";
    healthLabel.textAlignment = NSTextAlignmentCenter;
    healthLabel.textColor = [UIColor whiteColor];
    healthLabel.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:18];
    [scroll addSubview:healthLabel];
    
    UIView* support = [[UIView alloc] initWithFrame:CGRectMake(dWidth/2, margin+50, 2, 110)];
    support.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [scroll addSubview:support];
    
    UIView* bar2 = [[UIView alloc] initWithFrame:CGRectMake(0, margin+160, dWidth, 2)];
    bar2.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [scroll addSubview:bar2];
    
    UILabel* ing = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+165, dWidth - 35, 20)];
    ing.text = @"Ingredients:";
    ing.textAlignment = NSTextAlignmentLeft;
    ing.textColor = [UIColor whiteColor];
    ing.font = [UIFont fontWithName:@"Roboto-Bold" size:15];
    [scroll addSubview:ing];

    UILabel* allergies = [[UILabel alloc] initWithFrame:CGRectMake(100,margin+165, dWidth - 110, 20)];
    allergies.text = [NSString stringWithFormat:@"%@",json[@"result"][@"data"][@"fields"][@"nf_ingredient_statement"]];
    if([allergies.text isEqualToString:@"0"])
    {
        allergies.text = @"None";
    }
    allergies.textAlignment = NSTextAlignmentLeft;
    allergies.textColor = [UIColor whiteColor];
    allergies.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:15];
    [scroll addSubview:allergies];
    }
    else if(json[@"Scan_Error"] != NULL)
    {
        UILabel* sry = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+35, dWidth - 20, 70)];
        sry.text = @"Uh oh.";
        sry.textAlignment = NSTextAlignmentCenter;
        sry.textColor = [UIColor whiteColor];
        sry.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:60];
        [scroll addSubview:sry];
        
        UILabel* detail = [[UILabel alloc] initWithFrame:CGRectMake(60,margin+90, dWidth - 120, 100)];
        detail.text = json[@"Scan_Error"];
        detail.textAlignment = NSTextAlignmentCenter;
        detail.textColor = [UIColor whiteColor];
        detail.numberOfLines = 3;
        detail.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:20];
        [scroll addSubview:detail];
        
        float sidem = 100;
//        UIButton* retry = [[UIButton alloc] initWithFrame:CGRectMake(sidem, margin+200, dWidth - sidem*2, 40)];
//        retry.layer.cornerRadius = 20;
//        retry.backgroundColor = [UIColor whiteColor];
//        [scroll addSubview:retry];
        
//        UILabel* desc = [[UILabel alloc] initWithFrame:retry.frame];
//        desc.text = @"Try Again";
//        desc.textAlignment = NSTextAlignmentCenter;
//        desc.textColor = [UIColor colorWithRed:242/255.0 green:38/255.0 blue:9/255.0 alpha:0.50];
//        //        desc.numberOfLines = 3;
//        desc.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:20];
//        [scroll addSubview:desc];
//        [retry addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        UILabel* sry = [[UILabel alloc] initWithFrame:CGRectMake(10,margin+35, dWidth - 20, 70)];
        sry.text = @"Sorry.";
        sry.textAlignment = NSTextAlignmentCenter;
        sry.textColor = [UIColor whiteColor];
        sry.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:60];
        [scroll addSubview:sry];
        
        UILabel* detail = [[UILabel alloc] initWithFrame:CGRectMake(60,margin+90, dWidth - 120, 100)];
        detail.text = @"There was an error processing the image.";
        detail.textAlignment = NSTextAlignmentCenter;
        detail.textColor = [UIColor whiteColor];
        detail.numberOfLines = 3;
        detail.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:20];
        [scroll addSubview:detail];
        
        float sidem = 100;
        UIButton* retry = [[UIButton alloc] initWithFrame:CGRectMake(sidem, margin+200, dWidth - sidem*2, 40)];
        retry.layer.cornerRadius = 20;
        retry.backgroundColor = [UIColor whiteColor];
        [scroll addSubview:retry];
        
        UILabel* desc = [[UILabel alloc] initWithFrame:retry.frame];
        desc.text = @"Try Again";
        desc.textAlignment = NSTextAlignmentCenter;
        desc.textColor = [UIColor colorWithRed:242/255.0 green:38/255.0 blue:9/255.0 alpha:0.50];
        //        desc.numberOfLines = 3;
        desc.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:20];
        [scroll addSubview:desc];
        [retry addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


-(void) close
{
//    [self dismissViewControllerAnimated:YES completion:^{}];
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
