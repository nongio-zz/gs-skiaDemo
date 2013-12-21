include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = SkiaDemo

SkiaDemo_OBJCC_FILES = \
	main.mm \
	AppController.mm \
	DemoOpenGLView.mm

ADDITIONAL_OBJCFLAGS += -Wall -g -O0 -std=gnu99
ADDITIONAL_CFLAGS += -Wall -g -O0 -std=gnu99
ADDITIONAL_LIB_DIRS += -LSkiaLib/lib/
ADDITIONAL_TOOL_LIBS =  -lgnustep-gui -lGL -lskia
ADDITIONAL_INCLUDE_DIRS = -I../Headers\
													-ISkiaInclude/core/\
													-ISkiaInclude/config/\
													-ISkiaInclude/gpu/\
													-ISkiaInclude/utils/\
													-ISkiaInclude/gpu/gl/\
													-ISkiaInclude/effects

-include GNUmakefile.preamble
include $(GNUSTEP_MAKEFILES)/tool.make
include $(GNUSTEP_MAKEFILES)/application.make
-include GNUmakefile.postamble
