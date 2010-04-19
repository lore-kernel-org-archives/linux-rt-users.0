From: Primiano Tucci <p.tucci@gmail.com>
Subject: Re: Strange behavior of pthread_setaffinity_np
Date: Mon, 19 Apr 2010 22:18:56 +0200
Message-ID: <p2mc5b2c05b1004191318u59896234n3a7d5383fa67fe5a@mail.gmail.com>
References: <z2hc5b2c05b1004190245od92c276n6933d75f9d4d2669@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48371 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab0DSUS6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Apr 2010 16:18:58 -0400
Received: by wyb39 with SMTP id 39so2816435wyb.19
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Apr 2010 13:18:56 -0700 (PDT)
In-Reply-To: <z2hc5b2c05b1004190245od92c276n6933d75f9d4d2669@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I think I solved the question:
pthread_setaffinity_np is based on sched_setaffinity syscall.
Actually sched_setaffinity performs a read_lock(&tasklist_lock);
However, with the introduction of the PREEMPT_RT patch, the read_lock
is preemptible, thats why the Thread T0 Yields in favor of T2.

I think the sched.c should be revised regarding the PREEMPT_RT patch,
and the scheduling related syscalls should adopt non pre-emptible
(e.g. raw_spinlock_t) spinlocks rather than preemptible one, in order
to avoid unwilling behaviors like the one showed.

Regards,
Primiano


On Mon, Apr 19, 2010 at 11:45 AM, Primiano Tucci <p.tucci@gmail.com> wr=
ote:
> Hi all,
> I am an Italian researcher and I am working on a Real Time scheduling
> infrastructure. I am currently using Linux Kernel 2.6.29.6-rt24-smp
> (PREEMPT-RT Patch) running on a Intel Q9550 CPU.
> I am experiencing strange behaviors with the pthread_setaffinity_np A=
PI.
>
> This is my scenario, I have 4 Real Time Threads (SCHED_FIFO)
> distributed as follows:
>
> T0 : CPU 0, Priority 2 (HIGH)
> T1 : CPU 1, Priority 2 (HIGH)
> T3 : CPU 0, Priority 1 (LOW)
> T4 : CPU 1, Priority 1 (LOW)
>
> So T0 and T1 are actually the "big bosses" on CPUs #0 and #1, T3 and
> T4, instead, never execute (let's assume that each thread is a simple
> busy wait that never sleeps/yields)
> Now, at a certain point, from T0 code, I want to migrate T4 from CPU
> #1 to #0, keeping its low priority.
> Therefore I perform a pthread_setaffinity_np from T0 changing T4 mask
> from CPU #1 to #0.
>
> In this scenario it happens that T3 (that should never execute since
> there is T0 with higher priority currently running on the same CPU #0=
)
> "emerge" and executes for a bit.
> It seems that the pthread_setaffinity_np syscall is somehow
> "suspensive" for the time needed to migrate T4 and let the scheduler
> to execute T3 for that bunch of time.
>
> Is this behavior expected (I did not find any documentation about
> this)? How can avoid it?
>
> Thanks in advance,
> Primiano
>
> --
> =A0Primiano Tucci
> =A0http://www.primianotucci.com
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
