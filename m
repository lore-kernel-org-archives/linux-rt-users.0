From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linux RT patch works on single core - but not booting SMP ARM
 OMAP4 PandaBoard
Date: Tue, 23 Aug 2011 14:18:52 -0700
Message-ID: <4E54193C.8090302@am.sony.com>
References: <CAFQPvXfMgXWHhRsBRbj_CAcymHbbB9UYjU+yM_L+Fp2cEGMbUg@mail.gmail.com>	<CAFQPvXfAhvw+TGmHC910ObkAmt2ZE_QsyGxWWAByzvVYf3+R+g@mail.gmail.com>	<4E4AB90E.10805@am.sony.com>	<4E4ACD2D.80802@am.sony.com>	<CAFQPvXcAM4B2_JN7XbqkXdnf-vJ4G_1z2iobv9tCyfd6LQq_WA@mail.gmail.com> <CAFQPvXe2hgjsW=gYVi1VQx-EgC0fDesQLBc7vQxkc0XrCz6O7A@mail.gmail.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------050002060507090409070806"
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:18689 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab1HWVVm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Aug 2011 17:21:42 -0400
In-Reply-To: <CAFQPvXe2hgjsW=gYVi1VQx-EgC0fDesQLBc7vQxkc0XrCz6O7A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--------------050002060507090409070806
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 08/17/11 12:10, Sankara Muthukrishnan wrote:
> On Wed, Aug 17, 2011 at 11:54 AM, Sankara Muthukrishnan
> <sankara.m@gmail.com> wrote:
>> The cyclic test results are not acceptable (attached the output of
>> cyclictest). I am seeing maximum latency of 757 us on core-0 and 1905
>> us on core-1. Are you (Is anyone) seeing better results on latency
>> with SMP kernel with RT patch on ARM (OMAP4 processors)? I have seen
>> ~25 us of latency with single core kernel (though I have used a
>> different kernel configuration).
>>
> 
> Never ever mind and sorry for the confusion. I did not realize that
> "Kernel debugging" was enabled in the config Frank had attached. With
> kernel debugging disabled, I see max latencies less than 20 us on both
> cores on panda board with cyclictest (cyclictest -l1000000 -m -Sp99
> -i200 -h60 -q -n) in my quick run and it is exciting to see these
> numbers. Thanks Frank.
> 
> The only other outstanding problem as of now is that the RT kernel
> hanging during boot on panda board (boots sometimes after several
> resets and/or power-cycles).

You didn't mention whether you are getting any console messages when
the boot hangs.  If you aren't getting any messages, then the attached
patches __might__ allow some messages to get out.  You also need to
enable CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK, and also add
earlyprintk to the kernel boot command line.

(I need to clean up the patches a bit before even thinking about
whether they should be submitted.)

-Frank

--------------050002060507090409070806
Content-Type: text/plain; name="zzz_allow_console_trylock_for_sysrq"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="zzz_allow_console_trylock_for_sysrq"


WARNING: this is a hack to support debugging.


For CONFIG_PREEMPT_RT_FULL console_trylock_for_printk() will not attempt to
lock the console if:
   !early_boot_irqs_disabled && !irqs_disabled_flags(flags) && !preempt_count()
thus vprintk() will not print out the buffers.

Allow console_trylock_for_printk() attempt to lock the console if
sysrq_in_progress.

This hack patch sets oops_in_progress so that sysrq output can maybe get
delivered to the console without delay.


Using oops_in_progress is important because that also affects the locking
methods used by the serial driver.


---
 kernel/printk.c |    5 	3 +	2 -	0 !
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: b/kernel/printk.c
===================================================================
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -824,8 +824,9 @@ static int console_trylock_for_printk(un
 	__releases(&logbuf_lock)
 {
 #ifdef CONFIG_PREEMPT_RT_FULL
-	int lock = !early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
-		!preempt_count();
+	int lock = oops_in_progress ||
+		(!early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
+		!preempt_count());
 #else
 	int lock = 1;
 #endif
---
 drivers/tty/sysrq.c |    3 	3 +	0 -	0 !
 1 file changed, 3 insertions(+)

Index: b/drivers/tty/sysrq.c
===================================================================
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -499,6 +499,8 @@ void __handle_sysrq(int key, bool check_
 	int i;
 	unsigned long flags;
 
+int save_oops_in_progress = oops_in_progress;
+oops_in_progress = 1;
 	spin_lock_irqsave(&sysrq_key_table_lock, flags);
 	/*
 	 * Raise the apparent loglevel to maximum so that the sysrq header
@@ -542,6 +544,7 @@ void __handle_sysrq(int key, bool check_
 		console_loglevel = orig_log_level;
 	}
 	spin_unlock_irqrestore(&sysrq_key_table_lock, flags);
+oops_in_progress = save_oops_in_progress;
 }
 
 void handle_sysrq(int key)

--------------050002060507090409070806
Content-Type: text/plain; name="zzz-turn-on-oops_in_progress"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="zzz-turn-on-oops_in_progress"

---
 kernel/printk.c |    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/kernel/printk.c
===================================================================
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -66,7 +66,7 @@ int console_printk[4] = {
  * Low level drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.
  */
-int oops_in_progress;
+int oops_in_progress = 1;
 EXPORT_SYMBOL(oops_in_progress);
 
 /*

--------------050002060507090409070806--
