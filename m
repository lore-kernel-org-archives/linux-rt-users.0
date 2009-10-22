From: dino@in.ibm.com
Subject: [patch -rt 00/17] [patch -rt] Sched load balance backport
Date: Thu, 22 Oct 2009 18:07:43 +0530
Message-ID: <20091022123743.506956796@spinlock.in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	John Stultz <johnstul@us.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932160AbZJVMmv@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Problem: The current -rt, 2.6.31.4-rt14, has several load balancing issues.
It can easily be seen with dbench running with the same number of processes
as the number of cpus on a SMP system. The dbench threads are running as
SCHED_OTHER processes. Several threads end up running on the same cpu even
though other cpus are idling. This results in severe throughput regression.

Peter Zijlstra posted several load balance patches meant for mainline a
while ago. The following patch series is a backport of the same to
2.6.31.4-rt14. Peter's original patches can be found at
http://marc.info/?l=linux-kernel&m=125198436208787&w=2

Patches 1 through 14 are backports of the original patches except
patch 10 which has the original code + bug fixes.
Patches 15 - 17 are various relevant fixes that have gone on top
of the original patches.

With these patches, load balancing improves considerably on -rt.
However it does not completely resolve the problem. This is still
under investigation.

This has been stress tested on x86_64 and i686

        -Dinakar


--
