From: John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] linux-2.6.31-rc5-rt1.2
Date: Wed, 12 Aug 2009 20:56:09 +0200
Message-ID: <20090812185609.GA11568@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52849 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbZHLS5I (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2009 14:57:08 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


We are pleased to present, another non-official -rt tree.

linux-2.6.31-rc5-rt1.2

This is an incremental release based on the work of Thomas Gleixner and=
 other -rt developers.

The goal once again is to prevent the official -rt version from develop=
ing bit rot while
Thomas and others work on new -rt development.

It will allow you to exercise many of the patches submitted by -rt deve=
lopers
before they appear in the official branch.

It starts with linux-2.6.31-rc5-rt1.1 (which is a rebase of linux-2.6.3=
1-rc4-rt1)
and adds the following patches

- Thomas Gleixner: Fix PREEMPT=3Dy, LOCKBREAK=3Dy, DEBUG_LOCK_ALLOC=3Dn=
 compile
- Dinakar Guniguntala: fix compat_futex to be same as futex for REQUEUE=
_PI
- Darren Hart - futex fixes:
	- Update futex_q lock_ptr on requeue proxy lock
	- Fix handling of bad requeue syscall pairing
	- Avoid deadlock in rt_mutex_start_proxy_lock()
- Uwe Kleine-K=F6nig: Various compile fixes for ARM
	- Add missing includes
	- Convert semaphore to mutex sound/soc/s3c24xx/s3c2443-ac97.c
	- ixp2000: fix type of ixp2000_timer_interrupt
	- Use atomic_spin_lock/atomic_spin_unlock for irqdesc lock
- Kevin Hilman: watchdog: davinci: use clock framework for timer freque=
ncy
- Clark Williams: Changed boot warning to look for CONFIG_FUNCTION &&
 !CONFIG_DYNAMIC_FTRACE

You can download it at the following locations:

Git location: git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/r=
t-linux.git
Git branch: linux-2.6.31-rc5-rt1.2

Or in patch form
http://www.kernel.org/pub/linux/kernel/people/clrkwllms/rt-unofficial/p=
atch-2.6.31-rc5-rt1.2.bz2

Please send your success and bug reports to
LKML <linux-kernel@vger.kernel.org> and rt-users <linux-rt-users@vger.k=
ernel.org>

Thanks once again to all of the -rt developers who participated in the =
discussions on the list and to
Thomas Gleixner, Dinakar Guniguntala, Darren Hart, Uwe Kleine-K=F6nig, =
Kevin Hilman, and Clark Williams whose
patches I incorporated into this tree.

Enjoy!

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
