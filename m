From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch -rt 0/2] use simple waitqueue for kvm vcpu waitqueue (v5)
Date: Wed, 08 Apr 2015 20:33:23 -0300
Message-ID: <20150408233323.842124241@redhat.com>
Cc: Rik van Riel <riel@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org, kvm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51808 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932AbbDHXfL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Apr 2015 19:35:11 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian,

rebased against v3.18.7-rt2 as requested.

The problem:

On -RT, an emulated LAPIC timer instance has the following path:

1) hard interrupt
2) ksoftirqd is scheduled
3) ksoftirqd wakes up vcpu thread
4) vcpu thread is scheduled

This extra context switch introduces unnecessary latency in the
LAPIC path for a KVM guest.

The solution:

Allow waking up vcpu thread from hardirq context,
thus avoiding the need for ksoftirqd to be scheduled.

Normal waitqueues make use of spinlocks, which on -RT
are sleepable locks. Therefore, waking up a waitqueue
waiter involves locking a sleeping lock, which
is not allowed from hard interrupt context.

cyclictest command line:
# cyclictest -m -n -q -p99 -l 1000000 -h60  -D 1m

This patch reduces the average latency in my tests from 14us to 11us.

v2: improve changelog (Rik van Riel)
v3: limit (once) guest triggered printk and WARN_ON (Paolo Bonzini)
v4: fix typo (Steven Rostedt)
v5: rebase against v3.18.7-rt2.



