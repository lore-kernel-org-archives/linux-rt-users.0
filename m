From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Re: task switch from net-rx to idle when there is napi processing
 to be done
Date: Wed, 25 Jan 2012 03:30:51 -0800
Message-ID: <4F1FE7EB.3030601@caviumnetworks.com>
References: <4F1F6B66.5010005@caviumnetworks.com> <20120125085523.GG6305@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Subbiah, Venkat" <Venkat.Subbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8745 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab2AYLbp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 06:31:45 -0500
In-Reply-To: <20120125085523.GG6305@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/25/2012 12:55 AM, Uwe Kleine-K=F6nig wrote:
> Hello,
>
> On Tue, Jan 24, 2012 at 06:39:34PM -0800, Venkat Subbiah wrote:
>> In the process of debugging a napi ethernet driver performance
>> issue, what I am noticing is
>>
>> 1. While the driver is in the middle of a napi packet processing
>> loop, there is a task switch from
>> sirq-net-rx to idle even though there is pending napi processing to =
be done.
> I didn't check your logs below, but maybe this is related to the defa=
ult
> settings in /proc/sys/kernel/sched_rt_period_us and
> /proc/sys/kernel/sched_rt_runtime_us? That is 0.05s per second is
> reserved for non-RT tasks tasks such that a run-away realtime process
> will not lock up the machine.
>
> To verify that, try
>
> 	echo -1>  /proc/sys/kernel/sched_rt_runtime_us
>
> .
Thanks for you response. That was it. Setting this to -1 does the expec=
ted.

Then  I tried playing with these settings and set

/proc/sys/kernel/sched_rt_runtime_us to   95000
/proc/sys/kernel/sched_rt_period_us    to 100000

And even with  the switch from sirq-net-rx to idle happens every second=
s=20
and stays in idle for 0.05 seconds.  Are they any restrictions on what=20
these can be set to? I guess these setting may not be reasonable. I did=
=20
verify by doing a cat of these files and read back the expected values.

Then I tried

/proc/sys/kernel/sched_rt_period_us     to 1000000
/proc/sys/kernel/sched_rt_runtime_us   to 980000

Even here the idle is for 0.05 seconds

> Best regards
> Uwe
>

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
