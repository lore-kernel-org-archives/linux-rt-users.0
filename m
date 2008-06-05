From: ciaby <ciaby@autistici.org>
Subject: Fwd: about 2.6.25.4-rt5 (missing =?UTF-8?Q?global=5Frt=5Fruntime=29?=
Date: Thu, 05 Jun 2008 12:45:08 +0000
Message-ID: <65fe1b04a31fa0c81601099af40b0787@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vilipendio.investici.org ([216.17.130.5]:65511 "EHLO
	vilipendio.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbYFENGA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Jun 2008 09:06:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Forgot this list... sorry :)



Ciaby



-------- Original Message --------

Subject: about 2.6.25.4-rt5 (missing global_rt_runtime)

Date: Thu, 05 Jun 2008 12:18:49 +0000

From: ciaby <ciaby@autistici.org>

To: rostedt@goodmis.org



Small patch to make it compile (missing global_rt_runtime function):



diff -uNr linux-2.6.25.4.orig/kernel/sched.c linux-2.6.25.4/kernel/sched.c

--- linux-2.6.25.4.orig/kernel/sched.c  2008-06-05 14:12:30.000000000 +0200

+++ linux-2.6.25.4/kernel/sched.c       2008-06-05 13:58:48.000000000 +0200

@@ -671,6 +671,15 @@

  */

 #define RUNTIME_INF    ((u64)~0ULL)



+static u64 global_rt_runtime(void)

+{

+       if (sysctl_sched_rt_period < 0)

+               return RUNTIME_INF;

+       return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;

+}

+

+

+

 /*

  * We really dont want to do anything complex within switch_to()

  * on PREEMPT_RT - this check enforces this.



