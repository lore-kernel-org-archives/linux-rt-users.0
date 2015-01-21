From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch -rt 0/2] use simple waitqueue for kvm vcpu waitqueue (v4)
Date: Wed, 21 Jan 2015 18:36:00 -0200
Message-ID: <20150121203600.745949083@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Steven Rostedt <srostedt@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Against v3.14-rt branch of
git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

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
