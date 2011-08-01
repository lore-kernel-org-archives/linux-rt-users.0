From: Rolando Martins <rolando.martins@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt6
Date: Mon, 1 Aug 2011 09:42:43 +0100
Message-ID: <CABcS5h0m10aWDuK5fK4C-mzMMwLyXJ_cehoTgWFutvPPrv30HQ@mail.gmail.com>
References: <alpine.LFD.2.02.1107282213000.31246@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1107282213000.31246@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Peter,
is there any progress on the CONFIG_RT_GROUP_SCHED front?
I don't know if this is related, but in 33-rt if I used a low (=3D100)
cpu_runtime_us and cpu_period_us then I would get some freezes
(something that does not happen in 2.6.39).

Thanks,
Rolando


On Thu, Jul 28, 2011 at 10:43 PM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 3.0-rt6 release.
>
> Changes versus 3.0-rt4 (I pushed out a rt5 w/o announce)
>
> =A0* pin_cpu fix (Yong Zhang)
>
> =A0* Various compile fixes (Yong Zhang & myself)
>
> =A0* Serial fix for omap
>
> =A0* Clocksource lockless watchdog reset
>
> =A0* Reenabled CONFIG_RCU_BOOST (problem is unreproducible and maybe
> =A0 =A0related to NO_HZ, which is still disabled. Paul is working on =
it!)
>
> =A0* KGDB work^Whackaround (Jason Wessel)
>
> =A0 =A0The kgdb workaround is really a hack and wants to be replaced =
by a
> =A0 =A0proper overhaul for the console/tty maze.
> =A0 =A0See: kgb-serial-hackaround.patch
>
> As I said yesterday, I'm preparing for vanishing from the net.
>
> Please keep on testing and sending patches. Peter Zijlstra kindly
> volunteered to cover for me. He'll pick up stuff and eventually push
> out releases when a reasonable number of sane patches hits his inbox.
>
> If you reply to that mail, please keep the Cc list intact to make sur=
e
> that all interested folks see it. It does not matter whether you are
> subscribed to a particular mailing list or not. Just keep your finger=
s
> away from the Cc list unless you have a very good reason to do
> so. Hint for GUI mail "client" users: Hit "Reply to all" ....
>
> For all those who are addicted to roadmaps, here is the roadmap I'm
> caring about for the next two weeks:
>
> =A0http://maps.google.com/maps?q=3DFuchsenloch,+Schlier&hl=3Den&z=3D1=
6
>
> For the curious: Fuchsenloch =3D=3D Fox hole. IOW: The place where fo=
x and
> rabbit say Good Night to each other.
>
> And for those who care about estimates, here are my momentary
> favourite Dilberts on this topic:
>
> =A0 http://dilbert.com/strips/comic/1995-11-10/
> =A0 http://dilbert.com/strips/comic/2010-05-05/
>
> Patch against 3.0 can be found here:
>
> =A0http://www.kernel.org/pub/linux/kernel/projects/rt/patch-3.0-rt6.p=
atch.bz2
>
> The split quilt queue is available at:
>
> =A0http://www.kernel.org/pub/linux/kernel/projects/rt/patches-3.0-rt6=
=2Etar.bz2
>
> Delta patch against 3.0-rt4 below.
>
> Thanks,
>
> =A0 =A0 =A0 =A0tglx
> ----
> =A0arch/arm/include/asm/mmu.h =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/tty/serial/8250.c =A0 =A0 =A0 =A0| =A0 13 +++++++++----
> =A0drivers/tty/serial/omap-serial.c | =A0 =A08 +++-----
> =A0include/linux/kdb.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0init/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0kernel/cpu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++=
+-
> =A0kernel/debug/kdb/kdb_io.c =A0 =A0 =A0 =A0| =A0 =A06 ++----
> =A0kernel/hrtimer.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +---
> =A0kernel/time/clocksource.c =A0 =A0 =A0 =A0| =A0 38 ++++++++++++++++=
++--------------------
> =A0localversion-rt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A010 files changed, 41 insertions(+), 40 deletions(-)
>
> Index: linux-2.6/arch/arm/include/asm/mmu.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/arm/include/asm/mmu.h
> +++ linux-2.6/arch/arm/include/asm/mmu.h
> @@ -16,7 +16,7 @@ typedef struct {
>
> =A0/* init_mm.context.id_lock should be initialized. */
> =A0#define INIT_MM_CONTEXT(name) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 .context.id_lock =A0 =A0=3D __SPIN_LOCK_UNLOCKED(name.c=
ontext.id_lock),
> + =A0 =A0 =A0 .context.id_lock =A0 =A0=3D __RAW_SPIN_LOCK_UNLOCKED(na=
me.context.id_lock),
> =A0#else
> =A0#define ASID(mm) =A0 =A0 =A0 (0)
> =A0#endif
> Index: linux-2.6/drivers/tty/serial/8250.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/tty/serial/8250.c
> +++ linux-2.6/drivers/tty/serial/8250.c
> @@ -38,6 +38,7 @@
> =A0#include <linux/nmi.h>
> =A0#include <linux/mutex.h>
> =A0#include <linux/slab.h>
> +#include <linux/kdb.h>
>
> =A0#include <asm/io.h>
> =A0#include <asm/irq.h>
> @@ -2894,10 +2895,14 @@ serial8250_console_write(struct console
>
> =A0 =A0 =A0 =A0touch_nmi_watchdog();
>
> - =A0 =A0 =A0 if (up->port.sysrq || oops_in_progress)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D spin_trylock_irqsave(&up->po=
rt.lock, flags);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags=
);
> + =A0 =A0 =A0 if (unlikely(in_kdb_printk())) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D 0;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (up->port.sysrq || oops_in_progress)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D spin_trylock=
_irqsave(&up->port.lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&up->=
port.lock, flags);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * =A0 =A0 =A0First save the IER then disable the inte=
rrupts
> Index: linux-2.6/init/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/init/Kconfig
> +++ linux-2.6/init/Kconfig
> @@ -493,7 +493,7 @@ config TREE_RCU_TRACE
>
> =A0config RCU_BOOST
> =A0 =A0 =A0 =A0bool "Enable RCU priority boosting"
> - =A0 =A0 =A0 depends on RT_MUTEXES && PREEMPT_RCU && !RT_PREEMPT_FUL=
L
> + =A0 =A0 =A0 depends on RT_MUTEXES && PREEMPT_RCU
> =A0 =A0 =A0 =A0default n
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This option boosts the priority of preempted RCU r=
eaders that
> Index: linux-2.6/kernel/cpu.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/cpu.c
> +++ linux-2.6/kernel/cpu.c
> @@ -75,9 +75,11 @@ static DEFINE_PER_CPU(struct hotplug_pcp
> =A0*/
> =A0void pin_current_cpu(void)
> =A0{
> - =A0 =A0 =A0 struct hotplug_pcp *hp =3D &__get_cpu_var(hotplug_pcp);
> + =A0 =A0 =A0 struct hotplug_pcp *hp;
>
> =A0retry:
> + =A0 =A0 =A0 hp =3D &__get_cpu_var(hotplug_pcp);
> +
> =A0 =A0 =A0 =A0if (!hp->unplug || hp->refcount || preempt_count() > 1=
 ||
> =A0 =A0 =A0 =A0 =A0 =A0hp->unplug =3D=3D current || (current->flags &=
 PF_STOMPER)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hp->refcount++;
> Index: linux-2.6/kernel/hrtimer.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/hrtimer.c
> +++ linux-2.6/kernel/hrtimer.c
> @@ -1294,11 +1294,9 @@ static void __run_hrtimer(struct hrtimer
> =A0 =A0 =A0 =A0timer->state &=3D ~HRTIMER_STATE_CALLBACK;
> =A0}
>
> -
> -#ifdef CONFIG_PREEMPT_RT_BASE
> -
> =A0static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);
>
> +#ifdef CONFIG_PREEMPT_RT_BASE
> =A0static void hrtimer_rt_reprogram(int restart, struct hrtimer *time=
r,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t hrtimer_clock_base *base)
> =A0{
> Index: linux-2.6/localversion-rt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/localversion-rt
> +++ linux-2.6/localversion-rt
> @@ -1 +1 @@
> --rt4
> +-rt6
> Index: linux-2.6/kernel/time/clocksource.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/time/clocksource.c
> +++ linux-2.6/kernel/time/clocksource.c
> @@ -186,6 +186,7 @@ static struct timer_list watchdog_timer;
> =A0static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
> =A0static DEFINE_SPINLOCK(watchdog_lock);
> =A0static int watchdog_running;
> +static atomic_t watchdog_reset_pending;
>
> =A0static int clocksource_watchdog_kthread(void *data);
> =A0static void __clocksource_change_rating(struct clocksource *cs, in=
t rating);
> @@ -247,12 +248,14 @@ static void clocksource_watchdog(unsigne
> =A0 =A0 =A0 =A0struct clocksource *cs;
> =A0 =A0 =A0 =A0cycle_t csnow, wdnow;
> =A0 =A0 =A0 =A0int64_t wd_nsec, cs_nsec;
> - =A0 =A0 =A0 int next_cpu;
> + =A0 =A0 =A0 int next_cpu, reset_pending;
>
> =A0 =A0 =A0 =A0spin_lock(&watchdog_lock);
> =A0 =A0 =A0 =A0if (!watchdog_running)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> + =A0 =A0 =A0 reset_pending =3D atomic_read(&watchdog_reset_pending);
> +
> =A0 =A0 =A0 =A0list_for_each_entry(cs, &watchdog_list, wd_list) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clocksource already marked unstable=
? */
> @@ -268,7 +271,8 @@ static void clocksource_watchdog(unsigne
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local_irq_enable();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clocksource initialized ? */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(cs->flags & CLOCK_SOURCE_WATCHDOG=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(cs->flags & CLOCK_SOURCE_WATCHDOG=
) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_read(&watchdog_reset_pen=
ding)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->flags |=3D CLOCK_S=
OURCE_WATCHDOG;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->wd_last =3D wdnow;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->cs_last =3D csnow;
> @@ -283,8 +287,11 @@ static void clocksource_watchdog(unsigne
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->cs_last =3D csnow;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->wd_last =3D wdnow;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_read(&watchdog_reset_pending=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Check the deviation from the watchd=
og clocksource. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (abs(cs_nsec - wd_nsec) > WATCHDOG_T=
HRESHOLD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((abs(cs_nsec - wd_nsec) > WATCHDOG_=
THRESHOLD)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clocksource_unstable(c=
s, cs_nsec - wd_nsec);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -303,6 +310,13 @@ static void clocksource_watchdog(unsigne
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* We only clear the watchdog_reset_pending, when we =
did a
> + =A0 =A0 =A0 =A0* full cycle through all clocksources.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (reset_pending)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&watchdog_reset_pending);
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Cycle through CPUs to check if the CPUs stay synchr=
onized
> =A0 =A0 =A0 =A0 * to each other.
> =A0 =A0 =A0 =A0 */
> @@ -344,23 +358,7 @@ static inline void clocksource_reset_wat
>
> =A0static void clocksource_resume_watchdog(void)
> =A0{
> - =A0 =A0 =A0 unsigned long flags;
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* We use trylock here to avoid a potential dead lock=
 when
> - =A0 =A0 =A0 =A0* kgdb calls this code after the kernel has been sto=
pped with
> - =A0 =A0 =A0 =A0* watchdog_lock held. When watchdog_lock is held we =
just
> - =A0 =A0 =A0 =A0* return and accept, that the watchdog might trigger=
 and mark
> - =A0 =A0 =A0 =A0* the monitored clock source (usually TSC) unstable.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* This does not affect the other caller clocksource_=
resume()
> - =A0 =A0 =A0 =A0* because at this point the kernel is UP, interrupts=
 are
> - =A0 =A0 =A0 =A0* disabled and nothing can hold watchdog_lock.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!spin_trylock_irqsave(&watchdog_lock, flags))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 clocksource_reset_watchdog();
> - =A0 =A0 =A0 spin_unlock_irqrestore(&watchdog_lock, flags);
> + =A0 =A0 =A0 atomic_inc(&watchdog_reset_pending);
> =A0}
>
> =A0static void clocksource_enqueue_watchdog(struct clocksource *cs)
> Index: linux-2.6/drivers/tty/serial/omap-serial.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/tty/serial/omap-serial.c
> +++ linux-2.6/drivers/tty/serial/omap-serial.c
> @@ -947,13 +947,12 @@ serial_omap_console_write(struct console
> =A0 =A0 =A0 =A0unsigned int ier;
> =A0 =A0 =A0 =A0int locked =3D 1;
>
> - =A0 =A0 =A0 local_irq_save(flags);
> =A0 =A0 =A0 =A0if (up->port.sysrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0locked =3D 0;
> =A0 =A0 =A0 =A0else if (oops_in_progress)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D spin_trylock(&up->port.lock)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 locked =3D spin_trylock_irqsave(&up->po=
rt.lock, flags);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&up->port.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags=
);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * First save the IER then disable the interrupts
> @@ -980,8 +979,7 @@ serial_omap_console_write(struct console
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_modem_status(up);
>
> =A0 =A0 =A0 =A0if (locked)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&up->port.lock);
> - =A0 =A0 =A0 local_irq_restore(flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, =
flags);
> =A0}
>
> =A0static int __init
> Index: linux-2.6/include/linux/kdb.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/include/linux/kdb.h
> +++ linux-2.6/include/linux/kdb.h
> @@ -153,12 +153,14 @@ extern int kdb_register(char *, kdb_func
> =A0extern int kdb_register_repeat(char *, kdb_func_t, char *, char *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 short, kd=
b_repeat_t);
> =A0extern int kdb_unregister(char *);
> +#define in_kdb_printk() (kdb_trap_printk)
> =A0#else /* ! CONFIG_KGDB_KDB */
> =A0#define kdb_printf(...)
> =A0#define kdb_init(x)
> =A0#define kdb_register(...)
> =A0#define kdb_register_repeat(...)
> =A0#define kdb_uregister(x)
> +#define in_kdb_printk() (0)
> =A0#endif /* CONFIG_KGDB_KDB */
> =A0enum {
> =A0 =A0 =A0 =A0KDB_NOT_INITIALIZED,
> Index: linux-2.6/kernel/debug/kdb/kdb_io.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/debug/kdb/kdb_io.c
> +++ linux-2.6/kernel/debug/kdb/kdb_io.c
> @@ -539,7 +539,6 @@ int vkdb_printf(const char *fmt, va_list
> =A0 =A0 =A0 =A0int diag;
> =A0 =A0 =A0 =A0int linecount;
> =A0 =A0 =A0 =A0int logging, saved_loglevel =3D 0;
> - =A0 =A0 =A0 int saved_trap_printk;
> =A0 =A0 =A0 =A0int got_printf_lock =3D 0;
> =A0 =A0 =A0 =A0int retlen =3D 0;
> =A0 =A0 =A0 =A0int fnd, len;
> @@ -550,8 +549,6 @@ int vkdb_printf(const char *fmt, va_list
> =A0 =A0 =A0 =A0unsigned long uninitialized_var(flags);
>
> =A0 =A0 =A0 =A0preempt_disable();
> - =A0 =A0 =A0 saved_trap_printk =3D kdb_trap_printk;
> - =A0 =A0 =A0 kdb_trap_printk =3D 0;
>
> =A0 =A0 =A0 =A0/* Serialize kdb_printf if multiple cpus try to write =
at once.
> =A0 =A0 =A0 =A0 * But if any cpu goes recursive in kdb, just print th=
e output,
> @@ -807,7 +804,6 @@ kdb_print_out:
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__release(kdb_printf_lock);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 kdb_trap_printk =3D saved_trap_printk;
> =A0 =A0 =A0 =A0preempt_enable();
> =A0 =A0 =A0 =A0return retlen;
> =A0}
> @@ -817,9 +813,11 @@ int kdb_printf(const char *fmt, ...)
> =A0 =A0 =A0 =A0va_list ap;
> =A0 =A0 =A0 =A0int r;
>
> + =A0 =A0 =A0 kdb_trap_printk++;
> =A0 =A0 =A0 =A0va_start(ap, fmt);
> =A0 =A0 =A0 =A0r =3D vkdb_printf(fmt, ap);
> =A0 =A0 =A0 =A0va_end(ap);
> + =A0 =A0 =A0 kdb_trap_printk--;
>
> =A0 =A0 =A0 =A0return r;
> =A0}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
