From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.1.3-rt10][RFC PATCH] clk: use raw locks for locking
Date: Tue, 20 Oct 2015 23:59:19 +0300
Message-ID: <1445374759-26785-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sekhar Nori <nsekhar@ti.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>,
	<linux@arm.linux.org.uk>, <linux-rt-users@vger.kernel.org>,
	<balbi@ti.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Mike, All,

[not for merge]

As we discussed I've prepared patch which introduces config option
COMMON_CLK_USE_RAW_LOCKS which, once enabled, switches CCF to use raw l=
ocks
for locking=E2=80=8B. This way it will be possible to call clk_enable()=
/clk_disable()
from atomic context on -RT [1].
Unfortunately (and as expected [2]), if COMMON_CLK_USE_RAW_LOCKS is ene=
bled
it starts raising issues with TI's clock drivers (and this is like a av=
alanche):
- some TI drivers calls platform specific code which, in turn, uses spi=
nlocks;
- one driver is implemented using MMIO regmap which uses spinlocks.

As result, to get a complete solution I've had to make more patches:
 regmap: use raw locks for locking
 ARM: OMAP2+: powerdomain: use raw locks for locking
 clk: ti: drop locking code from mux/divider drivers
 clk: use raw locks for locking

This solution requires the use of raw locks in many places of kernel,
and it's bad for the -RT. For example, regmap is used by only one TI's =
clock,
but after switching to use raw locks it will affect also on all drivers=
 which
use 'syscon'.=20

So, it seems that in many cases it might be more simple to just move
clk_enable()/clk_disable() calls out of atomic context :)

=46YI: Complete set of patches (based on v4.1.10-rt10) can be found at:
- git@git.ti.com:~gragst/ti-linux-kernel/gragsts-ti-linux-kernel.git
- branch: linux-4.1.y-rt-10-clk-raw-lock

[1] http://marc.info/?l=3Dlinux-rt-users&m=3D143937432529680&w=3D2
[2] http://marc.info/?l=3Dlinux-rt-users&m=3D144284086804316&w=3D2

---------------------------------------------------------------------
This patch optionally allows CCF core to use raw locks in clk_enable()/
clk_disable() path. Also, convert generic clock drivers in
the similar way (clk-divider, clk-fractional-divider,
clk-gate, clk-mux).

This patch introduces Kconfig option COMMON_CLK_USE_RAW_LOCKS.
Once enabled, COMMON_CLK_USE_RAW_LOCKS will switch the common clock
framework to use raw locks for locking and, this way, makes it
possible to call clk_enable()/clk_disable() from atomic context.

This fixes backtrace like:
BUG: sleeping function called from invalid context at kernel/locking/rt=
mutex.c:917
in_atomic(): 1, irqs_disabled(): 128, pid: 128, name: sh
4 locks held by sh/128:
 #0:  (sb_writers#4){.+.+.+}, at: [<c019d44c>] vfs_write+0x13c/0x164
 #1:  (&of->mutex){+.+.+.}, at: [<c0214bbc>] kernfs_fop_write+0x48/0x19=
c
 #2:  (s_active#33){.+.+.+}, at: [<c0214bc4>] kernfs_fop_write+0x50/0x1=
9c
 #3:  (&bank->lock){......}, at: [<c0405424>] omap_gpio_debounce+0x1c/0=
x120
irq event stamp: 3532
hardirqs last  enabled at (3531): [<c0186ffc>] kfree+0xf8/0x464
hardirqs last disabled at (3532): [<c06a0ef0>] _raw_spin_lock_irqsave+0=
x1c/0x54
softirqs last  enabled at (0): [<c004572c>] copy_process.part.54+0x3f4/=
0x1930
softirqs last disabled at (0): [<  (null)>]   (null)
Preemption disabled at:[<  (null)>]   (null)

CPU: 1 PID: 128 Comm: sh Not tainted 4.1.9-rt8-01685-g0660ad10-dirty #3=
9
Hardware name: Generic DRA74X (Flattened Device Tree)
[<c0019148>] (unwind_backtrace) from [<c00144b0>] (show_stack+0x10/0x14=
)
[<c00144b0>] (show_stack) from [<c069b4dc>] (dump_stack+0x7c/0x98)
[<c069b4dc>] (dump_stack) from [<c06a148c>] (rt_spin_lock+0x20/0x60)
[<c06a148c>] (rt_spin_lock) from [<c056cb6c>] (clk_enable_lock+0x14/0xb=
0)
[<c056cb6c>] (clk_enable_lock) from [<c056fed8>] (clk_enable+0xc/0x2c)
[<c056fed8>] (clk_enable) from [<c0405474>] (omap_gpio_debounce+0x6c/0x=
120)
[<c0405474>] (omap_gpio_debounce) from [<c0404034>] (export_store+0x70/=
0xfc)
[<c0404034>] (export_store) from [<c0214c2c>] (kernfs_fop_write+0xb8/0x=
19c)
[<c0214c2c>] (kernfs_fop_write) from [<c019cb00>] (__vfs_write+0x20/0xd=
8)
[<c019cb00>] (__vfs_write) from [<c019d3a0>] (vfs_write+0x90/0x164)
[<c019d3a0>] (vfs_write) from [<c019dbc4>] (SyS_write+0x44/0x9c)
[<c019dbc4>] (SyS_write) from [<c0010300>] (ret_fast_syscall+0x0/0x54)
EXT4-fs (mmcblk1p2): error count since last fsck: 2
EXT4-fs (mmcblk1p2): initial error at time 1437484540: ext4_put_super:7=
89
EXT4-fs (mmcblk1p2): last error at time 1437484540: ext4_put_super:789

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/clk/Kconfig                  | 11 +++++++++++
 drivers/clk/clk-divider.c            | 10 +++++-----
 drivers/clk/clk-fractional-divider.c | 10 +++++-----
 drivers/clk/clk-gate.c               |  6 +++---
 drivers/clk/clk-mux.c                |  8 ++++----
 drivers/clk/clk.c                    | 12 +++++++++---
 include/linux/clk-provider.h         | 38 ++++++++++++++++++++++++++--=
--------
 7 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9897f35..458489d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -24,6 +24,17 @@ config COMMON_CLK
 menu "Common Clock Framework"
 	depends on COMMON_CLK
=20
+config COMMON_CLK_USE_RAW_LOCKS
+	bool "Use raw locks for locking on -rt (EXPERIMENTAL)"
+	default n
+	depends on PREEMPT_RT_FULL
+	---help---
+	  This option switches the common clock framework to use raw locks
+	  for locking and, this way, makes it possible to call
+	  clk_enable()/clk_disable() from atomic context.
+	  If unsure, do not use as it may affect on overall system stability
+	  and -RT latencies.
+
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 25006a8..66ad38a 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -388,7 +388,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, =
unsigned long rate,
 				divider->width, divider->flags);
=20
 	if (divider->lock)
-		spin_lock_irqsave(divider->lock, flags);
+		clk_spin_lock_irqsave(divider->lock, flags);
=20
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val =3D div_mask(divider->width) << (divider->shift + 16);
@@ -400,7 +400,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, =
unsigned long rate,
 	clk_writel(val, divider->reg);
=20
 	if (divider->lock)
-		spin_unlock_irqrestore(divider->lock, flags);
+		clk_spin_unlock_irqrestore(divider->lock, flags);
=20
 	return 0;
 }
@@ -416,7 +416,7 @@ static struct clk *_register_divider(struct device =
*dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
-		spinlock_t *lock)
+		clk_spinlock_t *lock)
 {
 	struct clk_divider *div;
 	struct clk *clk;
@@ -475,7 +475,7 @@ static struct clk *_register_divider(struct device =
*dev, const char *name,
 struct clk *clk_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, spinlock_t *lock)
+		u8 clk_divider_flags, clk_spinlock_t *lock)
 {
 	return _register_divider(dev, name, parent_name, flags, reg, shift,
 			width, clk_divider_flags, NULL, lock);
@@ -500,7 +500,7 @@ struct clk *clk_register_divider_table(struct devic=
e *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
-		spinlock_t *lock)
+		clk_spinlock_t *lock)
 {
 	return _register_divider(dev, name, parent_name, flags, reg, shift,
 			width, clk_divider_flags, table, lock);
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fra=
ctional-divider.c
index 6aa72d9..9e4e1a1 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -26,12 +26,12 @@ static unsigned long clk_fd_recalc_rate(struct clk_=
hw *hw,
 	u64 ret;
=20
 	if (fd->lock)
-		spin_lock_irqsave(fd->lock, flags);
+		clk_spin_lock_irqsave(fd->lock, flags);
=20
 	val =3D clk_readl(fd->reg);
=20
 	if (fd->lock)
-		spin_unlock_irqrestore(fd->lock, flags);
+		clk_spin_unlock_irqrestore(fd->lock, flags);
=20
 	m =3D (val & fd->mmask) >> fd->mshift;
 	n =3D (val & fd->nmask) >> fd->nshift;
@@ -79,7 +79,7 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigne=
d long rate,
 	n =3D parent_rate / div;
=20
 	if (fd->lock)
-		spin_lock_irqsave(fd->lock, flags);
+		clk_spin_lock_irqsave(fd->lock, flags);
=20
 	val =3D clk_readl(fd->reg);
 	val &=3D ~(fd->mmask | fd->nmask);
@@ -87,7 +87,7 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigne=
d long rate,
 	clk_writel(val, fd->reg);
=20
 	if (fd->lock)
-		spin_unlock_irqrestore(fd->lock, flags);
+		clk_spin_unlock_irqrestore(fd->lock, flags);
=20
 	return 0;
 }
@@ -102,7 +102,7 @@ EXPORT_SYMBOL_GPL(clk_fractional_divider_ops);
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
-		u8 clk_divider_flags, spinlock_t *lock)
+		u8 clk_divider_flags, clk_spinlock_t *lock)
 {
 	struct clk_fractional_divider *fd;
 	struct clk_init_data init;
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 3f0e420..a77cce6 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -51,7 +51,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int=
 enable)
 	set ^=3D enable;
=20
 	if (gate->lock)
-		spin_lock_irqsave(gate->lock, flags);
+		clk_spin_lock_irqsave(gate->lock, flags);
=20
 	if (gate->flags & CLK_GATE_HIWORD_MASK) {
 		reg =3D BIT(gate->bit_idx + 16);
@@ -69,7 +69,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int=
 enable)
 	clk_writel(reg, gate->reg);
=20
 	if (gate->lock)
-		spin_unlock_irqrestore(gate->lock, flags);
+		clk_spin_unlock_irqrestore(gate->lock, flags);
 }
=20
 static int clk_gate_enable(struct clk_hw *hw)
@@ -121,7 +121,7 @@ EXPORT_SYMBOL_GPL(clk_gate_ops);
 struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
-		u8 clk_gate_flags, spinlock_t *lock)
+		u8 clk_gate_flags, clk_spinlock_t *lock)
 {
 	struct clk_gate *gate;
 	struct clk *clk;
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 69a094c..c4acb55 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -84,7 +84,7 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 i=
ndex)
 	}
=20
 	if (mux->lock)
-		spin_lock_irqsave(mux->lock, flags);
+		clk_spin_lock_irqsave(mux->lock, flags);
=20
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val =3D mux->mask << (mux->shift + 16);
@@ -96,7 +96,7 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 i=
ndex)
 	clk_writel(val, mux->reg);
=20
 	if (mux->lock)
-		spin_unlock_irqrestore(mux->lock, flags);
+		clk_spin_unlock_irqrestore(mux->lock, flags);
=20
 	return 0;
 }
@@ -116,7 +116,7 @@ EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 struct clk *clk_register_mux_table(struct device *dev, const char *nam=
e,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		u8 clk_mux_flags, u32 *table, clk_spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk *clk;
@@ -168,7 +168,7 @@ EXPORT_SYMBOL_GPL(clk_register_mux_table);
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_mux_flags, spinlock_t *lock)
+		u8 clk_mux_flags, clk_spinlock_t *lock)
 {
 	u32 mask =3D BIT(width) - 1;
=20
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9f9cadd..6eb7f8a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -24,7 +24,12 @@
=20
 #include "clk.h"
=20
+#if defined(CONFIG_COMMON_CLK_USE_RAW_LOCKS)
+static DEFINE_RAW_SPINLOCK(enable_lock);
+#else /* PREEMPT_RT_FULL */
 static DEFINE_SPINLOCK(enable_lock);
+#endif
+
 static DEFINE_MUTEX(prepare_lock);
=20
 static struct task_struct *prepare_owner;
@@ -120,13 +125,14 @@ static unsigned long clk_enable_lock(void)
 {
 	unsigned long flags;
=20
-	if (!spin_trylock_irqsave(&enable_lock, flags)) {
+	if (!clk_spin_trylock_irqsave(&enable_lock, flags)) {
 		if (enable_owner =3D=3D current) {
 			enable_refcnt++;
 			return flags;
 		}
-		spin_lock_irqsave(&enable_lock, flags);
+		clk_spin_lock_irqsave(&enable_lock, flags);
 	}
+
 	WARN_ON_ONCE(enable_owner !=3D NULL);
 	WARN_ON_ONCE(enable_refcnt !=3D 0);
 	enable_owner =3D current;
@@ -142,7 +148,7 @@ static void clk_enable_unlock(unsigned long flags)
 	if (--enable_refcnt)
 		return;
 	enable_owner =3D NULL;
-	spin_unlock_irqrestore(&enable_lock, flags);
+	clk_spin_unlock_irqrestore(&enable_lock, flags);
 }
=20
 /***        debugfs support        ***/
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.=
h
index df69531..a0f5d74 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -266,6 +266,24 @@ struct clk *clk_register_fixed_rate_with_accuracy(=
struct device *dev,
=20
 void of_fixed_clk_setup(struct device_node *np);
=20
+#if defined(CONFIG_COMMON_CLK_USE_RAW_LOCKS)
+typedef raw_spinlock_t clk_spinlock_t;
+#define clk_spin_lock_irqsave(lock, flags)	\
+	raw_spin_lock_irqsave(lock, flags)
+#define clk_spin_unlock_irqrestore(lock, flags)	\
+	raw_spin_unlock_irqrestore(lock, flags)
+#define clk_spin_trylock_irqsave(lock, flags)	\
+	raw_spin_trylock_irqsave(lock, flags)
+#else /* PREEMPT_RT_FULL */
+typedef spinlock_t clk_spinlock_t;
+#define clk_spin_lock_irqsave(lock, flags)	\
+	spin_lock_irqsave(lock, flags)
+#define clk_spin_unlock_irqrestore(lock, flags)	\
+	spin_unlock_irqrestore(lock, flags)
+#define clk_spin_trylock_irqsave(lock, flags)	\
+	spin_trylock_irqsave(lock, flags)
+#endif
+
 /**
  * struct clk_gate - gating clock
  *
@@ -291,7 +309,7 @@ struct clk_gate {
 	void __iomem	*reg;
 	u8		bit_idx;
 	u8		flags;
-	spinlock_t	*lock;
+	clk_spinlock_t	*lock;
 };
=20
 #define CLK_GATE_SET_TO_DISABLE		BIT(0)
@@ -301,7 +319,7 @@ extern const struct clk_ops clk_gate_ops;
 struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
-		u8 clk_gate_flags, spinlock_t *lock);
+		u8 clk_gate_flags, clk_spinlock_t *lock);
 void clk_unregister_gate(struct clk *clk);
=20
 struct clk_div_table {
@@ -350,7 +368,7 @@ struct clk_divider {
 	u8		width;
 	u8		flags;
 	const struct clk_div_table	*table;
-	spinlock_t	*lock;
+	clk_spinlock_t	*lock;
 };
=20
 #define CLK_DIVIDER_ONE_BASED		BIT(0)
@@ -375,12 +393,12 @@ int divider_get_val(unsigned long rate, unsigned =
long parent_rate,
 struct clk *clk_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, spinlock_t *lock);
+		u8 clk_divider_flags, clk_spinlock_t *lock);
 struct clk *clk_register_divider_table(struct device *dev, const char =
*name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
-		spinlock_t *lock);
+		clk_spinlock_t *lock);
 void clk_unregister_divider(struct clk *clk);
=20
 /**
@@ -413,7 +431,7 @@ struct clk_mux {
 	u32		mask;
 	u8		shift;
 	u8		flags;
-	spinlock_t	*lock;
+	clk_spinlock_t	*lock;
 };
=20
 #define CLK_MUX_INDEX_ONE		BIT(0)
@@ -428,12 +446,12 @@ extern const struct clk_ops clk_mux_ro_ops;
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_mux_flags, spinlock_t *lock);
+		u8 clk_mux_flags, clk_spinlock_t *lock);
=20
 struct clk *clk_register_mux_table(struct device *dev, const char *nam=
e,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		u8 clk_mux_flags, u32 *table, clk_spinlock_t *lock);
=20
 void clk_unregister_mux(struct clk *clk);
=20
@@ -484,14 +502,14 @@ struct clk_fractional_divider {
 	u8		nshift;
 	u32		nmask;
 	u8		flags;
-	spinlock_t	*lock;
+	clk_spinlock_t	*lock;
 };
=20
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 mshift, u8 mwidth, u8 nshift, u8 nwidth,
-		u8 clk_divider_flags, spinlock_t *lock);
+		u8 clk_divider_flags, clk_spinlock_t *lock);
=20
 /***
  * struct clk_composite - aggregate clock of mux, divider and gate clo=
cks
--=20
2.5.1

