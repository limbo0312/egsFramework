//
//  egsFilter_KillNull.m
//  footballData
//
//  Created by EGS on 14-5-26.
//  Copyright (c) 2014年 www.kantai.co. All rights reserved.
//

#import "egsFilter_KillNull.h"

@implementation egsFilter_KillNull

#pragma mark - Public method

// 空对象及空字符串过滤通用方法，现在支持过滤的类型：NSDictionary，NSArray，NSString
+ (id)emptyObjectFilter:(id)object;
{
    id objectFiltered = nil;
    
    do {
        if ([object isKindOfClass:[NSNull class]])
        {
            break;
        }
        
        if ([object isKindOfClass:[NSString class]])
        {
            if (((NSString *)object).length > 0)
            {
                objectFiltered = object;
            }
            break;
        }
        
        if ([object isKindOfClass:[NSArray class]])
        {
            objectFiltered = [egsFilter_KillNull arrayFilter:object];
            break;
        }
        
        if ([object isKindOfClass:[NSDictionary class]])
        {
            objectFiltered = [egsFilter_KillNull dictionaryFilter:object];
            break;
        }
        
        if (object)
        {
            objectFiltered = object;
            break;
        }
    } while (NO);
    
    return objectFiltered;
}

// When set an object to NSMutalbeDictionary, filter the object to make sure the filtered object not null or empty NSString
// 往NSMutableDictionary里加入一个对象时，对此对象进行过滤，不为空时才添加到字典中
+ (void)setObject:(id)anObject forKey:(NSString *)aKey toDictionary:(NSMutableDictionary **)dict
{
    if (anObject && aKey.length > 0)
    {
        id objectFiltered = [egsFilter_KillNull emptyObjectFilter:anObject];
        if (objectFiltered)
        {
            [(NSMutableDictionary *)*dict setObject:objectFiltered forKey:aKey];
        }
    }
}

// When add an object to NSMutalbeArray, filter the object to make sure the filtered object not null or empty NSString
// 往NSArray里加入一个对象时，对此对象进行过滤，不为空时才添加到数组中
+ (void)addObject:(id)anObject toArray:(NSMutableArray **)array
{
    if (anObject)
    {
        id objectFiltered = [egsFilter_KillNull emptyObjectFilter:anObject];
        if (objectFiltered)
        {
            [(NSMutableArray *)*array addObject:objectFiltered];
        }
    }
}


#pragma mark - Private method
// Filter method for NSDictionary
// 字典的递归过滤方法，用于将字典内为nil或者空串的键值对去掉
+ (NSDictionary *)dictionaryFilter:(NSDictionary *)dict
{
    NSMutableDictionary *dictFiltered = nil;
    
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        dictFiltered = [NSMutableDictionary new];
        for (NSString *key in [dict allKeys])
        {
            id object = [dict objectForKey:key];
            if (object)
            {
                id objectFiltered = [egsFilter_KillNull emptyObjectFilter:object];
                if (objectFiltered)
                {
                    [dictFiltered setValue:objectFiltered forKey:key];
                }
            }
        }
        
        if (0 == dictFiltered.count)
        {
            dictFiltered = nil;
        }
    }
    
    return dictFiltered;
}

// Filter method for NSArray
// 数组的递归过滤方法，用于将数组内为nil或者空串的值去掉
+ (NSArray *)arrayFilter:(NSArray *)array
{
    NSMutableArray *arrayFiltered = nil;
    
    if ([array isKindOfClass:[NSArray class]] && array.count > 0)
    {
        arrayFiltered = [NSMutableArray new];
        for (id object in array)
        {
            if (object)
            {
                id objectFiltered = [egsFilter_KillNull emptyObjectFilter:object];
                if (objectFiltered)
                {
                    [arrayFiltered addObject:objectFiltered];
                }
            }
        }
        
        if (0 == arrayFiltered.count)
        {
            arrayFiltered = nil;
        }
    }
    
    return arrayFiltered;
}

@end
