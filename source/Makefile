ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Preferences

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libDeusPrefs
libDeusPrefs_FILES = $(wildcard LDStylePickerCell/*.m) $(wildcard *.m)
libDeusPrefs_FRAMEWORKS = UIKit AppSupport
libDeusPrefs_PRIVATE_FRAMEWORKS = Preferences
libDeusPrefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/library.mk

ifeq ($(INSTALL_BUNDLE),1)
SUBPROJECTS += libdeusprefsexample
include $(THEOS_MAKE_PATH)/aggregate.mk
endif

install-to-theos::
	@$(MAKE)
	@echo "Installing libDeusPrefs to Theos..."
	@cp -R .theos/obj/debug/$(LIBRARY_NAME).dylib $(THEOS)/lib/
	@cp -R $(LIBRARY_NAME).h $(THEOS)/include/

install-bundle::
	@$(MAKE) INSTALL_BUNDLE=1 do
