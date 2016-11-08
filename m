From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: [PATCH] sched/rt: Change default setup for RT THROTTLING
Date: Tue, 8 Nov 2016 10:22:01 +0100
Message-ID: <879730f8-3966-7c6d-a581-d46a735a73e9@bristot.me>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
 <20161107133207.4282de69@gandalf.local.home>
 <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
 <20161107144738.4811a5dd@gandalf.local.home>
 <alpine.DEB.2.20.1611071353440.19543@east.gentwo.org>
 <20161107150003.66777b43@gandalf.local.home>
 <1e79f711-95f1-da2f-f572-1ac4329c8be7@bristot.me>
 <20161107151617.486b1b42@gandalf.local.home>
 <c46a03ef-89f5-b0c1-5886-e77266dc9a40@bristot.me>
 <20161107154401.16f0214e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Luca Abeni <luca.abeni@unitn.it>,
        Clark Williams <williams@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107154401.16f0214e@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[ looks good? if so, I will send a v2 patch set including the ]
[ RT_RUNTIME_GREED patch and this one.                         ]

Currently, the option RT_RUNTIME_SHARE is enabled by default. This
option enables the sharing of rt_runtime between CPUs, allowing a CPU to
borrow rt_runtime from another CPU, permitting a real-time task to run
100% of the time on a single CPU. The problem is that this can lead to
the starvation of a non-real-time task pinned to the CPU running the CPU
bound RT workload. One example of non-real-time task pinned to a CPU are
the kworkers. Often kworkers starve on this scenario, causing a system
hang.

This patch changes the default setup for RT THROTTLING, disabling the
RT_RUNTIME_SHARE option while enabling the RT_RUNTIME_GREED option. In
such configuration, real-time tasks will be able to run 100% of the time
in the absence of non-real-time tasks starving in the local CPU.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Cc: Luca Abeni <luca.abeni@unitn.it>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>


diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3bd7a6d..265c0db 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -65,8 +65,8 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 #endif

 SCHED_FEAT(FORCE_SD_OVERLAP, false)
-SCHED_FEAT(RT_RUNTIME_SHARE, true)
-SCHED_FEAT(RT_RUNTIME_GREED, false)
+SCHED_FEAT(RT_RUNTIME_SHARE, false)
+SCHED_FEAT(RT_RUNTIME_GREED, true)
 SCHED_FEAT(LB_MIN, false)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
