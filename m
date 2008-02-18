From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: sched_yield() needed for pthread_cond_signal(..) to work?
Date: Mon, 18 Feb 2008 15:25:04 -0300
Message-ID: <20080218182504.GC31432@unix.sh>
References: <2accc2ff0802181016q26eb8b8cm88f45a0162ae21a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9s_Calder=F3n?= <andres.calderon@emqbit.com>
To: Nelson Castillo <nelsoneci@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sr03-03.mta.terra.com.br ([200.154.152.42]:52652 "EHLO
	sr03-03.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbYBRSZK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Feb 2008 13:25:10 -0500
Content-Disposition: inline
In-Reply-To: <2accc2ff0802181016q26eb8b8cm88f45a0162ae21a0@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

RT + sched_yield() are not really good friends... sched_yield() messes the
work of the scheduler. Along with it, sched_tield() behaves in a different
way under CFS. To get the old behavior you have to:

	echo 1 > /proc/sys/kernel/sched_compat_yield

Luis

On Mon, Feb 18, 2008 at 01:16:16PM -0500, Nelson Castillo wrote:
| Hi.
| 
| I'm using 2.6.23.14-rt14 on a i586  and I'm quite happy with the
| current results [1].
| I'm writing because I have a problem with a source code that I thought
| should work.
| 
|   http://svn.arhuaco.org/svn/src/junk/trunk/threads/cond-signal-test.c
| 
| In a PC (Debian 2.6.24 686 with no RT patches) it prints 1000. In the
| realtime system it prints 1 or 0.
| 
| # ./a.out
| 1
| # ./a.out
| 0
| # ./a.out
| 1
| 
| If I do a sched_yield() right after releasing the mutex associated with
| the condition, the program prints 1000 as expected.
| 
| void
| dosignal (void)
| {
|   pthread_mutex_lock (&cond_mutex);
|   pthread_cond_signal(&cond);
|   pthread_mutex_unlock (&cond_mutex);
|    sched_yield(); //  without this I get 0! with Linux and RT patches
| }
| 
| 
| So my questions are:
| 
| * I am missing something?
| * If sched_yield() is the way to go, is it SMP safe?
| 
| I did pthread_mutexattr_setprotocol(&mutex_attr, PTHREAD_PRIO_INHERIT)
| and the syscall succedded but I still got 0 or 1. I think it doesn't
| matter in this case.
| 
| Best regards,
| Nelson.-
| 
| [1] http://wiki.freaks-unidos.net/weblogs/arhuaco/preempt_rt-test
| 
| PS:
| 
| I've tried this with Debian's GLIBC and with Openembedded.
| 
| Debian:
| 
| /lib/libc.so.6
| GNU C Library stable release version 2.7, by Roland McGrath et al.
| Copyright (C) 2007 Free Software Foundation, Inc.
| This is free software; see the source for copying conditions.
| There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
| PARTICULAR PURPOSE.
| Compiled by GNU CC version 4.2.3 20080102 (prerelease) (Debian 4.2.2-5).
| Compiled on a Linux >>2.6.22.12<< system on 2008-01-12.
| Available extensions:
|         crypt add-on version 2.1 by Michael Glad and others
|         GNU Libidn by Simon Josefsson
|         Native POSIX Threads Library by Ulrich Drepper et al
|         BIND-8.2.3-T5B
| For bug reporting instructions, please see:
| <http://www.gnu.org/software/libc/bugs.html>.
| 
| OpenEmbedded:
| 
| GNU C Library stable release version 2.5, by Roland McGrath et al.
| Copyright (C) 2006 Free Software Foundation, Inc.
| This is free software; see the source for copying conditions.
| There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
| PARTICULAR PURPOSE.
| Compiled by GNU CC version 4.1.2.
| Compiled on a Linux >>2.6.22-3-686<< system on 2008-01-09.
| Available extensions:
| 	crypt add-on version 2.1 by Michael Glad and others
| 	GNU libio by Per Bothner
| 	NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
| 	Native POSIX Threads Library by Ulrich Drepper et al
| 	BIND-8.2.3-T5B
| Thread-local storage support included.
| For bug reporting instructions, please see:
| <http://www.gnu.org/software/libc/bugs.html>
| 
| -- 
| http://arhuaco.org
| -
| To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]
