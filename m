From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Wed, 21 Mar 2012 12:11:59 -0700
Message-ID: <4F6A27FF.5020107@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com> <CAONaPpH2Cr-k=NviUhnkf6j-dk5J6aY_9mmZT17ixGLsb5h2mw@mail.gmail.com> <4F691C88.2020907@linux.intel.com> <20120321191022.GA6857@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Denys Dmytriyenko <denis@denix.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43832 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459Ab2CUTMp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 15:12:45 -0400
In-Reply-To: <20120321191022.GA6857@denix.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/21/2012 12:10 PM, Denys Dmytriyenko wrote:
> On Tue, Mar 20, 2012 at 05:10:48PM -0700, Darren Hart wrote:
>>
>>
>> On 03/20/2012 04:58 PM, John Kacur wrote:
>>> On Tue, Mar 20, 2012 at 8:05 PM, Darren Hart <dvhart@linux.intel.com> wrote:
>>>> Accept user supplied CFLAGS and LDFLAGS, overwriting the
>>>> Makefile supplied versions. This can cause the build to
>>>> fail if the user does not provide at least what the Makefile
>>>> defines, but so be it.
>>>>
>>>> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
>>>> CC: Clark Williams <williams@redhat.com>
>>>> CC: John Kacur <jkacur@redhat.com>
>>>> CC: Denys Dmytriyenko <denis@denix.org>
>>>> ---
>>>
>>> I was just wondering what you need LDFLAGS for? Chatting with Darren
>>> on IRC, it seems like you're using -Wl to pass options via gcc to the
>>> linker, and we don't have loadable libs either. Maybe you could resend
>>> the patch with just the CFLAGS change until we have a real world
>>> reason for LDFLAGS
>>
>> Denys,
>>
>> Am I missing a reason why we need LDFLAGS? With the current Makefile. we
>> could just add anything we want to CFLAGS in a pinch anyway...
> 
> Darren,
> 
> From OE-Core config files:
> 
> LINKER_HASH_STYLE ??= "gnu"
> TARGET_LINK_HASH_STYLE ?= "${@['-Wl,--hash-style=gnu',''][d.getVar('LINKER_HASH_STYLE', True) != 'gnu']}"
> export TARGET_LDFLAGS = "-Wl,-O1 ${TARGET_LINK_HASH_STYLE}"
> ASNEEDED = "-Wl,--as-needed"
> TARGET_LDFLAGS += "${ASNEEDED}"
> export LDFLAGS = "${TARGET_LDFLAGS}"
> 
> 
> So, those are still linker flags (altough passed through -Wl to gcc), hence 
> they belong to LDFLAGS, not CFLAGS. Arguably, you only need to pass CFLAGS 
> during compile stage and LDFLAGS during link stage. On the other hand, as a 
> workaround, I was passing them to TARGET_CC_ARCH, which gets embedded into CC 
> and won't distinguish between compile/link stages...
> 
> So rt-tests just gets away not using LDFLAGS and re-using CFLAGS for the link 
> stage. :) But the current Makefile as it is now won't honor CFLAGS being set 
> from outside, unless you pass them explicitly on the command line to make, or 
> call make with -e flag.

Right, at the very least I'll resubmit the patch allowing override of
CFLAGS. But I wanted to know if you felt there was any need to support
overriding of LDFLAGS for rt-tests which doesn't build any shared libs.


-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
