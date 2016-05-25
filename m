From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Wed, 25 May 2016 11:00:50 -0700
Message-ID: <CAGt3f4=SyBqM-7Jeitx10Tm8yTrNBpSoFNvCZNZX7A3oixzUzA@mail.gmail.com>
References: <1462903464-11448-1-git-send-email-brian@peloton-tech.com>
 <20160512085946.GB19035@linutronix.de> <CAGt3f4m=+yimx-wxDjH9TCzAb5F6zUbxG_RAEhTrT4cZWFKKcg@mail.gmail.com>
 <20160525163323.GB18036@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35767 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcEYSBU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 May 2016 14:01:20 -0400
Received: by mail-vk0-f49.google.com with SMTP id f66so75177785vkh.2
        for <linux-rt-users@vger.kernel.org>; Wed, 25 May 2016 11:01:20 -0700 (PDT)
In-Reply-To: <20160525163323.GB18036@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for looking at this. :)

On Wed, May 25, 2016 at 9:33 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Brian Silverman | 2016-05-16 14:05:54 [-0700]:
>
> Thank you for the explanation.
>
>>It happens when realtime (SCHED_RR/SCHED_FIFO) processes which have
>>called mlockall(MCL_CURRENT | MCL_FUTURE) exit.
>
> Why can't the application drop the RT priority before its exit? Wouldn't
> that be appropriate?

If it crashes or gets killed, it doesn't have a chance to drop priority.

>>One of them:
>> queue_cyclictes-5298  [000] ....1..   290.366030: remove_vma <-exit_mmap
>> queue_cyclictes-5298  [000] ....1..   290.366032: __might_sleep <-remove_vma
>> queue_cyclictes-5298  [000] ....1..   290.366033: ___might_sleep
>><-__might_sleep
>> queue_cyclictes-5298  [000] ....1..   290.366035: kmem_cache_free <-remove_vma
>> queue_cyclictes-5298  [000] ....1..   290.366036: preempt_count_add
>><-kmem_cache_free
>> queue_cyclictes-5298  [000] ....2..   290.366037: preempt_count_sub
>><-kmem_cache_free
>> queue_cyclictes-5298  [000] ....1..   290.366039: __slab_free <-kmem_cache_free
>> queue_cyclictes-5298  [000] d...1..   290.366040: preempt_count_add
>><-__slab_free
>> queue_cyclictes-5298  [000] d...2..   290.366041: preempt_count_sub
>><-__slab_free
>> queue_cyclictes-5298  [000] ....1..   290.366043: kmem_cache_free:
>>call_site=c0147054 ptr=ebb93cb8
>
> In this trace and the others you attached, you have a preempt count of
> at least one. Is this a function trace? For events I recently figure out
> that the counter in event tracing is recorded wrongly [0]. So my
> question here is basically is this a long preempt disable section or
> not.
>
> [0] http://permalink.gmane.org/gmane.linux.kernel/2227774

Yes, they are function traces without that patch applied. Every single
line in the file has a preempt count of at least 1.

Brian
