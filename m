From: Remy Bohmer <linux@bohmer.net>
Subject: Re: hardirq ->tasklet ->usermode vs softirq -> usermode
Date: Mon, 8 Aug 2011 20:46:03 +0200
Message-ID: <CANqCtQJSt5beA369e_H+ZiC_K6AKv2o8_aLJHV2XZNUq+e_wdA@mail.gmail.com>
References: <201108081809.38521.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54773 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab1HHSqF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Aug 2011 14:46:05 -0400
Received: by fxh19 with SMTP id 19so5641997fxh.19
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Aug 2011 11:46:04 -0700 (PDT)
In-Reply-To: <201108081809.38521.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2011/8/8 Tim Sander <tim.sander@hbm.com>:
> Hi
>
> I am currently evaluating the RT Kernel. We are running a interrupt with
> 9.6khz on an arm1136jfs (pcm043) with 533Mhz. When using an softirq
> we are missing interrupts since the scheduler fails to schedule the softirq in
> time :-(.
>
> So i implemented an hardiq which then schedules an tasklet and then triggers
> usermode with an adjustable wakeup divider. The solution with the tasklet
> seems to be even slower than the softirqs from the kernel and the load makes
> the system so slow that it's a pain working on it.

Not surprised ;-)

> So my question is: is there a more efficient way than a tasklet?

Waking up the thread directly from the hardirq could be an option.

Globally you can declare:
struct task_struct      *wake_me_up;

In the thread, you can do this:
1.  set_current_state(TASK_INTERRUPTIBLE);
2. wake_me_up = current;
3. schedule();
4. wake_me_up = NULL;

In the hardirq you can do something like:
if (wake_me_up)
      wake_up_process(wake_me_up);

Of course with the proper locking where needed. (Just meant as pseudo
code, lots of examples can be found in the kernel.

> When comparing the 3.0 vs 3.0-rt7 i can make the general observations:
> * the load seems to be at least twice as high.
> * usermode seems to be scheduled at 2.4khz which is nice.
> * the softirq looses some interrupts at a rate of 9.6khz.

9.6 kHz sounds a lot.
This means about every 100usec an interrupt, the interrupt handler
takes some time and scheduling as well. (I have seen that it can take
up to 50usec to handle an interrupt on some cores.), schedule a thread
and even do some work in userspace...
You should measure (scope or ETM) what time it takes to wake up a
thread from hardirq context on your core.

Kind regards,

Remy
