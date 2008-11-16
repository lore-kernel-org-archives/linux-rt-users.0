From: Amir Aharon <amira@waves.com>
Subject: RE: config_preempt_RT patch platform support question.
Date: Sun, 16 Nov 2008 08:43:16 -0500
Message-ID: <A58BC43ACBDDA54393A506C9A68AB8B402FB3AF3A5@maxx.waves.com>
References: <A58BC43ACBDDA54393A506C9A68AB8B402F8EB14DD@maxx.waves.com>
 <491BDA3D.8040904@osadl.org>
 <A58BC43ACBDDA54393A506C9A68AB8B402F8EB1784@maxx.waves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: RT-Users <linux-rt-users@vger.kernel.org>
To: Amir Aharon <amira@waves.com>,
	Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from maxx.waves.com ([12.34.136.4]:56200 "EHLO maxx.waves.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbYKPNnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 16 Nov 2008 08:43:14 -0500
In-Reply-To: <A58BC43ACBDDA54393A506C9A68AB8B402F8EB1784@maxx.waves.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten,

Good new - 2.6.24.7-rt21 works perfectly on my Xeon x5482 3.2GHz, could not reproduce any of the kernel panic I had.

Thanks for the tip.
 

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Amir Aharon
Sent: Thursday, November 13, 2008 3:00 PM
To: Carsten Emde
Cc: RT-Users
Subject: RE: config_preempt_RT patch platform support question.

Here is the kernel dump:
[] post_schedule_rt
[] finish_task_switch
[] __schedule
[] check_preempt_curr_rt
[] try_to_wake_up
[] wake_up_process
[] e1000_intr_msi
[] handle_IRQ_event
[] preempt_schedule
[] do_irqd
[] do_irqd
[] kthread
[] kthread
[] kernel_thread_helper

EIP: push_rt_task
 Node: IRQ-217[1433] exited with preempt_count 2


I have got this when I run my app on octa core xeon (Xeon x5482 3.2GHz).

I'll run my app with linux-2.6.24.7-rt21 during the weekend and see where it goes...

Thanks,
Amir.


-----Original Message-----
From: Carsten Emde [mailto:Carsten.Emde@osadl.org] 
Sent: Thursday, November 13, 2008 9:42 AM
To: Amir Aharon
Cc: RT-Users
Subject: Re: config_preempt_RT patch platform support question.

Amir,

> I work on a project which delivers low latency audio streaming via a
> Linux machine. I receive/send audio frames of 4 samples each per
> network frame (raw Ethernet) so I expect to have a network interrupt
> each 90 microseconds. I use Linux 2.6.26.3-rt7 on different
> platforms; unfortunately we encountered problems such as kernel
> panics, depend on the platform running...
The PREEMPT_RT patches for kernel 2.6.26 are still under development.
Please post the various kernel messages you are observing. BTW: The most
recent 2.6.26 patch is 2.6.26.6-rt11.

> My questions are: How can I have more details on the tests which
> where used to evaluate the platform running the config_preempt_RT
> (specifically on networking issues)? Does Intel Q6600 2.4GHz (quad
> core) has been tested? Are there known issues? Does Xeon x5482 3.2GHz
> (x2 meaning octa core) has been tested? Are there known issues?
For the time being, linux-2.6.24.7-rt21 is believed to be stable and
ready for production. This version has been tested heavily under x86
(slow/fast machines, single/dual/quad core, 32/64 bit) and under various
PPC platforms. It has been tested less heavily on ARMs and MIPSes. There
are no known issues on x86 platforms. Would you mind to run
2.6.24.7-rt21 on your machines?

	Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
