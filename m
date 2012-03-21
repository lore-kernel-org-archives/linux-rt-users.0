From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Tue, 20 Mar 2012 17:10:48 -0700
Message-ID: <4F691C88.2020907@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com> <CAONaPpH2Cr-k=NviUhnkf6j-dk5J6aY_9mmZT17ixGLsb5h2mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Denys Dmytriyenko <denis@denix.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50397 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371Ab2CUALb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 20:11:31 -0400
In-Reply-To: <CAONaPpH2Cr-k=NviUhnkf6j-dk5J6aY_9mmZT17ixGLsb5h2mw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/20/2012 04:58 PM, John Kacur wrote:
> On Tue, Mar 20, 2012 at 8:05 PM, Darren Hart <dvhart@linux.intel.com> wrote:
>> Accept user supplied CFLAGS and LDFLAGS, overwriting the
>> Makefile supplied versions. This can cause the build to
>> fail if the user does not provide at least what the Makefile
>> defines, but so be it.
>>
>> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
>> CC: Clark Williams <williams@redhat.com>
>> CC: John Kacur <jkacur@redhat.com>
>> CC: Denys Dmytriyenko <denis@denix.org>
>> ---
> 
> I was just wondering what you need LDFLAGS for? Chatting with Darren
> on IRC, it seems like you're using -Wl to pass options via gcc to the
> linker, and we don't have loadable libs either. Maybe you could resend
> the patch with just the CFLAGS change until we have a real world
> reason for LDFLAGS

Denys,

Am I missing a reason why we need LDFLAGS? With the current Makefile. we
could just add anything we want to CFLAGS in a pinch anyway...

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
