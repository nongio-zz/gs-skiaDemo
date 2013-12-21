#import "DemoOpenGLView.h"

#import <GL/gl.h>
#include <GL/glx.h>

#import <AppKit/NSOpenGL.h>
#import <AppKit/NSButton.h>
#import <AppKit/NSApplication.h>
#import <AppKit/NSMenu.h>

#import <SkString.h>
#import <SkTypeface.h>

#include <SkGradientShader.h>
@implementation DemoOpenGLView

- (void) dealloc
{
  [super dealloc];
}

- (void) prepareOpenGL
{
  fRenderTarget = NULL;
  [super prepareOpenGL];
  fInterface = GrGLCreateNativeInterface();
  if(fInterface != NULL){
    [[self openGLContext] makeCurrentContext];
    fContext = GrContext::Create(kOpenGL_GrBackend, (GrBackendContext)fInterface);
    if(fContext != NULL)
      {
        GrBackendRenderTargetDesc desc;
        desc.fWidth = SkScalarRound([self frame].size.width);
        desc.fHeight = SkScalarRound([self frame].size.height);
        desc.fConfig = kSkia8888_GrPixelConfig;
        desc.fOrigin = kBottomLeft_GrSurfaceOrigin;
        desc.fStencilBits = 8;
        desc.fSampleCnt = 1;
        GrGLint buffer = 0;
        glGetIntegerv(GL_FRAMEBUFFER_BINDING, &buffer);
        desc.fRenderTargetHandle = buffer;
        fRenderTarget = fContext->wrapBackendRenderTarget(desc);
        device = new SkGpuDevice(fContext, fRenderTarget);
        canvas = new SkCanvas(device);
        glViewport(0, 0, [self frame].size.width, [self frame].size.height);
        glClearColor(1, 1, 1, 1);
    }
  }else{
    NSLog(@"no interface");
  }
}


static SkShader* setgrad(const SkRect& r, SkColor c0, SkColor c1) {
    SkColor colors[] = { c0, c1 };
    SkPoint pts[] = { { r.fLeft, r.fTop }, { r.fRight, r.fTop } };
    return SkGradientShader::CreateLinear(pts, colors, NULL, 2,
                                          SkShader::kClamp_TileMode, NULL);
}
- (void) drawGL
{
  [[self openGLContext] makeCurrentContext];
    glClearColor(1, 1, 1, 1);
    glClearStencil(0);
    glClear(GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    glEnable( GL_MULTISAMPLE );
    glEnable( GL_LINE_SMOOTH );
    glHint( GL_LINE_SMOOTH_HINT, GL_DONT_CARE );
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    //fContext->resetContext();

    SkPaint paint;
    paint.setAntiAlias(true);
    //paint.setLCDRenderText(true);
    paint.setTypeface(SkTypeface::CreateFromName("Lato", SkTypeface::kNormal));
    paint.setTextSize(SkIntToScalar(20));


    //Set Style and Stroke Width
    SkString text("hello skia!!");

    paint.setColor(SK_ColorWHITE);
    paint.setARGB(255, 0, 0, 0);
    //Set Text Size

    //Text X, Y Position Varibles
    int x = 80;
    int y = 60;

    canvas->drawText(text.c_str(), text.size(), x, y, paint);
    paint.setStyle(SkPaint::kStroke_Style);
    paint.setStrokeWidth(1);

    canvas->drawLine(10, 300, 300, 200, paint);

    //Draw A Rectangle
    SkRect rect;
    //Left, Top, Right, Bottom
    rect.set(50.5, 100.5, 200, 200);
    canvas->drawRect(rect, paint);
    //canvas->drawRoundRect(rect, 20, 20, paint);
    canvas->drawOval(rect, paint);

    SkRect rect2;
    rect2.set(350, 100, 500, 200);
    canvas->drawRect(rect2, paint);
    //canvas->drawRoundRect(rect2, 20, 20, paint);
    canvas->drawOval(rect2, paint);
    //Draw A Line

    //Draw Circle (X, Y, Size, Paint)
    canvas->drawCircle(100, 400, 100, paint);

    SkRect r;
    r.set(SkIntToScalar(10), SkIntToScalar(10),
          SkIntToScalar(410), SkIntToScalar(30));
    SkPaint p, p2;
    p2.setStyle(SkPaint::kStroke_Style);

    p.setShader(setgrad(r, 0xFF00FF00, 0xFF00FF00))->unref();
    canvas->drawRect(r, p);
    canvas->drawRect(r, p2);

    r.offset(0, r.height() + SkIntToScalar(4));
    p.setShader(setgrad(r, 0xFF00FF00, 0xFF000000))->unref();
    canvas->drawRect(r, p);
    canvas->drawRect(r, p2);

    r.offset(0, r.height() + SkIntToScalar(4));
    p.setShader(setgrad(r, 0xFF00FF00, 0xFFFF0000))->unref();
    canvas->drawRoundRect(rect, 20, 20, p);
    canvas->drawRoundRect(rect, 20, 20, p2);

    fContext->flush();
    [[self openGLContext] flushBuffer];   //glxSwapBuffers
}

-(void) drawRect: (NSRect) bounds
{
  [self drawGL];
  [self setNeedsDisplay: YES];
}

@end
