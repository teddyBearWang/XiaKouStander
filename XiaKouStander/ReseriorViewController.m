//
//  ReseriorViewController.m
//  XiaKouStander
//  **********白水坑水库**********
//  Created by teddy on 15/10/12.
//  Copyright (c) 2015年 teddy. All rights reserved.
//

#import "ReseriorViewController.h"
#import "ItemCell.h"

@interface ReseriorViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_itemList;//数据源
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ReseriorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = BG_COLOR;
    _itemList = [NSMutableArray arrayWithObjects:@"库区巡查",@"柴油发电机",@"大坝巡查",@"防空洞", @"钢闸门",@"闸门", nil];
    
    //必须注册，否则会崩溃
    [self.collectionView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"itemCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionVIewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *myCell = (ItemCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    
    myCell.itemImageView.image = [UIImage imageNamed:@"rain.png"];
    myCell.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    myCell.itemNameLabel.text = _itemList[indexPath.row];
    
    return myCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //库区巡查
            [self performSegueWithIdentifier:@"baiWaterSource" sender:nil];
        }
            break;
        case 1:
        {
            //柴油发电机
            [self performSegueWithIdentifier:@"baiDisesel" sender:nil];
        }
        case 2:
        {
            //大坝
        }
            break;
        case 3:
        {
            //防空洞
        }
            break;
        case 4:
        {
            //钢闸门
            [self performSegueWithIdentifier:@"baiSteelGate" sender:nil];
        }
            break;
            case 5:
        {
            //闸门
            [self performSegueWithIdentifier:@"baiGate" sender:nil];
            
        }
            break;
        default:
            break;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"baiWaterSource"]) {
        //库区巡查
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"白水坑水库" forKey:@"reserviorId"];
    }
    else if ([segue.identifier isEqualToString:@"baiSteelGate"])
    {
        //钢闸门
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"白水坑水库" forKey:@"reserviorId"];
    }
    else if ([segue.identifier isEqualToString:@"baiGate"])
    {
        //闸门
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"白水坑水库" forKey:@"reserviorId"];
    }
}

@end
