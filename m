From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] Don't call mcount from vsyscall_fn's
Date: Mon, 18 Jun 2007 22:41:09 -0400
Message-ID: <1182220869.15228.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933162AbXFSCmA@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This bit me in the butt.

I couldn't understand why my init app was segfaulting, with a kernel
address, but a user RIP and RSP.  Well, the RIP I think was bogus, but
the kernel address was always the start of "mcount".  Looking deeper, I
printed out what was in the RSP (even though it was a user stack).  It
ended up showing me that the calling address was from the VDSO area.
Looking even further, I found the offending culprit, which was
vread_hpet.

Looking at the assembly dump, I saw the vread_hpet was calling mcount,
but I could not see it in the code. Nor could I see it in hpet.i (-E
option of compiling).

Well, I guess Ingo is a magician when it comes to compiler tricks, and
has the mcount being called by "every!!" function, unless you add the
"notrace" option.

This patch adds the notrace to vsyscall_fn, so that we don't have user
land apps calling mcount and crashing!

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6-rt-test/include/asm-x86_64/vsyscall.h
===================================================================
--- linux-2.6-rt-test.orig/include/asm-x86_64/vsyscall.h
+++ linux-2.6-rt-test/include/asm-x86_64/vsyscall.h
@@ -22,7 +22,7 @@ enum vsyscall_num {
 /* Definitions for CONFIG_GENERIC_TIME definitions */
 #define __section_vsyscall_gtod_data __attribute__ \
 	((unused, __section__ (".vsyscall_gtod_data"),aligned(16)))
-#define __vsyscall_fn __attribute__ ((unused,__section__(".vsyscall_fn")))
+#define __vsyscall_fn __attribute__ ((unused,__section__(".vsyscall_fn"))) notrace
 
 #define VGETCPU_RDTSCP	1
 #define VGETCPU_LSL	2
