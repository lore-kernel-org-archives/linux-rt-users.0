From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.0.4-rt1
Date: Tue, 19 May 2015 23:39:23 +0200
Message-ID: <20150519213923.GA26363@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.0.4-rt1 patch set.

Changes since v3.18.13-rt10

- Rebase to v4.0.

- David Hildenbrand's series of decouple of preempt_disable from
  pagefault_disable is part of the series.

While doing the v4.0 I stumbled upon a few things. Therefore I plan to
reorder the -RT queue and merge patches where possible. Also I intend t=
o
drop PREEMPT_RTB and PREEMPT_RT_BASE unless there is need for it=E2=80=A6

Known issues:

      - My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
        policy found" warnings after boot. It is gone after manually
        setting the policy (to something else than reported).

      - bcache is disabled.

      - CPU hotplug works in general. Steven's test script however
        deadlocks usually on the second invocation.

      - xor / raid_pq
        I had max latency jumping up to 67563us on one CPU while the ne=
xt
        lower max was 58us. I tracked it down to module's init code of
        xor and raid_pq. Both disable preemption while measuring the
        performance of the individual implementation.

The RT patch against 4.0.4 can be found here:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patch-4.0.4-=
rt1.patch.xz

The split quilt queue is available at:

   https://www.kernel.org/pub/linux/kernel/projects/rt/4.0/patches-4.0.=
4-rt1.tar.xz

Sebastian
