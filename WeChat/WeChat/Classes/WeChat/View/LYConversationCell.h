//
//  LYConversationCell.h
//  WeChat
//
//  Created by Y Liu on 16/2/23.
//  Copyright © 2016年 CoderYLiu. All rights reserved.
//

#import "LYCommonCell.h"

@class LYConversation;

@interface LYConversationCell : LYCommonCell

@property (nonatomic, strong) LYConversation *conversation;

@end