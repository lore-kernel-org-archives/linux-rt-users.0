From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: deterministic usage of JIFFIES and how to relocate the clock
Date: Thu, 4 Feb 2016 17:44:11 +0100
Message-ID: <20160204164411.GC3381@linutronix.de>
References: <CA+Owze7GnFYrpVMWSuPd=qXj8auf3fL-mPsZNPVMeP=FQtZsPg@mail.gmail.com>
 <CA+Owze7+=vMDaqX25OVQ6ZrRgGj9j2BZjEZt_GyG+9+6+6ELWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: jkraehemann-guest@users.alioth.debian.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39827 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbcBDQoN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Feb 2016 11:44:13 -0500
Content-Disposition: inline
In-Reply-To: <CA+Owze7+=vMDaqX25OVQ6ZrRgGj9j2BZjEZt_GyG+9+6+6ELWA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Jo=C3=ABl Kr=C3=A4hemann | 2016-01-24 09:40:33 [+0100]:

>Hi
Hi,

>At my opinion I was thinking at a lower level than needed. The
I couldn't parse the question in the previous mail.

>application runs at least aside the kernel.

aside the kernel? Like one CPU is for the kernel and the other for the
application?

>Probably I want to control PC (program counter) and redeclare the
>longjump function as macro. To gain control
>over throughput rate and thus being able to grain loading and unloadin=
g thread.

maybe. But I still fail to understand what you attempt to do.

>int sched_setaffinity(pid_t pid, size_t cpusetsize,
>                             const cpu_set_t *mask);

This one says which CPUs the task may run on.

>void longjmp(jmp_buf env, int val);

and this is unrelated to the previous one.

>
>cheers,
>Jo=C3=ABl

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
