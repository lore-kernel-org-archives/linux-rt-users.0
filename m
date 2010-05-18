From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after
	console_init
Date: Tue, 18 May 2010 14:28:39 -0500
Message-ID: <AANLkTinClrTDoXH4NPP2-SgSYH24ZTnqsop88aocdg4R@mail.gmail.com>
References: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51141 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572Ab0ERT2p (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 May 2010 15:28:45 -0400
In-Reply-To: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 18, 2010 at 8:13 AM, Xianghua Xiao <xiaoxianghua@gmail.com> wrote:
> I would like to have printk output to my ttyS0 console all the time,
> with 2.6.33-rt17, after kernel is booted up with all messages shown
> normally on the serial port until I login in, from this point on, all
> printk messages go to 'dmesg(log_buf)' fine, but I could never get
> them shown up on serial console anymore. I tried adjust
> /proc/sys/kernel/printk etc none helped.
>
> Switch PREEMPT_RT to PREEMPT_VOLUNTARY and reboot, now everything
> works, i.e. I can see printk on my console after I login.
>
> Look at the RT patch itself, I do find some changes to printk itself,
> however I'm unsure what is causing this(i.e printk not going to
> console after login).
>
> Thanks,
> Xianghua
>

Thomas,

I could not get dmesg output to console/serial and
klogd(/var/log/messages) anymore with 2.6.33-rt17 _after_ the kernel
boot is done(on non-RT kernel it works fine). I made below changes it
starts to work again, however I'm unsure how safe the change is.
Please advise.

During googling I found this: http://lkml.org/lkml/2008/1/24/390, fyi.

Thanks a lot!
Xianghua

diff --git a/kernel/printk.c b/kernel/printk.c
index 073d27f..48ef843 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -430,7 +430,6 @@ static void __call_console_drivers(unsigned start,
unsigned end)

 	for_each_console(con) {
 		if ((con->flags & CON_ENABLED) && con->write &&
-		    console_atomic_safe(con) &&
 		    (cpu_online(raw_smp_processor_id()) ||
 		     (con->flags & CON_ANYTIME))) {
 			set_printk_might_sleep(1);
@@ -1093,9 +1092,6 @@ void release_console_mutex(void)
 	 * printk from non-preemptible sections so this is for the emergency
 	 * case only.
 	 */
-#ifdef CONFIG_PREEMPT_RT
-	if (!in_atomic() && !irqs_disabled())
-#endif
 	if (wake_klogd)
 		wake_up_klogd();
 }
