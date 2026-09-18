#include <AetherCircleQuest/AetherCircleQuest.hpp>

#include <android/log.h>
#include <android_native_app_glue.h>
#include <openxr/openxr.h>
#include <openxr/openxr_platform.h>

#include <array>
#include <cstring>

namespace {

constexpr const char* logTag = "AetherCircleQuest";

void log(const char* text) {
    __android_log_print(ANDROID_LOG_INFO, logTag, "%s", text);
}

bool initializeLoader(android_app* app) {
    PFN_xrInitializeLoaderKHR initialize = nullptr;
    const XrResult result = xrGetInstanceProcAddr(
        XR_NULL_HANDLE,
        "xrInitializeLoaderKHR",
        reinterpret_cast<PFN_xrVoidFunction*>(&initialize)
    );
    if (XR_FAILED(result) || initialize == nullptr) {
        return false;
    }

    XrLoaderInitInfoAndroidKHR info{
        XR_TYPE_LOADER_INIT_INFO_ANDROID_KHR
    };
    info.applicationVM = app->activity->vm;
    info.applicationContext = app->activity->clazz;

    return XR_SUCCEEDED(initialize(
        reinterpret_cast<const XrLoaderInitInfoBaseHeaderKHR*>(&info)
    ));
}

XrInstance createInstance(
    android_app* app,
    const aethercircle::ApplicationInfo& application
) {
    const std::array<const char*, 2> extensions{
        XR_KHR_ANDROID_CREATE_INSTANCE_EXTENSION_NAME,
        XR_KHR_VULKAN_ENABLE2_EXTENSION_NAME
    };

    XrInstanceCreateInfoAndroidKHR androidInfo{
        XR_TYPE_INSTANCE_CREATE_INFO_ANDROID_KHR
    };
    androidInfo.applicationVM = app->activity->vm;
    androidInfo.applicationActivity = app->activity->clazz;

    XrInstanceCreateInfo info{XR_TYPE_INSTANCE_CREATE_INFO};
    info.next = &androidInfo;
    std::strncpy(
        info.applicationInfo.applicationName,
        application.name,
        XR_MAX_APPLICATION_NAME_SIZE - 1
    );
    info.applicationInfo.applicationVersion = application.version;
    std::strncpy(
        info.applicationInfo.engineName,
        "AetherCircle",
        XR_MAX_ENGINE_NAME_SIZE - 1
    );
    info.applicationInfo.engineVersion = 1;
    info.applicationInfo.apiVersion = XR_CURRENT_API_VERSION;
    info.enabledExtensionCount =
        static_cast<std::uint32_t>(extensions.size());
    info.enabledExtensionNames = extensions.data();

    XrInstance instance = XR_NULL_HANDLE;
    return XR_SUCCEEDED(xrCreateInstance(&info, &instance))
        ? instance
        : XR_NULL_HANDLE;
}

}  // namespace

namespace aethercircle {

void run(android_app* app, const ApplicationInfo& application) {
    log("AetherCircle Quest runtime started.");

    if (!initializeLoader(app)) {
        log("OpenXR loader initialization failed.");
        return;
    }

    const XrInstance instance = createInstance(app, application);
    if (instance == XR_NULL_HANDLE) {
        log("OpenXR instance creation failed.");
        return;
    }

    XrSystemGetInfo systemInfo{XR_TYPE_SYSTEM_GET_INFO};
    systemInfo.formFactor = XR_FORM_FACTOR_HEAD_MOUNTED_DISPLAY;
    XrSystemId system = XR_NULL_SYSTEM_ID;

    if (XR_FAILED(xrGetSystem(instance, &systemInfo, &system))) {
        log("Quest OpenXR system was not found.");
        xrDestroyInstance(instance);
        return;
    }

    log("OpenXR instance and Quest system are ready.");

    while (!app->destroyRequested) {
        int events = 0;
        android_poll_source* source = nullptr;
        while (ALooper_pollOnce(
            10,
            nullptr,
            &events,
            reinterpret_cast<void**>(&source)
        ) >= 0) {
            if (source != nullptr) {
                source->process(app, source);
            }
            if (app->destroyRequested) {
                break;
            }
        }
    }

    xrDestroyInstance(instance);
    log("AetherCircle Quest runtime stopped.");
}

}  // namespace aethercircle
