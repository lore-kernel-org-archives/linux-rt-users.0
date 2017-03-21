From: Julia Cartwright <julia@ni.com>
Subject: [PATCH v2 0/9] fixup usage of non-raw spinlocks in irqchips
Date: Tue, 21 Mar 2017 17:43:00 -0500
Message-ID: <cover.1490135047.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        Michal Marek <mmarek@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
To: <linux-kernel@vger.kernel.org>
Return-path: <cocci-bounces@systeme.lip6.fr>
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

Changes since v1[1]:
 - Dropped already applied patches in pinctrl, gpio, and mux trees.
 - Gained three new patches destined for gpio tree, due to loosening constraints in
   the semantic patch.

The following patchset introduces a new coccinelle patch,
irq_chip_raw_spinlock.cocci, which is used to identify irq_chip implementors
which acquire/release non-raw spinlocks, and in addition, a set of generated
patches for most cases identified.

On mainline builds, there exists no functional difference between
raw_spinlock_t and spinlock_t.  However, w/ PREEMPT_RT, the spinlock_t will
cause the calling thread to sleep when the lock is contended.  Because sleeping
is illegal in hardirq context, and because the irqchip callbacks are invoked in
hardirq context, irqchip implementations must not use spin_lock_t for
synchronization.

Patches build tested only.  All patches are independent of one another and can
be applied to the relevant trees.

Some notes:

  - In order to ensure that latency problems are not introduced for realtime
    kernels, the generated patches need to be hand audited to ensure that
    raw-spinlock protected regions are bounded and minimal.  I've done a quick
    audit for each of the modified drivers in this series, but please check my
    work.

  - There are a couple of matches which will require further intervention to
    fully fix.  Namely the Intel LPE Audio driver:

       drivers/gpu/drm/i915/intel_lpe_audio.c:169:30-38: Use of non-raw spinlock is illegal in this context (struct drm_i915_private::irq_lock)

    and the adi2 pinctrl driver:

       drivers/pinctrl/pinctrl-adi2.c:308:26-30: Use of non-raw spinlock is illegal in this context (struct gpio_port::lock)

  - This semantic patch is not comprehensive, there are other equally broken
    usecases which are not properly identified yet, such as the use of a single
    global spinlock_t declared via DEFINE_SPINLOCK() (found in arch/alpha, and
    perhaps elsewhere).

    An additional currently unhandled case is the irq_chip_generic callbacks.

   Julia

[1]: http://lkml.kernel.org/r/cover.1489015238.git.julia@ni.com

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <mmarek@suse.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: cocci@systeme.lip6.fr
--------------
Julia Cartwright (9):
  Coccinelle: locks: identify callers of spin_lock{,_irq,_irqsave}() in
    irqchip implementations
  alpha: marvel: make use of raw_spinlock variants
  powerpc: mpc52xx_gpt: make use of raw_spinlock variants
  mfd: asic3: make use of raw_spinlock variants
  mfd: t7l66xb: make use of raw_spinlock variants
  mfd: tc6393xb: make use of raw_spinlock variants
  gpio: 104-idi-48: make use of raw_spinlock variants
  gpio: 104-idio-16: make use of raw_spinlock variants
  gpio: pci-idio-16: make use of raw_spinlock variants

 arch/alpha/include/asm/core_marvel.h               |  2 +-
 arch/alpha/kernel/core_marvel.c                    |  2 +-
 arch/alpha/kernel/sys_marvel.c                     | 12 +--
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          | 52 ++++++------
 drivers/gpio/gpio-104-idi-48.c                     | 18 ++--
 drivers/gpio/gpio-104-idio-16.c                    | 24 +++---
 drivers/gpio/gpio-pci-idio-16.c                    | 28 +++----
 drivers/mfd/asic3.c                                | 56 ++++++-------
 drivers/mfd/t7l66xb.c                              | 20 ++---
 drivers/mfd/tc6393xb.c                             | 52 ++++++------
 .../coccinelle/locks/irq_chip_raw_spinlock.cocci   | 96 ++++++++++++++++++++++
 11 files changed, 230 insertions(+), 132 deletions(-)
 create mode 100644 scripts/coccinelle/locks/irq_chip_raw_spinlock.cocci

-- 
2.12.0
