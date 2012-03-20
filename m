From: Remy Bohmer <linux@bohmer.net>
Subject: Re: [PATCH 1/3] rt-tests: Support user supplied CFLAGS and LDFLAGS
Date: Tue, 20 Mar 2012 20:57:14 +0100
Message-ID: <CANqCtQJ7OQ9KOMwKoecupCqk6r4COTUe9Xt=e-OhNmV8Ab+8Lw@mail.gmail.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	<CANqCtQK+egf9i=Qb5r9zSt1Ahm4zTpFW3dHsMnn68DsT2YuDXg@mail.gmail.com>
	<4F68DE73.2040608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Denys Dmytriyenko <denis@denix.org>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56670 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab2CTT5Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 15:57:16 -0400
Received: by bkcik5 with SMTP id ik5so355151bkc.19
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Mar 2012 12:57:14 -0700 (PDT)
In-Reply-To: <4F68DE73.2040608@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2012/3/20 Darren Hart <dvhart@linux.intel.com>:
>
>
> On 03/20/2012 12:31 PM, Remy Bohmer wrote:
>> Hi,
>>
>> 2012/3/20 Darren Hart <dvhart@linux.intel.com>:
>>> Accept user supplied CFLAGS and LDFLAGS, overwriting the
>>> Makefile supplied versions. This can cause the build to
>>> fail if the user does not provide at least what the Makefile
>>> defines, but so be it.
>>> -CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
>>> +CFLAGS ?= -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
>>> +LDFLAGS ?=
>>
>> Why not append the Makefile local flags to the user supplied flags?
>> Something like:
>> CFLAGS := $(CFLAGS) -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
>>
>
> I considered that. Ultimately, the goal is to provide more control to
> users, especially those who may be integrating the package into a larger
> build system. In this case, I think control of which warnings you
> display and where the includes come from should be configurable, even if
> it enables them to blow their feet off.

OK. Clear. Thanks.

Kind regards,

Remy
