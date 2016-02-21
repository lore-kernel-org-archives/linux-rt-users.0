From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch]  sched,rt: __always_inline preemptible_lazy()
Date: Sun, 21 Feb 2016 16:11:30 +0100
Message-ID: <1456067490.3771.2.camel@gmail.com>
References: <1453108103.4123.4.camel@gmail.com>
	 <20160118201828.GE12309@linutronix.de> <1453170597.3740.7.camel@gmail.com>
	 <20160121125405.GA11749@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160121125405.GA11749@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

homer: # nm kernel/sched/core.o|grep preemptible_lazy
00000000000000b5 t preemptible_lazy

echo wakeup_rt > current_tracer ==> Welcome to infinity.

Signed-off-bx: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3469,7 +3469,7 @@ static void __sched notrace preempt_sche
  * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
  * preempt_lazy_count counter >0.
  */
-static int preemptible_lazy(void)
+static __always_inline int preemptible_lazy(void)
 {
 	if (test_thread_flag(TIF_NEED_RESCHED))
 		return 1;
