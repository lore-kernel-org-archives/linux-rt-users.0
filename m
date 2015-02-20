From: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Subject: Re: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Fri, 20 Feb 2015 12:25:33 -0700
Message-ID: <54E78A2D.5070409@hp.com>
References: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com> <20150217141333.GR26177@linutronix.de> <54E5F273.9020508@fos4x.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?UTF-8?B?UGhpbGlwcCBUw7Zsa2U=?= <philipp.toelke@fos4x.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:41188 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbbBTT01 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2015 14:26:27 -0500
In-Reply-To: <54E5F273.9020508@fos4x.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 02/19/2015 07:25 AM, Philipp T=C3=B6lke wrote:
> On 17.02.2015 15:13, Sebastian Andrzej Siewior wrote:
>>> I have a simple test that runs two iperf clients in parallel with t=
he
>>> ltp network tests and it triggers a deadlock within a few minutes.
>>> This is 100% repeatable. I've tried this on different RT kernels an=
d
>>> determined that prior to the following commit (which went into 3.10
>>> upstream), the machine doesn't deadlock and seems to run just fine:
>>>
>>> fb52f40e085ef4074f1335672cd62c1f832af13b rtmutex: Handle deadlock
>>> detection smarter
>>
>> has this been resolved in the meantime? Do you see the same problem =
with
>> v3.18-RT?
>=20
> I was not able to reproduce the issue with 3.18.7-rt1 in 24hours. I w=
ill
> repeat the test to be sure.
>=20
> Cheers,

I was not able to reproduce the issue either with 3.18.7-rt1.  I believ=
e
this is mainly attributed to the fact that run-local_timers() in
3.18.7-rt1 no longer calls spin_trylock(&base->lock), removing the
condition that could lead to the problem.

Thanks,
Mak.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
