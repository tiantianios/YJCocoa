//
//  YJUser+CoreDataProperties.m
//  YJCoreData
//
//  Created by admin on 2016/10/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUser+CoreDataProperties.h"

@implementation YJUser (CoreDataProperties)

+ (NSFetchRequest<YJUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"YJUser"];
}

@dynamic index;
@dynamic name;
@dynamic qq;

@end
