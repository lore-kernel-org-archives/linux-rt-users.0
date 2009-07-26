From: Sbs <sbs.pub@gmail.com>
Subject: Re: Doubt: Does RT patch reduce interrupt latency?
Date: Sun, 26 Jul 2009 11:58:19 +0530
Message-ID: <4cd511390907252328h4d82225cy2ae02d230fddbe61@mail.gmail.com>
References: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
	 <4A6A30B2.5070709@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:52558 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbZGZG2T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2009 02:28:19 -0400
Received: by pxi14 with SMTP id 14so971651pxi.33
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Jul 2009 23:28:19 -0700 (PDT)
In-Reply-To: <4A6A30B2.5070709@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> As I understand it, if you are doing your processing via interrupts, =
the
> your latency to start processing interrupts will increase on average =
with
> the PREEMPT_RT patch. =A0There is additional scheduling overhead invo=
lved, and
> as Sven pointed out, if you don't bump the prio of the interrupt you =
care
> about, you can see MUCH higher latencies.
>
> The PREEMPT_RT patch adds things like the rt-mutex replacement of mos=
t
> spinlocks, which adds preemption points and enable Priority Inheritan=
ce
> within the kernel, but this is all geared towards enable real-time
> applications. =A0If you just want fast OS processing of interrupts, t=
hen
> mainline provides you with a nice non-preemptible kernel side interru=
pt
> implementation that won't be affected by things like applications :-)

Thank you for this clarification. This really made me think. In
mainline kernel, my interrupt will not be affected by other processes.
But, it can be affected by other interrupts in the system, right? So,
I still gain something from rt patch where I can scale down the
priority of other interrupts so that they don't come in the way of my
1 ms interrupt.

Now, if I got it correct, what I will have to see is whether this
advantage outweighs the disadvantage of context switching delays. A
quick search showed me http://choices.cs.uiuc.edu/ExpCS07.pdf. In page
25 they have listed time for context switches and interrupts. Those
figures are rather dismal (~few milli seconds). Can someone familiar
with ARM here tell me whether these numbers can be trusted? From the
rt wiki I see that, on ARM, worst case latency is less than 300us. I
will anyway repeat the tests that we did so far and will post the
results again.

@Sven: Just saw your reply. Thank you for the caution about nested
PICs. I will check this also while repeating the tests.

> Please slap me if I've misrepresented PREEMPT_RT somehow. (I'm sure n=
o
> invitation is actually required ;-)

Since no one has done this so far, I trust you :)

>
>
> --
> Darren Hart
> IBM Linux Technology Center
> Real-Time Linux Team
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
