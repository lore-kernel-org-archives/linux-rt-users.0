From: "Arnaud B." <discipleze1@gmail.com>
Subject: Re: Possible kernel regression between 3.0.31-rt51 and 3.4.x on PPC64 ?
Date: Fri, 13 Jul 2012 14:37:42 +0200
Message-ID: <CAJVbuypRyUCtssU+f1v1NcpwLK-=e5MtvajJsJgQ7VusiYgw5Q@mail.gmail.com>
References: <CAJVbuyqRZqtBat9hGWqK=EN1U4LA3uuQbwBmeazV83AuAP+Crg@mail.gmail.com>
	<4FFDBE71.2000705@am.sony.com>
	<CAJVbuyo3Y6=n6c-wyNsZgxAM0dkwiPrP7oN6aOMP=ozRtFJSug@mail.gmail.com>
	<4FFF3877.6080007@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:63020 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135Ab2GMMho (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2012 08:37:44 -0400
Received: by weyx8 with SMTP id x8so2443161wey.19
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jul 2012 05:37:42 -0700 (PDT)
In-Reply-To: <4FFF3877.6080007@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks anyway ;)

I made another try : same test case fail on 3.2.22-rt35
So the regression is between 3.0 and 3.2 !

Is there any ppc64 user here ?

/Arnaud.

2012/7/12 Frank Rowand <frank.rowand@am.sony.com>:
> On 07/12/12 06:11, Arnaud B. wrote:
>> Here are 2 crash logs. One is normal booting, the other is with
>> CONFIG_DEBUG_RT_MUTEXES choosen.
>> for sure w in rt_mutex_top_waiter, return by plist_first_entry is
>> corrupted. There is even ASCII in it from time to time :p
>
> < snip >
>
>> 2012/7/11 Frank Rowand <frank.rowand@am.sony.com>:
>>> On 07/11/12 09:02, Arnaud B. wrote:
>>>> Hi all,
>
> < snip >
>
>>>> If you need an more information, I got all this boards in front of me :)
>>>
>>> Can you show a little bit more of the messages aound the crash?  For example
>>> the register contents.  Disassembly of the instruction at pc, and a few before
>>> that.
>>>
>>> -Frank
>
> Thanks for the extra info.
>
> I was looking at a plist corruption issue on a 2.6.29 rt kernel, but it does not
> look like your situation at all.  So I don't have anything useful to contribute
> about your case.
>
> -Frank
