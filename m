From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [PATCH] RT: add clock.cycle_accumulated to vsyscall gtod update
Date: Fri, 13 Jul 2007 01:02:00 -0700
Message-ID: <1184313720.8462.35.camel@sx.thebigcorporation.com>
References: <4696C0720200005A0002776A@mcclure.wal.novell.com>
	 <1184300099.7974.79.camel@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>, mingo@elte.hu,
	tglx@linutronix.de, David Bahi <DBahi@novell.com>,
	linux-rt-users@vger.kernel.org, johnstul@us.ibm.com
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.200.82]:60267 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbXGMICF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jul 2007 04:02:05 -0400
In-Reply-To: <1184300099.7974.79.camel@dhcp193.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-07-12 at 21:14 -0700, Daniel Walker wrote:
> 
> It looks like your patch might be line wrapped ?
> 

I reconstituted the patch to clear the white space damage.

- Sven

>From ghaskins@novell.com Thu Jul 12 21:59:46 2007
Mime-Version: 1.0
X-Mailer: GroupWise 7.0.2 HP
Subject: [PATCH] RT: add clock.cycle_accumulated to vsyscall gtod update
Date: Thu, 12 Jul 2007 21:59:46 -0600
Message-ID: <4696C0720200005A0002776A@novell.com>
From: "Gregory Haskins" <ghaskins@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>, tglx@linutronix.de
Cc: "Sven Dietrich" <SDietrich@novell.com>, "David Bahi" <DBahi@novell.com>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Evolution-Source: imap://sdietrich@imap.novell.com/
Content-Transfer-Encoding: 8bit

2.6.22 changed the vsyscall mechanism to store a more cache-thrash
friendly version of the gtod data.  The original gtod cache code used an
entire struct clock + structure-copy, whereas the new code uses a
pseudo/shadow version + explicit-copy. 

clock.cycle_accumulated was added to RT prior to 2.6.22 so the vsyscall
code must also be updated for the port to 22.

Signed-off-by: Gregory Haskins <ghaskins@novell.com>

Acked-by: Sven-Thorsten Dietrich <sven@thebigcorporation.com>

--- 

 vsyscall.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.22/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux-2.6.22.orig/arch/x86_64/kernel/vsyscall.c
+++ linux-2.6.22/arch/x86_64/kernel/vsyscall.c
@@ -90,6 +90,7 @@ void update_vsyscall(struct timespec *wa
 	/* copy vsyscall data */
 	vsyscall_gtod_data.clock.vread = clock->vread;
 	vsyscall_gtod_data.clock.cycle_last = clock->cycle_last;
+       vsyscall_gtod_data.clock.cycle_accumulated = clock->cycle_accumulated;
 	vsyscall_gtod_data.clock.mask = clock->mask;
 	vsyscall_gtod_data.clock.mult = clock->mult;
 	vsyscall_gtod_data.clock.shift = clock->shift;
