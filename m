From: Eric Jensen <ericcj@gmail.com>
Subject: rt-tests Android.mk for cyclictest and hackbench
Date: Thu, 10 Mar 2016 10:33:30 -0500
Message-ID: <CAB+ZbRWHb8PB4OW=EtN4v1JvPa+eWyp=Li-8Y1ROk3e0zbGm8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36838 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbcCJPdu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Mar 2016 10:33:50 -0500
Received: by mail-yk0-f172.google.com with SMTP id r203so31332580ykd.3
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Mar 2016 07:33:49 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I couldn't find one of these on the web, but I think it would be nice
to include in the git repo to make it easy for people to add to their
manifest when building AOSP.  This Android.mk is working for me on
lollipop and I think would work for others:

LOCAL_PATH:= $(call my-dir)

commonFlags := -Wall -Wno-nonnull -O2 -DPTHREAD_BIONIC -DVERSION=0.96
-D_GNU_SOURCE

include $(CLEAR_VARS)
LOCAL_MODULE := librttest
LOCAL_MODULE_TAGS := eng
FILE_LIST := $(wildcard $(LOCAL_PATH)/src/lib/*.c)
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
LOCAL_CFLAGS += $(commonFlags)
LOCAL_LDLIBS += -ldl
LOCAL_LDFLAGS += -pie
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := cyclictest
LOCAL_MODULE_TAGS := eng
LOCAL_STATIC_LIBRARIES := librttest
FILE_LIST := $(wildcard $(LOCAL_PATH)/src/cyclictest/*.c)
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
LOCAL_CFLAGS += $(commonFlags)
LOCAL_LDLIBS += -ldl
LOCAL_LDFLAGS += -pie
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := hackbench
LOCAL_MODULE_TAGS := eng
LOCAL_STATIC_LIBRARIES := librttest
FILE_LIST := $(wildcard $(LOCAL_PATH)/src/hackbench/*.c)
LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
LOCAL_CFLAGS += $(commonFlags)
LOCAL_LDLIBS += -ldl
LOCAL_LDFLAGS += -pie
LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
include $(BUILD_EXECUTABLE)
