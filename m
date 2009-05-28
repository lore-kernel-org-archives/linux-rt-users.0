From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Real-Time & Determinism
Date: Wed, 27 May 2009 21:21:39 -0400
Message-ID: <75b66ecd0905271821q110b52dbq186242a3738d98a3@mail.gmail.com>
References: <4A17F444.6070005@free.fr>
	 <c384c5ea0905230609q5cce9b01ya2004b312b98b1e1@mail.gmail.com>
	 <4A180113.8030203@free.fr> <20090526232202.GC7006@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Nourry <nourry@free.fr>,
	Leon Woestenberg <leon.woestenberg@gmail.com>,
	linux-rt-users@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:36263 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbZE1BVi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2009 21:21:38 -0400
Received: by ewy24 with SMTP id 24so4842941ewy.37
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2009 18:21:39 -0700 (PDT)
In-Reply-To: <20090526232202.GC7006@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 26, 2009 at 7:22 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> In theory, one could analyze the Linux kernel to identify the longest
> section of code running with preemption disabled, but as far as I kno=
w
> this has not yet been done.
>
> So if you need a mathematical proof that your real-time OS will respo=
nd
> within a bounded time, then RT Linux might not be the right tool for
> your job. =A0But a surprisingly large number of RT applications do no=
t
> need that level of assurance.
>
> And I would not be surprised to hear that someone decided to bite the
> bullet and actually mechanically analyze the Linux source/binary for
> maximum latency. =A0;-)

Hi Antoine,

Keep in mind also that in -rt the non-preemptible sections are a very
small subset of the kernel code - last time I checked it was just the
timer ISR, the scheduler's SCHED_FIFO code, and the stub ISRs for the
other interrupts.  The rest does not need to be audited for
determinism.

Of course, for "total determinism" you also have to mathematically
prove the hardware behaves as expected...

Lee
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
