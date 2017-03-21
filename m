From: Julia Cartwright <julia@ni.com>
Subject: [PATCH v2 1/9] Coccinelle: locks: identify callers of
	spin_lock{, _irq, _irqsave}() in irqchip implementations
Date: Tue, 21 Mar 2017 17:43:01 -0500
Message-ID: <48a11ad61edb4bec130f2ae0d46fc4e7d4855044.1490135047.git.julia@ni.com>
References: <cover.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>,
        cocci@systeme.lip6.fr,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>
Return-path: <cocci-bounces@systeme.lip6.fr>
In-Reply-To: <cover.1490135047.git.julia@ni.com>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr
List-Id: linux-rt-users.vger.kernel.org

On PREEMPT_RT, the spinlock_t type becomes an object which sleeps under
contention.  The codepaths used to support scheduling (irq dispatching, arch
code, the scheduler, timers) therefore must make use of the
raw_spin_lock{,_irq,_irqsave}() variations which preserve the non-sleeping
spinlock behavior.

Because the irq_chip callbacks are invoked in the process of interrupt
dispatch, they cannot therefore make use of spin_lock_t type.  Instead, the
usage of raw_spinlock_t is appropriate.

Provide a spatch to identify (and attempt to patch) such problematic irqchip
implementations.

Note to those generating patches using this spatch; in order to maintain
correct semantics w/ PREEMPT_RT, it is necessary to audit the
raw_spinlock_t-protected codepaths to ensure their execution is bounded and
minimal.  This is a manual audit process.

See commit 47b03ca903fb0 ("pinctrl: qcom: Use raw spinlock variants") as an
example of _one_ such instance, which fixed a real bug seen in the field.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
v1 -> v2:
  - Make use of 'exists' on match to find any codepath which acquires a lock. (via Julia Lawall)
  - Use 'when any' on '...' matches to loosen constraint (via Julia Lawall).

 .../coccinelle/locks/irq_chip_raw_spinlock.cocci   | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 scripts/coccinelle/locks/irq_chip_raw_spinlock.cocci

diff --git a/scripts/coccinelle/locks/irq_chip_raw_spinlock.cocci b/scripts/coccinelle/locks/irq_chip_raw_spinlock.cocci
new file mode 100644
index 000000000000..0294831297d3
--- /dev/null
+++ b/scripts/coccinelle/locks/irq_chip_raw_spinlock.cocci
@@ -0,0 +1,96 @@
+// Copyright: (C) 2017 National Instruments Corp. GPLv2.
+// Author: Julia Cartwright <julia@ni.com>
+//
+// Identify callers of non-raw spinlock_t functions in hardirq irq_chip
+// callbacks.
+//
+// spin_lock{_irq,_irqsave}(), w/ PREEMPT_RT are "sleeping" spinlocks, and so
+// therefore "sleep" under contention; identify (and potentially patch) callers
+// to use raw_spinlock_t instead.
+//
+// Confidence: Moderate
+
+virtual report
+virtual patch
+
+@match@
+identifier __irqchip;
+identifier __irq_mask;
+@@
+	static struct irq_chip __irqchip = {
+		.irq_mask	= __irq_mask,
+	};
+
+@match2 depends on match exists@
+identifier match.__irq_mask;
+identifier data;
+identifier x;
+identifier l;
+type T;
+position j0;
+expression flags;
+@@
+	static void __irq_mask(struct irq_data *data)
+	{
+		... when any
+		T *x;
+		... when any
+(
+		spin_lock_irqsave(&x->l@j0, flags);
+|
+		spin_lock_irq(&x->l@j0);
+|
+		spin_lock(&x->l@j0);
+)
+		... when any
+	}
+
+@match3 depends on match2 && patch@
+type match2.T;
+identifier match2.l;
+@@
+	T {
+		...
+-		spinlock_t	l;
++		raw_spinlock_t	l;
+		...
+	};
+
+@match4 depends on match2 && patch@
+type match2.T;
+identifier match2.l;
+expression flags;
+T *x;
+@@
+
+(
+-spin_lock(&x->l)
++raw_spin_lock(&x->l)
+|
+-spin_lock_irqsave(&x->l, flags)
++raw_spin_lock_irqsave(&x->l, flags)
+|
+-spin_lock_irq(&x->l)
++raw_spin_lock_irq(&x->l)
+|
+-spin_unlock(&x->l)
++raw_spin_unlock(&x->l)
+|
+-spin_unlock_irq(&x->l)
++raw_spin_unlock_irq(&x->l)
+|
+-spin_unlock_irqrestore(&x->l, flags)
++raw_spin_unlock_irqrestore(&x->l, flags)
+|
+-spin_lock_init(&x->l)
++raw_spin_lock_init(&x->l)
+)
+
+@script:python wat depends on match2 && report@
+j0 << match2.j0;
+t << match2.T;
+l << match2.l;
+@@
+
+msg = "Use of non-raw spinlock is illegal in this context (%s::%s)" % (t, l)
+coccilib.report.print_report(j0[0], msg)
-- 
2.12.0
