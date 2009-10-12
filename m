From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Bug in timekeeping.c ktime_get_ts() Kernel 2.2.29.6-rt23
Date: Mon, 12 Oct 2009 17:48:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0910121659080.9428@localhost.localdomain>
References: <4EA20108F62E0346A80AFB03445370F210F31385D4@de01ex08.GLOBAL.JHCN.NET>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1144428061-1255359771=:9428"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"mingo@elte.hu" <mingo@elte.hu>
To: =?ISO-8859-15?Q?M=FChlbauer_Gerhard?= <muehlbauer@heidenhain.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33978 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253AbZJLPtX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Oct 2009 11:49:23 -0400
In-Reply-To: <4EA20108F62E0346A80AFB03445370F210F31385D4@de01ex08.GLOBAL.JHCN.NET>
Content-ID: <alpine.LFD.2.00.0910121748000.9428@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1144428061-1255359771=:9428
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.00.0910121748001.9428@localhost.localdomain>

Gerhard,

On Mon, 12 Oct 2009, Mühlbauer Gerhard wrote:

> Hello!

> We have found a bug in the function ktime_get_ts() in the rt23
> realtime patches.  The function set_normalized_timespec() gets
> called with a sum of 3 different nsec values. Although each value
> should be within a range of 0..100000000, the sum can be within a
> range of 0..3000000000 and by this an overflow happens when
> assigning this to a long variable. As a result, the function
> clock_gettime(CLOCK_MONOTONIC) can create results that jump back and
> forth in time each second by a step of 2^32nsec (=4sec).  The
> following patch solves this problem when attached after
> patch-2.6.29.6-rt23.

correct. We fixed that problem in mainline a few weeks ago, but I did
not come around to do an update to 2.6.29-rt.

While your patch solves the problem I recommend using the mainline fix
below as it covers all eventual use cases of set_normalized_timespec().

I also uploaded a 2.6.29-rt24 patch set to the usual place which has
the fix applied.

Thanks,

	tglx
---
commit 12e09337fe238981cb0c87543306e23775d1a143
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Mon Sep 14 23:37:40 2009 +0200

    time: Prevent 32 bit overflow with set_normalized_timespec()
    
    set_normalized_timespec() nsec argument is of type long. The recent
    timekeeping changes of ktime_get_ts() feed
    
    	ts->tv_nsec + tomono.tv_nsec + nsecs
    
    to set_normalized_timespec(). On 32 bit machines that sum can be
    larger than (1 << 31) and therefor result in a negative value which
    screws up the result completely.
    
    Make the nsec argument of set_normalized_timespec() s64 to fix the
    problem at hand. This also prevents similar problems for future users
    of set_normalized_timespec().
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Tested-by: Carsten Emde <carsten.emde@osadl.org>
    LKML-Reference: <new-submission>
    Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
    Cc: John Stultz <johnstul@us.ibm.com>

diff --git a/include/linux/time.h b/include/linux/time.h
index 256232f..56787c0 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -75,7 +75,7 @@ extern unsigned long mktime(const unsigned int year, const unsigned int mon,
 			    const unsigned int day, const unsigned int hour,
 			    const unsigned int min, const unsigned int sec);
 
-extern void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec);
+extern void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec);
 extern struct timespec timespec_add_safe(const struct timespec lhs,
 					 const struct timespec rhs);
 
diff --git a/kernel/time.c b/kernel/time.c
index 2951194..2e2e469 100644
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -370,13 +370,20 @@ EXPORT_SYMBOL(mktime);
  *	0 <= tv_nsec < NSEC_PER_SEC
  * For negative values only the tv_sec field is negative !
  */
-void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec)
+void set_normalized_timespec(struct timespec *ts, time_t sec, s64 nsec)
 {
 	while (nsec >= NSEC_PER_SEC) {
+		/*
+		 * The following asm() prevents the compiler from
+		 * optimising this loop into a modulo operation. See
+		 * also __iter_div_u64_rem() in include/linux/time.h
+		 */
+		asm("" : "+rm"(nsec));
 		nsec -= NSEC_PER_SEC;
 		++sec;
 	}
 	while (nsec < 0) {
+		asm("" : "+rm"(nsec));
 		nsec += NSEC_PER_SEC;
 		--sec;
 	}
--8323328-1144428061-1255359771=:9428--
