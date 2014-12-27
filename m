From: Chanchal Paul <paulchanchal.ece@gmail.com>
Subject: Re: Help needed to implement parameter in SCHED_DEADLINE policy
Date: Sun, 28 Dec 2014 00:09:36 +0530
Message-ID: <CAD2dHrTRVYp+5u+B=EAcryP6s5BFCvOyzs6ntDgMQkNTpDQDPg@mail.gmail.com>
References: <CAD2dHrTBZd6a_QdEqh4xhVj1c-e4bzAKF5uC4N6B+UEh-zgxvg@mail.gmail.com>
	<20141226221424.GA8000@sisyphus.home.austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kernelnewbies@kernelnewbies.org, linux-rt-users@vger.kernel.org
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:49132 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaL0Sjj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Dec 2014 13:39:39 -0500
Received: by mail-yh0-f41.google.com with SMTP id a41so5752603yho.14
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Dec 2014 10:39:36 -0800 (PST)
In-Reply-To: <20141226221424.GA8000@sisyphus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Let me explain what I am thinking.

I am only concerned about EDF scheduling policy. The scheduler
determines the order in which it should schedule tasks according to
their DEADLINE. I dont want to disturb that order. If a scheduler
picks up a task which is computationally intensive and lets it run
then due to its thermal characteristic it may heat up processor so
much that eventually a hardware DTM or a frequency scaling occurs and
the system slows down as a effect. Where as if the processor would
have waited a little bit (only that much due to which the task would
not miss its deadline) before letting the task run, and eventually
lets the other computationally non intensive tasks run (from the other
scheduling classes) then may be that DTM would have not occurred and
may be the system would not have slowed down.

So I want to solve this problem. or at least see what are the results
after implementation. I can think that the scheduler need more
information about the EDF tasks about their thermal (or computational)
characteristics. Initially I want to supply that information when I
submit a EDF task.

Thank you.

On Sat, Dec 27, 2014 at 3:44 AM, Henrik Austad <henrik@austad.us> wrote:
> On Fri, Dec 26, 2014 at 09:14:22PM +0530, Chanchal Paul wrote:
>> Hi all,
>
> Hi Paul,
>
>> I am trying to implement my custom scheduling policy in rt patched
>> linux kernel. I am working with version 3.14.25-rt22. I have
>> successfully installed the kernel after patching with rt patch of same
>> version.
>>
>> Now the installed kernel also has SCHED_DEADLINE i.e. the EDF scheduling policy.
>>
>> The problem in my hand is to introduce a parameter in the
>> SCHED_DEADLINE policy which will further dynamically change the
>> priority according to the supplied value while the task is submitted.
>
> You do know that SCHED_DEADLINE does not use priorities but _deadlines_,
> right?
>
> care to elaborate a bit?
>
>> I have already simulated and tested my requirement. I am having
>> problem with understanding the hierarchy of scheduler code.
>
> You mean the order of the scheduling policies? If you look at the
> sched_class in the different classes, you'll find the following hierarchy:
>
> stop_sched_class
> dl_sched_class
> rt_sched_class
> fair_sched_class
> idle_sched_class
>
> So, first the scheduler sees if there's any deadline tasks, then -rt and so
> on.
>
> I (we) need a bit more info about what exactly it is you're struggling with
>
>>
>> Thanks in advance
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Henrik Austad
