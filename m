From: Yadi Hu <yadi.hu@windriver.com>
Subject: =?UTF-8?q?=5BPATCH=203=2E14=2Ex-rt=5D=20ARM=3A=20enable=20irq=20in=20translation/section=20permission=20fault=20handlers?=
Date: Wed, 10 Dec 2014 10:32:09 +0800
Message-ID: <1418178729-2279-2-git-send-email-yadi.hu@windriver.com>
References: <1418178729-2279-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <yadi.hu@windriver.com>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36901 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbaLJCc2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Dec 2014 21:32:28 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id sBA2WRPe018355
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Tue, 9 Dec 2014 18:32:28 -0800 (PST)
In-Reply-To: <1418178729-2279-1-git-send-email-yadi.hu@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46rom: Yadi.hu <yadi.hu@windriver.com>

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

Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
---
 arch/arm/mm/fault.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5dbf13f..272519f 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -428,6 +428,9 @@ do_translation_fault(unsigned long addr, unsigned i=
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
@@ -494,6 +497,9 @@ do_translation_fault(unsigned long addr, unsigned i=
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
1.7.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
