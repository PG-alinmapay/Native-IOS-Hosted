# Native iOS Hosted SDK -- Integration Guide

## Overview

This repository contains the **Native iOS Hosted SDK**, including:

-   Demo iOS Application
-   Hosted Payment Plugin
-   CocoaPods dependencies

The SDK enables merchants to securely accept payments inside native iOS
applications using hosted payment flows.

------------------------------------------------------------------------

## Repository Structure

    DemoApp.xcodeproj / DemoApp.xcworkspace → Sample iOS application
    DemoApp                               → Demo source code
    Pods                                  → CocoaPods dependencies
    plugin                                → Native iOS hosted payment plugin

------------------------------------------------------------------------

## Requirements

-   **Xcode** with iOS 12.0+ support\
-   **CocoaPods** installed on macOS\
-   **Merchant Credentials**
    -   Terminal ID
    -   Terminal Password
    -   Merchant Key
    -   Request URL (Test / Production)

------------------------------------------------------------------------

## SDK Installation

1.  Open **Terminal** and navigate to the project root.
2.  Open the **Podfile**.
3.  Add the plugin dependency:

``` ruby
pod 'direct_ios_plugin', :git => '<merchant-github-repo-url>'
```

4.  Run:

``` bash
pod install
```

5.  Open the generated **.xcworkspace** in Xcode.

------------------------------------------------------------------------

## Merchant Configuration

Configure credentials inside SDK:

``` json
{
  "merchantKey": "<provided-by-AlinmaPay>",
  "terminalId": "<provided-by-AlinmaPay>",
  "terminalPass": "<provided-by-AlinmaPay>",
  "requestUrl": "<test-or-production-url>"
}
```

⚠️ **Never expose production credentials in public repositories.**

------------------------------------------------------------------------

## Basic Usage

Import plugin in **ViewController**:

``` swift
import direct_ios_plugin
```

Initialize SDK on button click:

``` swift
UWInitialization.init(self)
```

### Required Callbacks

-   `prepareModel()` → Set payment parameters\
-   `didPaymentResult(paymentModel, error)` → Receive transaction result

------------------------------------------------------------------------

## Supported Payment Operations

-   Purchase\
-   Authorization\
-   Refund\
-   Void\
-   Tokenization\
-   Purchase with Token\
-   Transaction Inquiry

------------------------------------------------------------------------

## iOS Compatibility

-   **Minimum iOS:** 12.0\
-   **Tested up to:** iOS 17+

------------------------------------------------------------------------

## Security Notes

-   Keep **Merchant Key** confidential\
-   Use **sandbox credentials** during testing\
-   Switch to **production credentials** only for release builds

------------------------------------------------------------------------

## Support

For integration assistance or merchant onboarding:

**AlinmaPay Technical Support**
