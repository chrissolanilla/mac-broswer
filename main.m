#include <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

static NSNotificationName const buttonClicked = @"buttonClicked";

@interface Window : NSWindow <NSWindowDelegate>
@property (strong) NSTextField *label;
@property (strong) NSButton *button;
@end

@implementation Window

- (instancetype)init {
    self = [super initWithContentRect:NSMakeRect(0, 0, 420, 220)
                            styleMask:(NSWindowStyleMaskTitled |
                                       NSWindowStyleMaskClosable |
                                       NSWindowStyleMaskMiniaturizable |
                                       NSWindowStyleMaskResizable)
                              backing:NSBackingStoreBuffered
                                defer:NO];
    if (!self) return nil;

    self.title = @"Busto Browser";
    self.delegate = self;
    [self center];

    self.label = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 90, 380, 60)];
    self.label.stringValue = @"Busto Browser";
    self.label.bezeled = NO;
    self.label.drawsBackground = NO;
    self.label.editable = YES;
    self.label.selectable = YES;
    self.label.font = [NSFont boldSystemFontOfSize:42];

	[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(textDidChange:)
		name:NSControlTextDidChangeNotification
		object:self.label];


    [self.contentView addSubview:self.label];

	//butotn
	self.button = [[NSButton alloc] initWithFrame:NSMakeRect(20,80,160,32)];
	self.button.title = @"BUst";
	self.button.bezelStyle = NSBezelStyleRounded;
	self.button.target = self;
	self.button.action = @selector(buttonPressed:);

	[[NSNotificationCenter defaultCenter] addObserver:self
		selector:@selector(buttonNotificationRecieved:)
		name:buttonClicked
		object:nil];



    [self.contentView addSubview:self.button];

    [self makeKeyAndOrderFront:nil];
    return self;
}

- (BOOL)windowShouldClose:(id)sender {
    [NSApp terminate:nil];
    return YES;
}

- (void)textDidChange:(NSNotification *)notification {
	NSTextField *tf = (NSTextField *)notification.object;
	NSLog(@"text is: %@", tf.stringValue);
}

- (void)buttonPressed:(id)sender {
	NSString *current = self.label.stringValue;

    NSLog(@"current text is: %@", current);
	self.label.stringValue = @"poop";

    [[NSNotificationCenter defaultCenter] postNotificationName:buttonClicked object:nil];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [NSApplication sharedApplication];
        [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

        __unused Window *window = [[Window alloc] init];

        [NSApp activateIgnoringOtherApps:YES];
        [NSApp run];
    }
    return 0;
}

