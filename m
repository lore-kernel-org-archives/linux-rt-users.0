From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Re: task switch from net-rx to idle when there is napi processing
 to be done
Date: Thu, 26 Jan 2012 12:35:40 -0800
Message-ID: <4F21B91C.7080206@caviumnetworks.com>
References: <4F1F6B66.5010005@caviumnetworks.com>  <20120125085523.GG6305@pengutronix.de>  <4F1FE7EB.3030601@caviumnetworks.com> <1327591757.22710.101.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Subbiah, Venkat" <Venkat.Subbiah@caviumnetworks.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8796 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186Ab2AZUfl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jan 2012 15:35:41 -0500
In-Reply-To: <1327591757.22710.101.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/26/2012 07:29 AM, Steven Rostedt wrote:
> On Wed, 2012-01-25 at 03:30 -0800, Venkat Subbiah wrote:
>> On 01/25/2012 12:55 AM, Uwe Kleine-K=F6nig wrote:
>>> Hello,
>>>
>>> On Tue, Jan 24, 2012 at 06:39:34PM -0800, Venkat Subbiah wrote:
>>>> In the process of debugging a napi ethernet driver performance
>>>> issue, what I am noticing is
>>>>
>>>> 1. While the driver is in the middle of a napi packet processing
>>>> loop, there is a task switch from
>>>> sirq-net-rx to idle even though there is pending napi processing t=
o be done.
>>> I didn't check your logs below, but maybe this is related to the de=
fault
>>> settings in /proc/sys/kernel/sched_rt_period_us and
>>> /proc/sys/kernel/sched_rt_runtime_us? That is 0.05s per second is
>>> reserved for non-RT tasks tasks such that a run-away realtime proce=
ss
>>> will not lock up the machine.
>>>
>>> To verify that, try
>>>
>>> 	echo -1>   /proc/sys/kernel/sched_rt_runtime_us
>>>
>>> .
>> Thanks for you response. That was it. Setting this to -1 does the ex=
pected.
> Note, you should also have seen a warning in the logs when an RT task=
 is
> throttled. Did you see such a thing?
I didn't get to the console,but it is in the kernel logs.
>
> -- Steve
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
