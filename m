From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] clockevents: Reinstate the per cpu tick skew
Date: Wed, 28 Dec 2011 10:59:48 +0100
Message-ID: <1325066388.4726.85.camel@marge.simson.net>
References: <1324717569.5025.73.camel@marge.simson.net>
	 <1324968044.5217.103.camel@marge.simson.net>
	 <1324977605.5217.132.camel@marge.simson.net>
	 <1325049448.4726.16.camel@marge.simson.net>
	 <1325060550.4726.58.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>,
	Arjan van de Ven <arjan@linux.intel.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:54585 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752150Ab1L1J7x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Dec 2011 04:59:53 -0500
In-Reply-To: <1325060550.4726.58.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-12-28 at 09:22 +0100, Mike Galbraith wrote:

> (Hm, wonder if nohz is usable now... nope.  Tell nohz that isolated
> cores don't play balancer again, maybe it'll work now)

Yup, worked.  60 core jitter test is approaching single digit.  Woohoo.

---
 kernel/sched_fair.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/sched_fair.c
+++ b/kernel/sched_fair.c
@@ -4517,6 +4517,10 @@ void select_nohz_load_balancer(int stop_
 {
 	int cpu = smp_processor_id();
 
+	/* Isolated cores do not play */
+	if (!cpu_rq(cpu)->sd)
+		return;
+
 	if (stop_tick) {
 		if (!cpu_active(cpu)) {
 			if (atomic_read(&nohz.load_balancer) != cpu)



