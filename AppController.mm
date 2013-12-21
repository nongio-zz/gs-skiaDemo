#import <Foundation/Foundation.h>
#import <AppKit/NSWindow.h>
#import <AppKit/NSOpenGL.h>
#import <AppKit/NSApplication.h>
#import <AppKit/NSMenu.h>
#import "DemoOpenGLView.h"
#import "AppController.h"

#import <GL/gl.h>
#include <GL/glx.h>
static NSOpenGLPixelFormat *fmt = nil;
static int attrs[] =
    {
      NSOpenGLPFADoubleBuffer,
      NSOpenGLPFAAccelerated,
      NSOpenGLPFAColorSize, 8,
      NSOpenGLPFAAlphaSize, 8,
      NSOpenGLPFADepthSize, 24,
      NSOpenGLPFAStencilSize, 8,
      0
    };
@implementation AppController
-(void)applicationDidFinishLaunching: (NSNotification*)aNote
{
#if GNUSTEP
  NSMenu * menu = [[NSMenu alloc] initWithTitle: @"Main Menu"];

  [menu addItemWithTitle: @"SkiaDemo"
                  action: @selector(orderFrontStandardAboutPanel:)
           keyEquivalent: @""];
  [menu addItemWithTitle: @"Quit"
                  action: @selector(terminate:)
           keyEquivalent: @"q"];

  [NSApp setMainMenu: menu];
  [menu release];
#endif

  _window = [[NSWindow alloc] initWithContentRect: NSMakeRect(300,200,1024, 768)
                                        styleMask: NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask
                                          backing: NSBackingStoreBuffered
                                            defer: NO];

  DemoOpenGLView * openGLView;
  fmt = [[NSOpenGLPixelFormat alloc] initWithAttributes: (NSOpenGLPixelFormatAttribute *) attrs];
  openGLView = [[DemoOpenGLView alloc] initWithFrame: [[_window contentView] frame]
                                         pixelFormat: fmt];

  [_window setContentView: openGLView];

  [_window setTitle: @"GNUstep Skia Demo"];

  [_window makeKeyAndOrderFront: nil];
}
-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(id)sender
{
  return YES;
}
-(void)dealloc
{
  [_window release];
  [super dealloc];
}
@end
