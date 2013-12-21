#import "AppController.h"

int main(int argc, const char ** argv, char ** environ)
{
  NSAutoreleasePool * pool = [NSAutoreleasePool new];
  AppController * controller = [AppController new];
  [[NSApplication sharedApplication] setDelegate:controller];
  [NSProcessInfo initializeWithArguments: (char**)argv
                                   count: argc
                             environment: environ];
  [NSApp run];
  [pool drain];
  return 0;
}

