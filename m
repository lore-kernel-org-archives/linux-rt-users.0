From: "Gregory Haskins" <ghaskins@novell.com>
Subject: [PATCH] RT: add clock.cycle_accumulated to vsyscall gtod
	update
Date: Thu, 12 Jul 2007 23:59:46 -0400
Message-ID: <4696C0720200005A0002776A@mcclure.wal.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "David Bahi" <DBahi@novell.com>,
	"Sven Dietrich" <SDietrich@novell.com>,
	<linux-rt-users@vger.kernel.org>
To: <mingo@elte.hu>, <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:11367 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759275AbXGMD74 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Jul 2007 23:59:56 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

2.6.22 changed the vsyscall mechanism to store a more cache-thrash
friendly version of the gtod data.  The original gtod cache code used an
entire struct clock + structure-copy, whereas the new code uses a
pseudo/shadow version + explicit-copy. 

clock.cycle_accumulated was added to RT prior to 2.6.22 so the vsyscall
code must also be updated for the port to 22.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>
--- 

 vsyscall.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.22.orig/arch/x86_64/kernel/vsyscall.c
+++ linux-2.6.22/arch/x86_64/kernel/vsyscall.c
@@ -90,6 +90,7 @@ void update_vsyscall(struct timespec *wa
        /* copy vsyscall data */
        vsyscall_gtod_data.clock.vread = clock->vread;
        vsyscall_gtod_data.clock.cycle_last = clock->cycle_last;
+       vsyscall_gtod_data.clock.cycle_accumulated =
clock->cycle_accumulated;
        vsyscall_gtod_data.clock.mask = clock->mask;
        vsyscall_gtod_data.clock.mult = clock->mult;
        vsyscall_gtod_data.clock.shift = clock->shift;
