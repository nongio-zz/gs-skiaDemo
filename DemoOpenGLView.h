#import <AppKit/NSOpenGLView.h>


#import <Foundation/Foundation.h>
#import <GrContext.h>
#import <GrRenderTarget.h>
#import <SkDevice.h>
#import <SkGpuDevice.h>
#import <SkCanvas.h>
#import <SkGraphics.h>
#import <GrGLInterface.h>

@interface DemoOpenGLView : NSOpenGLView
{
  SkCanvas * canvas;
  GrContext * fContext;
  GrRenderTarget * fRenderTarget;
  const GrGLInterface * fInterface;
  SkGpuDevice * device;
}

@end
