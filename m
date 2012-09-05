From: Darren Hart <dvhart@linux.intel.com>
Subject: Pthread Condition Variables and Priority Inversion
Date: Wed, 05 Sep 2012 16:17:37 -0700
Message-ID: <5047DD91.3030402@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12777 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab2IEXSK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2012 19:18:10 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Michael,

I've tried many times over the last several years to get proper priority
inheritance support for pthread condition variables added to glibc.
Unfortunately, I haven't convinced the powers that be to incorporate the
proposed fixes. Since the failure scenario involves an opaque type and
is rather non-intuitive, it was suggested (thanks Frank) that I attempt
to at least document the behavior. The goal is to discourage the use of
condition variables in real-time applications as they have the potential
for catastrophic system failure which could lead to loss of life - at
least until such time as support is incorporated into the C library.

I understand PTHREAD_COND_TIMEDWAIT(3P) is not Linux specific. I wonder
if you could recommend an appropriate document for the following blurb:

While the Linux kernel, since 2.6.31, supports requeueing of
priority-inheritance (PI) aware mutexes via the FUTEX_WAIT_REQUEUE_PI
and FUTEX_CMP_REQUEUE_PI futex operations, the glibc implementation does
not yet take full advantage of this. Specifically, the condvar internal
data lock remains a non-PI aware mutex, regardless of the type of the
pthread_mutex associated with the condvar. This can lead to an unbounded
priority inversion on the internal data lock even when associating a PI
aware pthread_mutex with a condvar during a pthread_cond*_wait
operation. For this reason, it is not recommended to rely on priority
inheritance when using pthread condition variables.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
