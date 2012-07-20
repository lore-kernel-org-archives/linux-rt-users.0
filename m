From: "Arnaud B." <discipleze1@gmail.com>
Subject: Re: Possible kernel regression between 3.0.31-rt51 and 3.4.x on PPC64 ?
Date: Fri, 20 Jul 2012 15:30:23 +0200
Message-ID: <CAJVbuyoGeUEGkjEu=WTHye_mUfEWXZdspoJguwkEY-PZ+g6ang@mail.gmail.com>
References: <CAJVbuyqRZqtBat9hGWqK=EN1U4LA3uuQbwBmeazV83AuAP+Crg@mail.gmail.com>
	<4FFDBE71.2000705@am.sony.com>
	<CAJVbuyo3Y6=n6c-wyNsZgxAM0dkwiPrP7oN6aOMP=ozRtFJSug@mail.gmail.com>
	<4FFF3877.6080007@am.sony.com>
	<CAJVbuypRyUCtssU+f1v1NcpwLK-=e5MtvajJsJgQ7VusiYgw5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36551 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab2GTNaZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jul 2012 09:30:25 -0400
Received: by wgbdr13 with SMTP id dr13so3646747wgb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Jul 2012 06:30:23 -0700 (PDT)
In-Reply-To: <CAJVbuypRyUCtssU+f1v1NcpwLK-=e5MtvajJsJgQ7VusiYgw5Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

I don't know if it's useful, or not, but it still fails if I boot
using "nosmp", but it's ok if I built a kernel without CONFIG_SMP.
It's also ok with CONFIG_SMP and CONFIG_PREEMPT_RTB.

So it's something related to PPC64 + SMP + PREEMPT_RT_FULL


/Arnaud.

2012/7/13 Arnaud B. <discipleze1@gmail.com>:
> Thanks anyway ;)
>
> I made another try : same test case fail on 3.2.22-rt35
> So the regression is between 3.0 and 3.2 !
>
> Is there any ppc64 user here ?
>
> /Arnaud.
>
> 2012/7/12 Frank Rowand <frank.rowand@am.sony.com>:
>> On 07/12/12 06:11, Arnaud B. wrote:
>>> Here are 2 crash logs. One is normal booting, the other is with
>>> CONFIG_DEBUG_RT_MUTEXES choosen.
>>> for sure w in rt_mutex_top_waiter, return by plist_first_entry is
>>> corrupted. There is even ASCII in it from time to time :p
>>
>> < snip >
>>
>>> 2012/7/11 Frank Rowand <frank.rowand@am.sony.com>:
>>>> On 07/11/12 09:02, Arnaud B. wrote:
>>>>> Hi all,
>>
>> < snip >
>>
>>>>> If you need an more information, I got all this boards in front of me :)
>>>>
>>>> Can you show a little bit more of the messages aound the crash?  For example
>>>> the register contents.  Disassembly of the instruction at pc, and a few before
>>>> that.
>>>>
>>>> -Frank
>>
>> Thanks for the extra info.
>>
>> I was looking at a plist corruption issue on a 2.6.29 rt kernel, but it does not
>> look like your situation at all.  So I don't have anything useful to contribute
>> about your case.
>>
>> -Frank
