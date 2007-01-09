From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] paravirt: disable Kbuild option for now
Date: Tue, 09 Jan 2007 23:39:41 +1100
Message-ID: <1168346382.19646.130.camel@localhost.localdomain>
References: <20070108163027.GD5098@localhost.localdomain>
	 <20070109084520.GA444@elte.hu>
	 <1168344326.19646.124.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	linux-rt-users@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:35082 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbXAIMjs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jan 2007 07:39:48 -0500
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1168344326.19646.124.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-01-09 at 23:05 +1100, Rusty Russell wrote:
> On Tue, 2007-01-09 at 09:45 +0100, Ingo Molnar wrote:
> > * Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > 
> > > In include/linux/irqflags.h safe_halt changed from a macro to a static 
> > > inline function which results in tons of warnings for architectures 
> > > other than x86[-64]:
> No.  Just drop the whole "don't export paravirt_ops" idea, and we'll
> work on that for 2.6.21.

Or, apply this.  Compile & boot tested.

Name: Revert safe_halt to a macro: instead rename paravirt_ops op to avoid the namespace pollution

Making "safe_halt()" an inline function gives lots of warning on other
archs, so it's easiest to just avoid that name.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 3bbc1e7384c9 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Tue Jan 09 17:28:27 2007 +1100
+++ b/arch/i386/kernel/paravirt.c	Tue Jan 09 23:16:30 2007 +1100
@@ -683,13 +773,13 @@ EXPORT_SYMBOL(wbinvd);
 
 void raw_safe_halt(void)
 {
-	paravirt_ops.safe_halt();
+	paravirt_ops.halt_safe();
 }
 EXPORT_SYMBOL_GPL(raw_safe_halt);
 
 void halt(void)
 {
-	paravirt_ops.safe_halt();
+	paravirt_ops.halt();
 }
 EXPORT_SYMBOL_GPL(halt);
 
@@ -750,7 +840,7 @@ struct paravirt_ops paravirt_ops = {
 	.restore_fl = native_restore_fl,
 	.irq_disable = native_irq_disable,
 	.irq_enable = native_irq_enable,
-	.safe_halt = native_safe_halt,
+	.halt_safe = native_safe_halt,
 	.halt = native_halt,
 	.wbinvd = native_wbinvd,
 	.read_msr = native_read_msr,
diff -r 3bbc1e7384c9 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Tue Jan 09 17:28:27 2007 +1100
+++ b/include/asm-i386/paravirt.h	Tue Jan 09 23:15:22 2007 +1100
@@ -94,7 +94,7 @@ struct paravirt_ops
 	void (fastcall *restore_fl)(unsigned long);
 	void (fastcall *irq_disable)(void);
 	void (fastcall *irq_enable)(void);
-	void (fastcall *safe_halt)(void);
+	void (fastcall *halt_safe)(void);
 	void (fastcall *halt)(void);
 	void (fastcall *wbinvd)(void);
 
diff -r 3bbc1e7384c9 include/linux/irqflags.h
--- a/include/linux/irqflags.h	Tue Jan 09 17:28:27 2007 +1100
+++ b/include/linux/irqflags.h	Tue Jan 09 23:12:20 2007 +1100
@@ -74,11 +74,11 @@
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
-static inline void safe_halt(void)
-{
-	trace_hardirqs_on();
-	raw_safe_halt();
-}
+#define safe_halt()						\
+	do {							\
+		trace_hardirqs_on();				\
+		raw_safe_halt();				\
+	} while (0)
 
 #define local_save_flags(flags)		raw_local_save_flags(flags)
 
