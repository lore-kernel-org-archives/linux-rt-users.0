From: Juergen Beisert <jbe@pengutronix.de>
Subject: [PATCH 1/1] ARCH PowerPC: Consider new flags in assembler instructions
Date: Fri, 21 Sep 2007 20:51:37 +0200
Message-ID: <200709212051.38192.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:44381 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759865AbXIUSvu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Sep 2007 14:51:50 -0400
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>)
	id 1IYnbH-0001kU-9g
	for linux-rt-users@vger.kernel.org; Fri, 21 Sep 2007 20:51:47 +0200
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Subject: [PATCH 1/1] ARCH PowerPC: Consider new flags in assembler inst=
ructions

Additional flags in bit 16 and 17 require changes in the assembler code=
 to
handle these new flags. The old instructions only can handle 16 bits. N=
ow
there are 18.
Note: I'm not an expert in PowerPC assembler, so there might be better
solutions to handle more than 16 bits in this environment.

Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>

---

Index: arch/powerpc/kernel/entry_32.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/powerpc/kernel/entry_32.S.orig
+++ arch/powerpc/kernel/entry_32.S
@@ -228,7 +228,9 @@ ret_from_syscall:
 	MTMSRD(r10)
 	lwz	r9,TI_FLAGS(r12)
 	li	r8,-_LAST_ERRNO
-	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|=
_TIF_PERSYSCALL_MASK)
+	lis	r0,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_=
PERSYSCALL_MASK)@h
+	ori	r0,r0,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_T=
IF_PERSYSCALL_MASK)@l
+	and.    r0,r0,r9
 	bne-	syscall_exit_work
 	cmplw	0,r3,r8
 	blt+	syscall_exit_cont
@@ -641,7 +643,9 @@ user_exc_return:		/* r10 contains MSR_KE
 	/* Check current_thread_info()->flags */
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,(_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK|_TIF_NEED_RESCHED|_=
TIF_NEED_RESCHED_DELAYED)
+	lis	r0,(_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK|_TIF_NEED_RESCHED|_TIF_N=
EED_RESCHED_DELAYED)@h
+	ori	r0,r0,(_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK|_TIF_NEED_RESCHED|_TI=
=46_NEED_RESCHED_DELAYED)@l
+	and.	r0,r9,r0
 	bne	do_work
=20
 restore_user:
@@ -863,7 +867,9 @@ global_dbcr0:
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */
=20
 do_work:			/* r10 contains MSR_KERNEL here */
-	andi.	r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
+	lis	r0,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)@h
+	ori	r0,r0,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)@l
+	and.	r0,r9,r0
 	beq	do_user_signal
=20
 do_resched:			/* r10 contains MSR_KERNEL here */
@@ -877,7 +883,9 @@ recheck:
 	MTMSRD(r10)		/* disable interrupts */
 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
 	lwz	r9,TI_FLAGS(r9)
-	andi.	r0,r9,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)
+	lis	r0,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)@h
+	ori	r0,r0,(_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_DELAYED)@l
+	and.	r0,r9,r0
 	bne-	do_resched
 	andi.	r0,r9,_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK
 	beq	restore_user

--=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
