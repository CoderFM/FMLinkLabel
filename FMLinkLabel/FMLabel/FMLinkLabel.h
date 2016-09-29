//
//  FMLinkLabel.h
//  算高度
//
//  Created by 周发明 on 16/9/23.
//  Copyright © 2016年 途购. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FMLinkLabelClickItemBlock)(id transmitBody);

@class FMLinkLabelClickItem;

@interface FMLinkLabel : UILabel

- (void)addClickText:(NSString *)text attributeds:(NSDictionary *)attributeds transmitBody:(id)transmitBody clickItemBlock:(FMLinkLabelClickItemBlock)clickBlock;

- (void)addClickTextAttachmentName:(NSString *)attachmentName TransmitBody:(id)transmitBody clickItemBlock:(FMLinkLabelClickItemBlock)clickBlock;

@end

@interface FMLinkLabelClickItem :NSObject

@property(nonatomic, copy)NSString *text;

@property(nonatomic, assign)NSRange range;

@property(nonatomic, assign)CGRect textRect;

@property(nonatomic, strong)NSMutableArray *textRects;

@property(nonatomic, strong)id transmitBody;

@property(nonatomic, copy)FMLinkLabelClickItemBlock clickBlock;

+ (instancetype)itemWithText:(NSString *)string range:(NSRange)range transmitBody:(id)transmitBody;

+ (instancetype)itemWithTransmitBody:(id)transmitBody;

@end

@interface FMTextAttachment : NSTextAttachment

@property(nonatomic, copy)NSString *attachmentName;

@end