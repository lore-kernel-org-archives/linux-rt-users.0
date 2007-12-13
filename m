From: Gautham R Shenoy <ego@in.ibm.com>
Subject: [RFC PATCH 0/6] RCU: Preemptible-RCU
Date: Thu, 13 Dec 2007 22:33:49 +0530
Message-ID: <20071213170348.GA25981@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul E McKenney <paulmck@us.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ted Tso <tytso@us.ibm.com>, dvhltc@us.ibm.com,
	Oleg Nesterov <oleg@tv-sign.ru>,
	Andrew Morton <akpm@linux-foundation.org>, bunk@kernel.org,
	Josh Triplett <josh@freedesktop.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([59.145.155.6]:57871 "EHLO
	e28esmtp06.in.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751660AbXLMREM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 12:04:12 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everyone, 

This patchset is an updated version of the preemptible RCU patchset that
Paul McKenney had posted it in September earlier this year that can be
found here --> http://lkml.org/lkml/2007/9/10/213

This patchset incorporates the review comments from Oleg Nesterov
and Steven Rostedt.

The testing report of the patchset is as follows:
====================================================================
Patch-stack:  	2.6.23-rc3 + cpu-hotplug patches from 
		http://lkml.org/lkml/2007/11/15/239 + Preempt-RCU
		patches.
Test:		RCU-Torture running parallelly with CPU-Hotplug
		operations.
Duration:	24 hours.
Architectures:	x86,x86_64, ppc64.
====================================================================


Currently it is based against the latest linux-2.6-sched-devel.git

Awaiting your feedback!

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
