From: Frank Rowand <frank.rowand@am.sony.com>
Subject: [PATCH RT 0/2][RFC] fix RCU stall warning on ARM
Date: Tue, 4 Dec 2012 20:47:22 -0800
Message-ID: <50BED1DA.7070907@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<tglx@linutronix.de>, <paulmck@linux.vnet.ibm.com>,
	<dipankar@in.ibm.com>, <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [65.55.88.11] ([65.55.88.11]:5096 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753507Ab2LEEs0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Dec 2012 23:48:26 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The RCU stall warning functions call trigger_all_cpu_backtrace()
to print a backtrace on each cpu.  This function is only
implemented for x86.  Add a version for ARM.

With CONFIG_PREEMPT_RT_FULL enabled, flushing the output from
printk() is inhibited in some contexts to avoid increasing
real time latencies.  The RCU stall warnings are inhibited
on ARM due to this feature.  (I have not tested whether this
is also the case on other architectures.)  Add back the
oops_in_progress flag to allow the RCU stall warnings to
print immediately.

A third patch contains test scaffolding to force the stall
warnings to occur so that the other patches can be tested.
The third patch should __not__ added to the mainline
RT PREEMPT patch tree.

These patches apply to 3.6.7-rt18.  They do not apply
cleanly to 3.0.xx.

