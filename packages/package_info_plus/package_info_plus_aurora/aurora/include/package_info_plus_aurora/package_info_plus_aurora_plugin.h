/*
 * Copyright (c) 2023. Open Mobile Platform LLC.
 * License: Proprietary.
 */
#ifndef FLUTTER_PLUGIN_PACKAGE_INFO_PLUS_AURORA_PLUGIN_H
#define FLUTTER_PLUGIN_PACKAGE_INFO_PLUS_AURORA_PLUGIN_H

#include <flutter/plugin-interface.h>

#ifdef PLUGIN_IMPL
#define PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define PLUGIN_EXPORT
#endif

class PLUGIN_EXPORT PackageInfoPlusAuroraPlugin final : public PluginInterface
{
public:
    void RegisterWithRegistrar(PluginRegistrar &registrar) override;

private:
    void onMethodCall(const MethodCall &call);
    void onGetApplicationOrg(const MethodCall &call);
    void onGetApplicationName(const MethodCall &call);
    void unimplemented(const MethodCall &call);
};

#endif /* FLUTTER_PLUGIN_PACKAGE_INFO_PLUS_AURORA_PLUGIN_H */
