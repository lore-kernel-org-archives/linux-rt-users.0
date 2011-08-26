From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] PREEMPT_RT_FULL Build error fix
Date: Fri, 26 Aug 2011 14:06:33 +0200
Message-ID: <1314360393-13605-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	lkml <linux-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Problem:
make O=3D/bld/3.0.3-rt11/ kernel/fork.o
/home/jkacur/jk-2.6/kernel/fork.c:91: error: section of =E2=80=98name=E2=
=80=99 conflicts with previous declaration

__cacheline_aligned is already part of the definition of DEFINE_RWLOCK
for -rt

However it is not always used for the tasklist_lock in non-rt, so it ca=
n't
simply be added to the definition of DEFINE_RWLOCK in non-rt, so I modi=
fied
the definition in fork.c

Signed-off-by: John Kacur
---
 kernel/fork.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index aa5fe26..0d264ec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -87,7 +87,11 @@ int max_threads;		/* tunable limit on nr_threads */
=20
 DEFINE_PER_CPU(unsigned long, process_counts) =3D 0;
=20
+#ifndef CONFIG_PREEMPT_RT_FULL
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
+#else
+DEFINE_RWLOCK(tasklist_lock);  /* outer */
+#endif
=20
 #ifdef CONFIG_PROVE_RCU
 int lockdep_tasklist_lock_is_held(void)
--=20
1.7.2.3
