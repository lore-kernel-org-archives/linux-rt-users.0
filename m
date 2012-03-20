From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Tue, 20 Mar 2012 12:45:55 -0700
Message-ID: <4F68DE73.2040608@linux.intel.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com> <CANqCtQK+egf9i=Qb5r9zSt1Ahm4zTpFW3dHsMnn68DsT2YuDXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Denys Dmytriyenko <denis@denix.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16915 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756691Ab2CTTri (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 15:47:38 -0400
In-Reply-To: <CANqCtQK+egf9i=Qb5r9zSt1Ahm4zTpFW3dHsMnn68DsT2YuDXg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/20/2012 12:31 PM, Remy Bohmer wrote:
> Hi,
> 
> 2012/3/20 Darren Hart <dvhart@linux.intel.com>:
>> Accept user supplied CFLAGS and LDFLAGS, overwriting the
>> Makefile supplied versions. This can cause the build to
>> fail if the user does not provide at least what the Makefile
>> defines, but so be it.
>> -CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
>> +CFLAGS ?= -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
>> +LDFLAGS ?=
> 
> Why not append the Makefile local flags to the user supplied flags?
> Something like:
> CFLAGS := $(CFLAGS) -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
> 

I considered that. Ultimately, the goal is to provide more control to
users, especially those who may be integrating the package into a larger
build system. In this case, I think control of which warnings you
display and where the includes come from should be configurable, even if
it enables them to blow their feet off.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
