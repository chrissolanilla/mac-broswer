#include <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

@interface Window : NSWindow <NSWindowDelegate>
@property (strong) NSTextField *label;
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

