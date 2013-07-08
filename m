From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: [RFC] igb: minimize busy loop on igb_get_hw_semaphore
Date: Mon, 8 Jul 2013 18:17:05 -0300
Message-ID: <20130708211705.GB9997@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmiss.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:38710 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3GHVRT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jul 2013 17:17:19 -0400
Received: by mail-qe0-f54.google.com with SMTP id ne12so2615819qeb.13
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Jul 2013 14:17:18 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

This patch was written to 3.0-rt but the same code path triggering the
issue exists up to 3.8.13-rt13. It was initially a test patch, to minimize
a problem observed by a customer, but it may be the starting point of a
needed solution.

Rostedt helped me to visualize this small patch on the early stages and
Clark Williams has been bugging me to send it out to the list in order
to gather ideas on how useful this small change really is.

As it is noted on the description, though the same code is present
upstream, it may be a problem only on RT.

----

igb: minimize busy loop on igb_get_hw_semaphore

Bugzilla: 976912

In drivers/net/igb/e1000_82575.c, funtion igb_release_swfw_sync_82575()
there is this line:

	while (igb_get_hw_semaphore(hw) != 0);

That is basically a busy loop waiting on a HW semaphore.

A customer has a setup where two igb NICs are part of a bonding interface.
This customer also has a monitoring script that calls ifconfig often. It was
observed that in this scenario there is a chance that this ifconfig, that
happens to hold the bond->lock while collecting statistics, enters this busy
loop waiting for another thread clear that HW semaphore.

Meanwhile, the irq/xxx-ethY-Tx threads, running at FIFO:85, try to acquire
the bond lock, held by ifconfig. As it happens on RT, a Priority Inheritance
operation is started and ifconfig is boosted to FIFO:85 so that it may be able
to finish its work sooner and release the bond->lock, desired by the
aforementioned threads.

As ifconfig is running on a busy loop, waiting for the HW semaphore, this
thread now runs a busy loop at a very high priority, preventing other threads
on that CPU from progressing.

On that scenario, it seems that the thread holding the HW semaphore is also
waiting for a lock held by other task. This whole scenario leads to RCU stall
warnings, that have as side effects a crescent number of threads being stuck.
As this progresses, the livelock reaches threads on other CPUs and the system
becomes more and more unresponsive.

This little patch aims to prevent the busy loop at a high priority (the code
called by ifconfig in this example) to starve the threads on the same CPU. It
may not solve the issue but will at least lead us closer to the real issue,
masked by the RCU stalls created by the busy loop.

This is mostly a debug patch for a testing kernel.

Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

diff --git a/drivers/net/igb/e1000_mac.c b/drivers/net/igb/e1000_mac.c
index ce8255f..0ca912c 100644
--- a/drivers/net/igb/e1000_mac.c
+++ b/drivers/net/igb/e1000_mac.c
@@ -1037,7 +1037,7 @@ s32 igb_get_hw_semaphore(struct e1000_hw *hw)
 		if (!(swsm & E1000_SWSM_SMBI))
 			break;
 
-		udelay(50);
+		usleep_range(50,51);
 		i++;
 	}
 
@@ -1056,7 +1056,7 @@ s32 igb_get_hw_semaphore(struct e1000_hw *hw)
 		if (rd32(E1000_SWSM) & E1000_SWSM_SWESMBI)
 			break;
 
-		udelay(50);
+		usleep_range(50,51);
 	}
 
 	if (i == timeout) {

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

