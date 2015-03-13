From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 00/39] Linux 3.14.34-rt32-rc1
Date: Fri, 13 Mar 2015 11:11:35 -0400
Message-ID: <20150313151134.GF3042@home.goodmis.org>
References: <20150312191307.081068717@goodmis.org>
 <1426222153.17611.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426222153.17611.4.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Mar 13, 2015 at 05:49:13AM +0100, Mike Galbraith wrote:
> On Thu, 2015-03-12 at 15:13 -0400, Steven Rostedt wrote:
> > Dear RT Folks,
> >=20
> > This is the RT stable review cycle of patch 3.14.34-rt32-rc1.
> >=20
> > Please scream at me if I messed something up.
>=20
> Hm, in both 12/14 series, 21/N went on a walkabout.

Here's 21 in 3.14-rt:


=46rom fe58592f2863d70ef37866d99d32b69d3cc0c3f3 Mon Sep 17 00:00:00 200=
1
Date: Wed, 10 Dec 2014 10:32:09 +0800
Subject: ARM: enable irq in translation/section permission fault handle=
rs
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

3.14.34-rt32-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

=46rom: "Yadi.hu" <yadi.hu@windriver.com>

Probably happens on all ARM, with
CONFIG_PREEMPT_RT_FULL
CONFIG_DEBUG_ATOMIC_SLEEP

This simple program....

int main() {
   *((char*)0xc0001000) =3D 0;
};

[ 512.742724] BUG: sleeping function called from invalid context at ker=
nel/rtmutex.c:658
[ 512.743000] in_atomic(): 0, irqs_disabled(): 128, pid: 994, name: a
[ 512.743217] INFO: lockdep is turned off.
[ 512.743360] irq event stamp: 0
[ 512.743482] hardirqs last enabled at (0): [< (null)>] (null)
[ 512.743714] hardirqs last disabled at (0): [<c0426370>] copy_process+=
0x3b0/0x11c0
[ 512.744013] softirqs last enabled at (0): [<c0426370>] copy_process+0=
x3b0/0x11c0
[ 512.744303] softirqs last disabled at (0): [< (null)>] (null)
[ 512.744631] [<c041872c>] (unwind_backtrace+0x0/0x104)
[ 512.745001] [<c09af0c4>] (dump_stack+0x20/0x24)
[ 512.745355] [<c0462490>] (__might_sleep+0x1dc/0x1e0)
[ 512.745717] [<c09b6770>] (rt_spin_lock+0x34/0x6c)
[ 512.746073] [<c0441bf0>] (do_force_sig_info+0x34/0xf0)
[ 512.746457] [<c0442668>] (force_sig_info+0x18/0x1c)
[ 512.746829] [<c041d880>] (__do_user_fault+0x9c/0xd8)
[ 512.747185] [<c041d938>] (do_bad_area+0x7c/0x94)
[ 512.747536] [<c041d990>] (do_sect_fault+0x40/0x48)
[ 512.747898] [<c040841c>] (do_DataAbort+0x40/0xa0)
[ 512.748181] Exception stack(0xecaa1fb0 to 0xecaa1ff8)

Oxc0000000 belongs to kernel address space, user task can not be
allowed to access it. For above condition, correct result is that
test case should receive a =E2=80=9Csegment fault=E2=80=9D and exits bu=
t not stacks.

the root cause is commit 02fe2845d6a8 ("avoid enabling interrupts in
prefetch/data abort handlers"),it deletes irq enable block in Data
abort assemble code and move them into page/breakpiont/alignment fault
handlers instead. But author does not enable irq in translation/section
permission fault handlers. ARM disables irq when it enters exception/
interrupt mode, if kernel doesn't enable irq, it would be still disable=
d
during translation/section permission fault.

We see the above splat because do_force_sig_info is still called with
IRQs off, and that code eventually does a:

        spin_lock_irqsave(&t->sighand->siglock, flags);

As this is architecture independent code, and we've not seen any other
need for other arch to have the siglock converted to raw lock, we can
conclude that we should enable irq for ARM translation/section
permission exception.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index b40d4bab8e07..c15d2a0826c6 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -431,6 +431,9 @@ do_translation_fault(unsigned long addr, unsigned i=
nt fsr,
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);
=20
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	if (user_mode(regs))
 		goto bad_area;
=20
@@ -498,6 +501,9 @@ do_translation_fault(unsigned long addr, unsigned i=
nt fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *re=
gs)
 {
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	do_bad_area(addr, fsr, regs);
 	return 0;
 }
--=20
2.1.4
