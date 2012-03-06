From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/25][RFC 3.0.23-rt39-rc1] x86-64-remove-vsyscall-number-3
Date: Tue, 06 Mar 2012 11:16:41 -0500
Message-ID: <20120306161945.989840517@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14848 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562Ab2CFQTt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Mar 2012 11:19:49 -0500
Content-Disposition: inline; filename=0005-x86-64-remove-vsyscall-number-3.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Andy Lutomirski <luto@mit.edu>

commit bb5fe2f78eadf5a52d8dcbf9a57728fd107af97b
Author: Andy Lutomirski <luto@mit.edu>
Date:   Sun Jun 5 13:50:22 2011 -0400

    x86-64: Remove vsyscall number 3 (venosys)

    It just segfaults since April 2008 (a4928cff), so I'm pretty
    sure that nothing uses it.  And having an empty section makes
    the linker script a bit fragile.

    Signed-off-by: Andy Lutomirski <luto@mit.edu>
    Link: http://lkml.kernel.org/r/4a4abcf47ecadc269f2391a313576fe6d06acef7.1307292171.git.luto@mit.edu

backport by:

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kernel/vmlinux.lds.S |    4 ----
 arch/x86/kernel/vsyscall_64.c |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 89aed99..85d4a06 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -188,10 +188,6 @@ SECTIONS
 		*(.vsyscall_2)
 	}
 
-	.vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) {
-		*(.vsyscall_3)
-	}
-
 #define __VVAR_KERNEL_LDS
 #include <asm/vvar.h>
 #undef __VVAR_KERNEL_LDS
diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
index 3e68218..a2d96c7 100644
--- a/arch/x86/kernel/vsyscall_64.c
+++ b/arch/x86/kernel/vsyscall_64.c
@@ -222,11 +222,6 @@ vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
 	return 0;
 }
 
-static long __vsyscall(3) venosys_1(void)
-{
-	return -ENOSYS;
-}
