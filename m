From: Eric Jensen <ericcj@gmail.com>
Subject: Re: rt-tests Android.mk for cyclictest and hackbench
Date: Fri, 11 Mar 2016 10:10:42 -0500
Message-ID: <CAB+ZbRUH2G6obZPkeiH51UnvupbJ-tMkTGhDh80==5v5CAOoYg@mail.gmail.com>
References: <CAB+ZbRV_5c_+e2YrcCSPFg6+7pxHfxZVvLGeWoGcH1Mf7_czLw@mail.gmail.com>
 <20160310101841.2bf5ee3b@sluggy.hsv.redhat.com> <alpine.LFD.2.20.1603111221240.8679@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Clark Williams <williams@redhat.com>,
	Henrik Austad <haustad@cisco.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33239 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbcCKPLD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Mar 2016 10:11:03 -0500
Received: by mail-yw0-f177.google.com with SMTP id d65so96079048ywb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Mar 2016 07:11:02 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1603111221240.8679@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

To build as part of AOSP by just putting this repo into the repo
manifest.xml I believe Android.mk has to be at the root of the cloned
repo, e.g. http://elinux.org/Android_Build_System#Adding_a_new_program_to_build

I don't believe you can use the normal Makefile in AOSP, so I'm not
sure what that previous one was for...maybe for the NDK?

On Fri, Mar 11, 2016 at 6:38 AM, John Kacur <jkacur@redhat.com> wrote:
>
>
> On Thu, 10 Mar 2016, Clark Williams wrote:
>
>> On Thu, 10 Mar 2016 09:59:05 -0500
>> Eric Jensen <ericcj@gmail.com> wrote:
>>
>> > I couldn't find one of these on the web, but I think it would be nice to
>> > include in the git repo to make it easy for people to add to their manifest
>> > when building AOSP.  This Android.mk is working for me on lollipop and I
>> > think would work for others:
>> >
>>
>> I'm ok with including this file.
>>
>> For future reference the correct way to submit this sort of thing is in patch format. I grabbed your file and stuck it in the top level directory, added it to my git tree then ran 'git format-patch' with the SHA1 of the commit following your commit. This generated the patch below, which gives us attribution information, the files location and contents, and the appropriate mode for the newly created file. Please let me know if I put it in the right place with the right permissions.
>>
>> Clark
>>
>>
>> From 6fa0bf068fdbff809a4a903bcb28aa499b1f88c7 Mon Sep 17 00:00:00 2001
>> From: Eric Jensen <ericcj@gmail.com>
>> Date: Thu, 10 Mar 2016 10:11:25 -0600
>> Subject: [PATCH] Android Makefile for rt-tests
>>
>> Signed-off-by: Clark Williams <williams@redhat.com>
>> ---
>>  Android.mk | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Android.mk
>>
>> diff --git a/Android.mk b/Android.mk
>> new file mode 100644
>> index 000000000000..0df3aac9db1f
>> --- /dev/null
>> +++ b/Android.mk
>> @@ -0,0 +1,39 @@
>> +LOCAL_PATH:= $(call my-dir)
>> +
>> +commonFlags := -Wall -Wno-nonnull -O2 -DPTHREAD_BIONIC -DVERSION=0.96
>> +-D_GNU_SOURCE
>> +
>> +include $(CLEAR_VARS)
>> +LOCAL_MODULE := librttest
>> +LOCAL_MODULE_TAGS := eng
>> +FILE_LIST := $(wildcard $(LOCAL_PATH)/src/lib/*.c)
>> +LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
>> +LOCAL_CFLAGS += $(commonFlags)
>> +LOCAL_LDLIBS += -ldl
>> +LOCAL_LDFLAGS += -pie
>> +LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
>> +include $(BUILD_STATIC_LIBRARY)
>> +
>> +include $(CLEAR_VARS)
>> +LOCAL_MODULE := cyclictest
>> +LOCAL_MODULE_TAGS := eng
>> +LOCAL_STATIC_LIBRARIES := librttest
>> +FILE_LIST := $(wildcard $(LOCAL_PATH)/src/cyclictest/*.c)
>> +LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
>> +LOCAL_CFLAGS += $(commonFlags)
>> +LOCAL_LDLIBS += -ldl
>> +LOCAL_LDFLAGS += -pie
>> +LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
>> +include $(BUILD_EXECUTABLE)
>> +
>> +include $(CLEAR_VARS)
>> +LOCAL_MODULE := hackbench
>> +LOCAL_MODULE_TAGS := eng
>> +LOCAL_STATIC_LIBRARIES := librttest
>> +FILE_LIST := $(wildcard $(LOCAL_PATH)/src/hackbench/*.c)
>> +LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
>> +LOCAL_CFLAGS += $(commonFlags)
>> +LOCAL_LDLIBS += -ldl
>> +LOCAL_LDFLAGS += -pie
>> +LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
>> +include $(BUILD_EXECUTABLE)
>> --
>> 2.5.0
>
> Nice job getting Clark to do your work for you!
> Okay, just kidding.
>
> Currently we have a src/arch/android/Makefile
> that is included by the root Makefile that contains the differences
> required for building on android.
>
> You have something a little different I believe, although I have no way of
> testing on Android. It would be nice if you could come up with a similar
> scheme. Maybe create a src/arch/AOSP/Makefile
>
> If this isn't feasible, then please educate me as to why your scheme is
> preferable.
>
> Thanks
>
> John
