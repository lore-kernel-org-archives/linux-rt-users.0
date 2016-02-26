From: Mathias Koehrer <mathias.koehrer@etas.com>
Subject: Re: Kernel thread's CPU affinity with isolcpus kernel boot argument
Date: Fri, 26 Feb 2016 11:53:53 +0100
Message-ID: <56D02EC1.6000403@etas.com>
References: <5698D4D0.3020907@etas.com> <20160225141806.GB16161@linutronix.de>
 <20160225144308.GG9598@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Josh Cartwright <joshc@ni.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:30444 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbcBZKx4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 05:53:56 -0500
In-Reply-To: <20160225144308.GG9598@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am 25.02.2016 um 15:43 schrieb Josh Cartwright:
> On Thu, Feb 25, 2016 at 03:18:06PM +0100, Sebastian Andrzej Siewior wrote:
>> * Mathias Koehrer | 2016-01-15 12:15:28 [+0100]:
>>
>>> However, I noticed that most kernel threads use the affinity mask 0xff.
>>> I can change this by using ???taskset???. However, I am wondering if
>>> there is mechanism that forces the kernel to consider the value of
>>> ???isolcpus??? also for kernel threads.
>>
>> not that I am aware of. There are a few per-CPU threads which have to
>> stay the way they are. I would have expected that others like kworker/u*
>> respect the isol CPUs and stay away.
>
> I suppose the higher level question to Mathias is: are you seeing these
> threads perturb your application?  Or, are you just observing they are
> affinitized to isolcpus?
We use isolcpus=1-31 to reserve all cores but core 0 for real time stuff.
I just noticed, that some kernel threads have an affinity to cores > 0.
So far I did not observe any disturbance from these threads.

Thanks

Mathias

