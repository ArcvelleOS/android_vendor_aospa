#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

# Overlays
PRODUCT_PACKAGES += \
    AOSPABlackThemeOverlay \
    AOSPAFrameworksOverlay \
    AOSPAImmersiveNavigationOverlay \
    AOSPANetworkStackOverlay \
    AOSPANetworkStackMainlineOverlay \
    AOSPASettingsOverlay \
    AOSPASettingsProviderOverlay \
    AOSPASystemUIOverlay \
    FontComfortaaOverlay \
    FontExotwoOverlay \
    FontFiraSansOverlay \
    FontGoogleSansOverlay \
    FontHarmonySansOverlay \
    FontHKGroteskOverlay \
    FontInterOverlay \
    FontLinotteSourceOverlay \
    FontManropeOverlay \
    FontMiSansOverlay \
    FontNotoSansOverlay \
    FontOnePlusSansOverlay  \
    FontOppoSansOverlay \
    FontRecursiveCasualOverlay \
    FontRecursiveLinearOverlay \
    FontSourceSansOverlay \
    FontSourceSerifOverlay \
    FontSpaceGroteskOverlay \
    FontStoropiaOverlay \
    FontUrbanistOverlay \
    FontVolteOverlay \
    IconPackCircularAndroidOverlay \
    IconPackCircularLauncherOverlay \
    IconPackCircularSettingsOverlay \
    IconPackCircularSystemUIOverlay \
    IconPackCircularThemePickerOverlay \
    IconPackVictorAndroidOverlay \
    IconPackVictorLauncherOverlay \
    IconPackVictorSettingsOverlay \
    IconPackVictorSystemUIOverlay \
    IconPackVictorThemePickerOverlay \
    IconPackSamAndroidOverlay \
    IconPackSamLauncherOverlay \
    IconPackSamSettingsOverlay \
    IconPackSamSystemUIOverlay \
    IconPackSamThemePickerOverlay \
    IconPackKaiAndroidOverlay \
    IconPackKaiLauncherOverlay \
    IconPackKaiSettingsOverlay \
    IconPackKaiSystemUIOverlay \
    IconPackKaiThemePickerOverlay \
    IconPackFilledAndroidOverlay \
    IconPackFilledLauncherOverlay \
    IconPackFilledSettingsOverlay \
    IconPackFilledSystemUIOverlay \
    IconPackFilledThemePickerOverlay \
    IconPackRoundedAndroidOverlay \
    IconPackRoundedLauncherOverlay \
    IconPackRoundedSettingsOverlay \
    IconPackRoundedSystemUIOverlay \
    IconPackRoundedThemePickerOverlay \
    IconShapePebbleOverlay \
    IconShapeRoundedRectOverlay \
    IconShapeSquareOverlay \
    IconShapeSquircleOverlay \
    IconShapeTaperedRectOverlay \
    IconShapeTeardropOverlay \
    IconShapeVesselOverlay \
    ParanoidLauncherOverlay \
    PixelThemesStub

ifeq ($(TARGET_DISABLES_GMS), true)
# Overlay (Vanilla build)
PRODUCT_PACKAGES += \
    VanillaFrameworksOverlay
endif

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/aospa/overlay/static
PRODUCT_PACKAGE_OVERLAYS += vendor/aospa/overlay/static
