From: "Uli Brueggemann" <uli.brueggemann@gmail.com>
Subject: Re: 2.6.25.4-rt6
Date: Mon, 9 Jun 2008 10:13:43 +0200
Message-ID: <10a58eee0806090113j643e058bm1da6c8a5bfbc1701@mail.gmail.com>
References: <1212793171.7695.2.camel@localhost.localdomain>
	 <484CDDEC.7050405@netone.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: "Tarkan Erimer" <tarkan@netone.net.tr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:11597 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbYFIINo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jun 2008 04:13:44 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1728284waf.23
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Jun 2008 01:13:43 -0700 (PDT)
In-Reply-To: <484CDDEC.7050405@netone.net.tr>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jun 9, 2008 at 9:38 AM, Tarkan Erimer <tarkan@netone.net.tr> wrote:
>
> I got this error message at compile stage. Also it is the same error that was on -rt4. -rt3 compiles and runs fine.
>
>
> VDSOSYM arch/x86/vdso/vdso32-syms.lds
> LD arch/x86/vdso/built-in.o
> CC kernel/sched.o
> kernel/sched.c: In function 'sched_init':
> kernel/sched.c:7702: error: implicit declaration of function 'global_rt_runtime'
> make[2]: *** [kernel/sched.o] Error 1
> make[1]: *** [kernel] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.25.4'
> make: *** [debian/stamp-build-kernel] Error 2
> root@tarkane:/usr/src/linux-2.6.25.4#
>



I got the same message but following previously sent patch works for me:

-------- Original Message --------

Subject: about 2.6.25.4-rt5 (missing global_rt_runtime)
Date: Thu, 05 Jun 2008 12:18:49 +0000
From: ciaby <ciaby@autistici.org>
To: rostedt@goodmis.org

Small patch to make it compile (missing global_rt_runtime function):

diff -uNr linux-2.6.25.4.orig/kernel
/sched.c linux-2.6.25.4/kernel/sched.c

--- linux-2.6.25.4.orig/kernel/sched.c  2008-06-05 14:12:30.000000000 +0200
+++ linux-2.6.25.4/kernel/sched.c       2008-06-05 13:58:48.000000000 +0200

@@ -671,6 +671,15 @@

 */
  #define RUNTIME_INF    ((u64)~0ULL)

+static u64 global_rt_runtime(void)
+{
+       if (sysctl_sched_rt_period < 0)
+               return RUNTIME_INF;
+       return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
+}
+
+
+
/*
 * We really dont want to do anything complex within switch_to()
 * on PREEMPT_RT - this check enforces this.
