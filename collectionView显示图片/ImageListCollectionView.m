//
//  ImageListCollectionView.m
//  collectionView显示图片
//
//  Created by 罗金明 on 15/9/8.
//  Copyright (c) 2015年 ming. All rights reserved.
//

#import "ImageListCollectionView.h"
#import "ImageCell.h"
#import "AFNetworking.h"
#define baseUrl @"http://120.25.234.154:9000/"

@interface ImageListCollectionView (){
    NSDictionary*_dict;
}
@property(nonatomic,strong)NSString*imageUpdata;
@end

@implementation ImageListCollectionView

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    
    UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(305, 305);

    return [self initWithCollectionViewLayout:layout];
    
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
 
    int cols=(size.width==1024)?3:2;
    UICollectionViewFlowLayout*layout=(UICollectionViewFlowLayout*)self.collectionViewLayout;
    CGFloat inset=(size.width-cols*layout.itemSize.width)/(cols+1);
    layout.sectionInset=UIEdgeInsetsMake(inset, inset, inset, inset);
    //竖直方向上的间隔
    layout.minimumLineSpacing=inset;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor=[UIColor grayColor];
    
        [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil]forCellWithReuseIdentifier:reuseIdentifier];
    
    [self conectWith:@"http://120.25.234.154:9000/lyda/index.php/Api/about/"];
    
    [self.collectionView reloadData];
    
}
-(void)conectWith:(NSString*)urlStr{
    
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
                               } else {
                                   
                                    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//                                   NSLog(@"%@",result);
//
//                                   
                                   _dict=result;
                                   [self.collectionView reloadData];
//
//                                   NSLog(@"22222%@",_dict[@"oneimg"]);
                               }
                           }];
    
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //刷新数据时会来到这数据源方法，在这里计算一下item的间距,把宽度传给它。
    [self viewWillTransitionToSize:CGSizeMake(collectionView.frame.size.width, 0) withTransitionCoordinator:nil];
    
    
    
    return self.imageUpdata?0:5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.imgName=@"http://120.25.234.154:9000/43C1549E222DE8BCFD975AEF5F44443A/B6EEBB1986468FD57596C3AD98943F0B.jpg";
    
    NSString*fileName=[NSString stringWithFormat:@"%@%@",baseUrl,_dict[@"oneimg"]];
//    NSLog(@"%@",fileName);
    cell.imgName=fileName;

    
    return cell;
}
#pragma mark <UICollectionViewDelegate>


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/






@end
