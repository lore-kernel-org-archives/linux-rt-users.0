From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [ANNOUNCE] RT for v2.6.34.8 now available.
Date: Sun, 06 Mar 2011 22:51:28 -0800
Message-ID: <4D748070.1030502@localhost>
References: <4D71668F.9050201@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-kernel@vger.kernel.org, lwn@lwn.net
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.Stanford.EDU ([171.67.219.82]:38097 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751499Ab1CGHBm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Mar 2011 02:01:42 -0500
In-Reply-To: <4D71668F.9050201@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/04/2011 02:24 PM, Paul Gortmaker wrote:
> As a value add to the 2.6.34 long term release, I'm happy to also
> announce the availability of 2.6.34-RT.
>
> You can find it in the v2.6.34-rt branch at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/rt-patches.git

Great! Many thanks... Actually, impressive work.

I'm trying to integrate/build it into my Fedora based rt packages for 
Planet CCRMA. Warning: I'm doing this on top of the 2.6.34.8-68 fc13 
koji build, so rt is patched on top of the additional Fedora patches for 
that build (with a few trivial tweaks to patch cleanly). So I don't know 
if the following issues are due to that - I will investigate:

I found a couple of extra argument cases for __netif_tx_lock:

--- a/drivers/net/qlcnic/qlcnic_main.c	2010-05-16 17:17:36.000000000 -0400
+++ b/drivers/net/qlcnic/qlcnic_main.c	2011-03-06 20:08:16.000000000 -0500
@@ -1881,7 +1881,7 @@
  		smp_mb();

  		if (netif_queue_stopped(netdev) && netif_carrier_ok(netdev)) {
-			__netif_tx_lock(tx_ring->txq, smp_processor_id());
+			__netif_tx_lock(tx_ring->txq);
  			if (qlcnic_tx_avail(tx_ring) > TX_STOP_THRESH) {
  				netif_wake_queue(netdev);
  				adapter->tx_timeo_cnt = 0;
--- a/drivers/net/bnx2x_main.c	2010-05-16 17:17:36.000000000 -0400
+++ b/drivers/net/bnx2x_main.c	2011-03-06 19:58:45.000000000 -0500
@@ -976,7 +976,7 @@
  		 * stops the queue
  		 */

-		__netif_tx_lock(txq, smp_processor_id());
+		__netif_tx_lock(txq);

  		if ((netif_tx_queue_stopped(txq)) &&
  		    (bp->state == BNX2X_STATE_OPEN) &&
----

a missing include (incomplete type errors for semaphores):

--- a/drivers/net/mlx4/mlx4.h	2010-05-16 17:17:36.000000000 -0400
+++ b/drivers/net/mlx4/mlx4.h	2011-03-06 20:07:05.000000000 -0500
@@ -37,6 +37,7 @@
  #ifndef MLX4_H
  #define MLX4_H

+#include <linux/semaphore.h>
  #include <linux/mutex.h>
  #include <linux/radix-tree.h>
  #include <linux/timer.h>
----

and this (found compilation fix here:
http://groups.google.com/group/linux.kernel/browse_thread/thread/c4f0fd1ca9298c45/18316184209e6e84?show_docid=18316184209e6e84&fwc=1):

--- a/drivers/net/wireless/ath/ar9170/usb.c	2011-03-06 
19:13:12.000000000 -0500
+++ b/drivers/net/wireless/ath/ar9170/usb.c	2011-03-06 
20:13:06.000000000 -0500
@@ -741,10 +741,10 @@

  	/* unbind anything failed */
  	if (parent)
-		down(&parent->sem);
+		device_lock(parent);
  	device_release_driver(&aru->udev->dev);
  	if (parent)
-		up(&parent->sem);
+		device_unlock(parent);

  	usb_put_dev(aru->udev);
  }
----

I'll let you know how it goes (light testing probably tomorrow, still 
building).

-- Fernando "patiently waiting for 2.6.37-rtx"
:-)
