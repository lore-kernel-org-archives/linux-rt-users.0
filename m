From: Henrik Austad <haustad@cisco.com>
Subject: Re: rt-tests Android.mk for cyclictest and hackbench
Date: Fri, 11 Mar 2016 19:39:13 +0100
Message-ID: <56E310D1.7060606@cisco.com>
References: <CAB+ZbRV_5c_+e2YrcCSPFg6+7pxHfxZVvLGeWoGcH1Mf7_czLw@mail.gmail.com>
 <20160310101841.2bf5ee3b@sluggy.hsv.redhat.com>
 <alpine.LFD.2.20.1603111221240.8679@riemann>
 <CAB+ZbRUH2G6obZPkeiH51UnvupbJ-tMkTGhDh80==5v5CAOoYg@mail.gmail.com>
 <alpine.LFD.2.20.1603111905380.6821@riemann>
 <CAB+ZbRVQMT3_9tzqt5=s18og98n+6rBn30LOX0YVGHLyDVGAKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Eric Jensen <ericcj@gmail.com>, John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-4.cisco.com ([173.38.203.54]:64066 "EHLO
	aer-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbcCKSs6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Mar 2016 13:48:58 -0500
In-Reply-To: <CAB+ZbRVQMT3_9tzqt5=s18og98n+6rBn30LOX0YVGHLyDVGAKA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/11/2016 07:24 PM, Eric Jensen wrote:
> Thanks. Clark did it right?  What's a SOB?

Signed-off By, your tag to the patch that you verify the changes and 
that to the best of your knowledge is correct.

If you look in the git-history of the project, you see that all the 
patches contain one or more SOBs.

Also; would you mind adding a README.android or something briefly 
outlying how to hook it into an Android-build system? Once there's a 
AOSP-makefile, there's bound to be questions about it and having a few 
lines would be valuable down the road methinks.
Thanks!

Henrik
>
> On Friday, March 11, 2016, John Kacur <jkacur@redhat.com
> <mailto:jkacur@redhat.com>> wrote:
>
>
>
>     On Fri, 11 Mar 2016, Eric Jensen wrote:
>
>      > To build as part of AOSP by just putting this repo into the repo
>      > manifest.xml I believe Android.mk has to be at the root of the cloned
>      > repo, e.g.
>     http://elinux.org/Android_Build_System#Adding_a_new_program_to_build
>      >
>      > I don't believe you can use the normal Makefile in AOSP, so I'm not
>      > sure what that previous one was for...maybe for the NDK?
>
>     Ok, I'm fine with this too then, just answer Clark's questions, and send
>     your SOB, and we'll add it.
>
>      >
>      > On Fri, Mar 11, 2016 at 6:38 AM, John Kacur <jkacur@redhat.com
>     <javascript:;>> wrote:
>      > >
>      > >
>      > > On Thu, 10 Mar 2016, Clark Williams wrote:
>      > >
>      > >> On Thu, 10 Mar 2016 09:59:05 -0500
>      > >> Eric Jensen <ericcj@gmail.com <javascript:;>> wrote:
>      > >>
>      > >> > I couldn't find one of these on the web, but I think it
>     would be nice to
>      > >> > include in the git repo to make it easy for people to add to
>     their manifest
>      > >> > when building AOSP.  This Android.mk is working for me on
>     lollipop and I
>      > >> > think would work for others:
>      > >> >
>      > >>
>      > >> I'm ok with including this file.
>      > >>
>      > >> For future reference the correct way to submit this sort of
>     thing is in patch format. I grabbed your file and stuck it in the
>     top level directory, added it to my git tree then ran 'git
>     format-patch' with the SHA1 of the commit following your commit.
>     This generated the patch below, which gives us attribution
>     information, the files location and contents, and the appropriate
>     mode for the newly created file. Please let me know if I put it in
>     the right place with the right permissions.
>      > >>
>      > >> Clark
>      > >>
>      > >>
>      > >> From 6fa0bf068fdbff809a4a903bcb28aa499b1f88c7 Mon Sep 17
>     00:00:00 2001
>      > >> From: Eric Jensen <ericcj@gmail.com <javascript:;>>
>      > >> Date: Thu, 10 Mar 2016 10:11:25 -0600
>      > >> Subject: [PATCH] Android Makefile for rt-tests
>      > >>
>      > >> Signed-off-by: Clark Williams <williams@redhat.com <javascript:;>>
>      > >> ---
>      > >>  Android.mk | 39 +++++++++++++++++++++++++++++++++++++++
>      > >>  1 file changed, 39 insertions(+)
>      > >>  create mode 100644 Android.mk
>      > >>
>      > >> diff --git a/Android.mk b/Android.mk
>      > >> new file mode 100644
>      > >> index 000000000000..0df3aac9db1f
>      > >> --- /dev/null
>      > >> +++ b/Android.mk
>      > >> @@ -0,0 +1,39 @@
>      > >> +LOCAL_PATH:= $(call my-dir)
>      > >> +
>      > >> +commonFlags := -Wall -Wno-nonnull -O2 -DPTHREAD_BIONIC
>     -DVERSION=0.96
>      > >> +-D_GNU_SOURCE
>      > >> +
>      > >> +include $(CLEAR_VARS)
>      > >> +LOCAL_MODULE := librttest
>      > >> +LOCAL_MODULE_TAGS := eng
>      > >> +FILE_LIST := $(wildcard $(LOCAL_PATH)/src/lib/*.c)
>      > >> +LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
>      > >> +LOCAL_CFLAGS += $(commonFlags)
>      > >> +LOCAL_LDLIBS += -ldl
>      > >> +LOCAL_LDFLAGS += -pie
>      > >> +LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
>      > >> +include $(BUILD_STATIC_LIBRARY)
>      > >> +
>      > >> +include $(CLEAR_VARS)
>      > >> +LOCAL_MODULE := cyclictest
>      > >> +LOCAL_MODULE_TAGS := eng
>      > >> +LOCAL_STATIC_LIBRARIES := librttest
>      > >> +FILE_LIST := $(wildcard $(LOCAL_PATH)/src/cyclictest/*.c)
>      > >> +LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
>      > >> +LOCAL_CFLAGS += $(commonFlags)
>      > >> +LOCAL_LDLIBS += -ldl
>      > >> +LOCAL_LDFLAGS += -pie
>      > >> +LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
>      > >> +include $(BUILD_EXECUTABLE)
>      > >> +
>      > >> +include $(CLEAR_VARS)
>      > >> +LOCAL_MODULE := hackbench
>      > >> +LOCAL_MODULE_TAGS := eng
>      > >> +LOCAL_STATIC_LIBRARIES := librttest
>      > >> +FILE_LIST := $(wildcard $(LOCAL_PATH)/src/hackbench/*.c)
>      > >> +LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%)
>      > >> +LOCAL_CFLAGS += $(commonFlags)
>      > >> +LOCAL_LDLIBS += -ldl
>      > >> +LOCAL_LDFLAGS += -pie
>      > >> +LOCAL_C_INCLUDES += $(LOCAL_PATH)/src/include
>      > >> +include $(BUILD_EXECUTABLE)
>      > >> --
>      > >> 2.5.0
>      > >
>      > > Nice job getting Clark to do your work for you!
>      > > Okay, just kidding.
>      > >
>      > > Currently we have a src/arch/android/Makefile
>      > > that is included by the root Makefile that contains the differences
>      > > required for building on android.
>      > >
>      > > You have something a little different I believe, although I
>     have no way of
>      > > testing on Android. It would be nice if you could come up with
>     a similar
>      > > scheme. Maybe create a src/arch/AOSP/Makefile
>      > >
>      > > If this isn't feasible, then please educate me as to why your
>     scheme is
>      > > preferable.
>      > >
>      > > Thanks
>      > >
>      > > John
>      > --
>      > To unsubscribe from this list: send the line "unsubscribe
>     linux-rt-users" in
>      > the body of a message to majordomo@vger.kernel.org <javascript:;>
>      > More majordomo info at http://vger.kernel.org/majordomo-info.html
>      >
>
