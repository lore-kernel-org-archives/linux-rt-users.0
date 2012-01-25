From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Re: task switch from net-rx to idle when there is napi processing
 to be done
Date: Wed, 25 Jan 2012 03:40:45 -0800
Message-ID: <4F1FEA3D.2080604@caviumnetworks.com>
References: <4F1F6B66.5010005@caviumnetworks.com>	 <20120125085523.GG6305@pengutronix.de> <1327483093.6973.10.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>,
	"Subbiah, Venkat" <Venkat.Subbiah@caviumnetworks.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8997 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab2AYLlT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jan 2012 06:41:19 -0500
In-Reply-To: <1327483093.6973.10.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/25/2012 01:18 AM, Mike Galbraith wrote:
> On Wed, 2012-01-25 at 09:55 +0100, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>
>> On Tue, Jan 24, 2012 at 06:39:34PM -0800, Venkat Subbiah wrote:
>>> In the process of debugging a napi ethernet driver performance
>>> issue, what I am noticing is
>>>
>>> 1. While the driver is in the middle of a napi packet processing
>>> loop, there is a task switch from
>>> sirq-net-rx to idle even though there is pending napi processing to=
 be done.
>> I didn't check your logs below, but maybe this is related to the def=
ault
>> settings in /proc/sys/kernel/sched_rt_period_us and
>> /proc/sys/kernel/sched_rt_runtime_us? That is 0.05s per second is
>> reserved for non-RT tasks tasks such that a run-away realtime proces=
s
>> will not lock up the machine.
>>
>> To verify that, try
>>
>> 	echo -1>  /proc/sys/kernel/sched_rt_runtime_us
> Hm, makes sense if this is a UP box.  SMP would just go borrow a cup =
of
> runtime from a neighbor.
Yes this experiment was when running with only one core.
> 	-Mike
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
