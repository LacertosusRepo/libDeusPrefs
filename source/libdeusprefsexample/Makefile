ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Preferences

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = libDeusPrefsExample
libDeusPrefsExample_FILES = LDPRootListController.m
libDeusPrefsExample_LIBRARIES = DeusPrefs
libDeusPrefsExample_INSTALL_PATH = /Library/PreferenceBundles
libDeusPrefsExample_FRAMEWORKS = UIKit
libDeusPrefsExample_PRIVATE_FRAMEWORKS = Preferences
libDeusPrefsExample_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
