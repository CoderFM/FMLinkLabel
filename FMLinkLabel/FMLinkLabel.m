//
//  FMLinkLabel.m
//  算高度
//
//  Created by 周发明 on 16/9/23.
//  Copyright © 2016年 途购. All rights reserved.
//

#import "FMLinkLabel.h"

@interface FMLinkLabel ()<UITextViewDelegate>

@property(nonatomic, strong)NSMutableArray *clickItems;

@property(nonatomic, strong)NSMutableDictionary *clickAttachmentItems;

@property(nonatomic, weak)UITextView *textView;

@end

@implementation FMLinkLabel

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib{
    [self setUp];
}

- (void)setUp{
    self.clickItems = [NSMutableArray array];
    self.clickAttachmentItems = [NSMutableDictionary dictionary];
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    self.textView.font = self.font;
}

- (void)addClickItem:(FMLinkLabelClickItem *)item{
    
    self.textView.selectedRange = item.range;
    
    CGRect rect = [self.textView firstRectForRange:self.textView.selectedTextRange];
    
    self.textView.selectedRange = NSMakeRange(0, 0);
    
    CGRect textRect = [self.textView convertRect:rect toView:self];
    
    item.textRect = textRect;
    
    [self.clickItems addObject:item];
}

- (void)addClickText:(NSString *)text attributeds:(NSDictionary *)attributeds transmitBody:(id)transmitBody clickItemBlock:(FMLinkLabelClickItemBlock)clickBlock{
    
    NSMutableAttributedString *attr = nil;
    if (self.attributedText) {
        attr = [self.attributedText mutableCopy];
    } else {
        attr = [[[NSAttributedString alloc] initWithString:self.text] mutableCopy];
    }
    
    NSRange range = [[attr string] rangeOfString:text];
    
    if (range.location != NSNotFound) {
        [attr setAttributes:attributeds range:range];
        self.attributedText = attr;
        FMLinkLabelClickItem *item = [FMLinkLabelClickItem itemWithText:text range:range transmitBody:transmitBody];
        item.clickBlock = clickBlock;
        [self addClickItem:item];
        [attr setAttributes:@{NSFontAttributeName : self.font} range:NSMakeRange(0, attr.length)];
        self.textView.text = [attr string];
    }
}

- (void)addClickTextAttachmentName:(NSString *)attachmentName TransmitBody:(id)transmitBody clickItemBlock:(FMLinkLabelClickItemBlock)clickBlock{
    FMLinkLabelClickItem *item = [FMLinkLabelClickItem itemWithTransmitBody:transmitBody];
    item.clickBlock = clickBlock;
    [self.clickAttachmentItems setValue:item forKey:attachmentName];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
   
    __block BOOL isClickText = NO;
    
    [self.clickItems enumerateObjectsUsingBlock:^(FMLinkLabelClickItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.textRect, point)) {
            if (obj.clickBlock) {
                obj.clickBlock(obj.transmitBody);
                isClickText = YES;
                *stop = YES;
            }
        }
    }];
    
    if (!isClickText) {
        if (self.attributedText) {
            __weak typeof(self)weakSelf = self;
            [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(FMTextAttachment* value, NSRange range, BOOL * _Nonnull stop) {
                if (value && CGRectEqualToRect(value.bounds, CGRectMake(0, 0, 23, 23))) {
                    weakSelf.textView.selectedRange = range;
                    CGRect rect = [weakSelf.textView firstRectForRange:weakSelf.textView.selectedTextRange];
                    weakSelf.textView.selectedRange = NSMakeRange(0, 0);
                    if (CGRectContainsPoint(rect, point)) {
                        FMLinkLabelClickItem *item = [self.clickAttachmentItems valueForKey:value.attachmentName];
                        if (item) {
                            if (item.clickBlock) {
                                item.clickBlock(item.transmitBody);
                            }
                        }
                    }
                }
            }];
        }
    }
    
}

- (void)setFont:(UIFont *)font{
    self.textView.font = font;
    [super setFont:font];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    CGSize size = [attributedText boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textView.frame = CGRectMake(-5, -8, size.width + 10, size.height + 16);
    self.textView.text = [attributedText string];
    [super setAttributedText:attributedText];
}

- (void)setText:(NSString *)text{
    self.textView.text = text;
    [super setText:text];
}

- (void)layoutSubviews{
    self.textView.frame = CGRectMake(-5, -8, self.bounds.size.width + 10,  self.bounds.size.height + 18);
}

- (UITextView *)textView{
    
    if (_textView == nil) {
      
        UITextView *textView = [[UITextView alloc] init];
        
        textView.userInteractionEnabled = NO;
        
        textView.editable = NO;
        
        textView.delegate = self;
        
        [self addSubview:textView];
        
        textView.textColor = [UIColor clearColor];
        
        textView.backgroundColor = [UIColor clearColor];
        
        textView.font = self.font;
        
        textView.text = self.text;
        
        _textView = textView;
    }
    return _textView;
}

@end

@implementation FMLinkLabelClickItem

+ (instancetype)itemWithText:(NSString *)text range:(NSRange)range transmitBody:(id)transmitBody{
    
    FMLinkLabelClickItem *item = [[FMLinkLabelClickItem alloc] init];
    
    item.text = text;
    
    item.range = range;
    
    item.transmitBody = transmitBody;
    
    return item;
}

+ (instancetype)itemWithTransmitBody:(id)transmitBody{
    return [self itemWithText:nil range:NSMakeRange(0, 0) transmitBody:transmitBody];
}

@end

@implementation FMTextAttachment



@end
