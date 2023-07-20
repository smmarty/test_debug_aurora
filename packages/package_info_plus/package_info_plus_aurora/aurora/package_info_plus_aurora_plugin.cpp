/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
#include <package_info_plus_aurora/package_info_plus_aurora_plugin.h>
#include <flutter/method-channel.h>
#include <flutter/platform-methods.h>
#include <sys/utsname.h>

void PackageInfoPlusAuroraPlugin::RegisterWithRegistrar(PluginRegistrar &registrar)
{
    registrar.RegisterMethodChannel("package_info_plus_aurora",
                                    MethodCodecType::Standard,
                                    [this](const MethodCall &call) { this->onMethodCall(call); });
}

void PackageInfoPlusAuroraPlugin::onMethodCall(const MethodCall &call)
{
    const auto &method = call.GetMethod();

    if (method == "getApplicationOrg") {
        onGetApplicationOrg(call);
        return;
    }
    
    if (method == "getApplicationName") {
        onGetApplicationName(call);
        return;
    }

    unimplemented(call);
}

void PackageInfoPlusAuroraPlugin::onGetApplicationOrg(const MethodCall &call)
{
    call.SendSuccessResponse(PlatformMethods::GetOrgname());
}

void PackageInfoPlusAuroraPlugin::onGetApplicationName(const MethodCall &call)
{
    call.SendSuccessResponse(PlatformMethods::GetAppname());
}

void PackageInfoPlusAuroraPlugin::unimplemented(const MethodCall &call)
{
    call.SendSuccessResponse(nullptr);
}
