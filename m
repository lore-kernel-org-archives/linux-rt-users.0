From: "Robert de Vries" <robert.h.de.vries@gmail.com>
Subject: Re: How to dedicate a CPU for real time applications?
Date: Fri, 20 Apr 2007 15:17:45 +0200
Message-ID: <47db5b910704200617h5757cb12p755c85c0996d0a9e@mail.gmail.com>
References: <46281FC8.2000209@l1nuxh4ck3r.de>
	 <47db5b910704200209j311ecc16r1967739eec7810b4@mail.gmail.com>
	 <4628A76A.1050403@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Bernhard Kuhn" <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:38430 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767091AbXDTNRr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 09:17:47 -0400
Received: by nz-out-0506.google.com with SMTP id s1so742532nze
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Apr 2007 06:17:46 -0700 (PDT)
In-Reply-To: <4628A76A.1050403@l1nuxh4ck3r.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 4/20/07, Bernhard Kuhn <kuhn@l1nuxh4ck3r.de> wrote:
> Robert de Vries wrote:
>
> > Beware that the mask is not updated immediately. It is updated the
> > next time an interrupt is serviced. This may take a long time if there
> > are only a few interrupts sent or none.
>
> Thanks! This was the missing link: this matched my
> observation that only those interrupts don't change
> their cpumask that are not activly in use. And for
> seldomly used interrupts, the cpumask change occurs
> delayed. Is there a special reason why the affinity
> doesn't change immediately?

That is a good question. And I didn't dig deep enough in the interrupt
management code to provide you with an answer.
>
>
> > I'll write something up about this in the Real-Time Linux Wiki.
> > On a related note: I am working on a user space library to make it
> > easy to do CPU shielding of other processes (what you do with
> > isolcpus=1, but then dynamic)
>
> That would be cool :-)
>
>
>  > using the cpuset feature of the kernel.
>
> Hopefully, cpusets avoid the problem as side-noted
> the "isocpus" parameter in Documentation/kernel-parameters.txt
>
> ---- 8< ----
> This option is the preferred way to isolate CPUs. The
> alternative -- manually setting the CPU mask of all
> tasks in the system -- can cause problems and
> suboptimal load balancer performance
> ---- >8 ----

>From what I can see in the kernel source code, the two mechanisms use
the same underlying mechanism. So I guess you can use either method.
The only difference is that using cpusets, you can do it dynamically
as opposed to doing it statically.

>
> > I have only just begun to develop this library so only the very basic
> > features are implemented.
> >
> > Let me know if someone is interested in using it.
>
> This certainly sounds interesting! However, i intend to try out
> how well hrtimers behave on a dedicated CPU on kernel level.
> I have attached a small hrtimers demo with a callback function
> running in interrupt context. I can imagine that pretty much
> all data and code involved fits into L2 cache and not more pages
> then TLB-entries are used. This would heavily increase determinism.
> BTW.: what a pity that x86 doesn't has cacheline-locking
> instructions (such as PowerPC) - then all interrupt related data
> and code could be marked with i.e. "__irq" and moved to a separate
> sections that are cache-locked upon startup.

My test program is a complete real-time simulator infrastructure. I
have been running now for 80 minutes now with heavy disk I/O in the
background. I have measured a maximum jitter of 55 microseconds. Most
jitters are around 5 microseconds. I'm pretty happy, but I have to do
some more experiments to determine the best configuration. So far it
looks almost good enough for my purposes. I prefer to be below 50
microseconds really.

     Robert
