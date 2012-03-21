From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Wed, 21 Mar 2012 21:16:04 +0100
Message-ID: <CAONaPpH7UgxeLXVcm2dqRwzGyFRs6yY8OiLw-Ocq_BQO7C7zJA@mail.gmail.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	<CAONaPpH2Cr-k=NviUhnkf6j-dk5J6aY_9mmZT17ixGLsb5h2mw@mail.gmail.com>
	<4F691C88.2020907@linux.intel.com>
	<20120321191022.GA6857@denix.org>
	<4F6A27FF.5020107@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Denys Dmytriyenko <denis@denix.org>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55800 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758171Ab2CUUQF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 16:16:05 -0400
Received: by dajr28 with SMTP id r28so2042531daj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Mar 2012 13:16:04 -0700 (PDT)
In-Reply-To: <4F6A27FF.5020107@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 21, 2012 at 8:11 PM, Darren Hart <dvhart@linux.intel.com> wrote:
>
>
> On 03/21/2012 12:10 PM, Denys Dmytriyenko wrote:
>> On Tue, Mar 20, 2012 at 05:10:48PM -0700, Darren Hart wrote:
>>>
>>>
>>> On 03/20/2012 04:58 PM, John Kacur wrote:
>>>> On Tue, Mar 20, 2012 at 8:05 PM, Darren Hart <dvhart@linux.intel.com> wrote:
>>>>> Accept user supplied CFLAGS and LDFLAGS, overwriting the
>>>>> Makefile supplied versions. This can cause the build to
>>>>> fail if the user does not provide at least what the Makefile
>>>>> defines, but so be it.
>>>>>
>>>>> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
>>>>> CC: Clark Williams <williams@redhat.com>
>>>>> CC: John Kacur <jkacur@redhat.com>
>>>>> CC: Denys Dmytriyenko <denis@denix.org>
>>>>> ---
>>>>
>>>> I was just wondering what you need LDFLAGS for? Chatting with Darren
>>>> on IRC, it seems like you're using -Wl to pass options via gcc to the
>>>> linker, and we don't have loadable libs either. Maybe you could resend
>>>> the patch with just the CFLAGS change until we have a real world
>>>> reason for LDFLAGS
>>>
>>> Denys,
>>>
>>> Am I missing a reason why we need LDFLAGS? With the current Makefile. we
>>> could just add anything we want to CFLAGS in a pinch anyway...
>>
>> Darren,
>>
>> From OE-Core config files:
>>
>> LINKER_HASH_STYLE ??= "gnu"
>> TARGET_LINK_HASH_STYLE ?= "${@['-Wl,--hash-style=gnu',''][d.getVar('LINKER_HASH_STYLE', True) != 'gnu']}"
>> export TARGET_LDFLAGS = "-Wl,-O1 ${TARGET_LINK_HASH_STYLE}"
>> ASNEEDED = "-Wl,--as-needed"
>> TARGET_LDFLAGS += "${ASNEEDED}"
>> export LDFLAGS = "${TARGET_LDFLAGS}"
>>
>>
>> So, those are still linker flags (altough passed through -Wl to gcc), hence
>> they belong to LDFLAGS, not CFLAGS. Arguably, you only need to pass CFLAGS
>> during compile stage and LDFLAGS during link stage. On the other hand, as a
>> workaround, I was passing them to TARGET_CC_ARCH, which gets embedded into CC
>> and won't distinguish between compile/link stages...
>>
>> So rt-tests just gets away not using LDFLAGS and re-using CFLAGS for the link
>> stage. :) But the current Makefile as it is now won't honor CFLAGS being set
>> from outside, unless you pass them explicitly on the command line to make, or
>> call make with -e flag.
>
> Right, at the very least I'll resubmit the patch allowing override of
> CFLAGS. But I wanted to know if you felt there was any need to support
> overriding of LDFLAGS for rt-tests which doesn't build any shared libs.
>

Okay, never mind, you've convinced me, and your changes don't look
like they will break anything, so I'll give you my approval as is.

Thanks.
John
