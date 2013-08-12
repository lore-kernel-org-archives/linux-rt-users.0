From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] igb: minimize busy loop on igb_get_hw_semaphore
Date: Mon, 12 Aug 2013 15:55:59 +0200
Message-ID: <20130812135559.GG23040@linutronix.de>
References: <20130708211705.GB9997@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmiss.org
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44412 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756420Ab3HLN4A (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 12 Aug 2013 09:56:00 -0400
Content-Disposition: inline
In-Reply-To: <20130708211705.GB9997@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2013-07-08 18:17:05 [-0300]:

>Hello,
Hi Lius,

>	while (igb_get_hw_semaphore(hw) != 0);
>
>That is basically a busy loop waiting on a HW semaphore.
>
>A customer has a setup where two igb NICs are part of a bonding interface.
>This customer also has a monitoring script that calls ifconfig often. It was
>observed that in this scenario there is a chance that this ifconfig, that
>happens to hold the bond->lock while collecting statistics, enters this busy
>loop waiting for another thread clear that HW semaphore.
>
>Meanwhile, the irq/xxx-ethY-Tx threads, running at FIFO:85, try to acquire
>the bond lock, held by ifconfig. As it happens on RT, a Priority Inheritance
>operation is started and ifconfig is boosted to FIFO:85 so that it may be able
>to finish its work sooner and release the bond->lock, desired by the
>aforementioned threads.
>
>As ifconfig is running on a busy loop, waiting for the HW semaphore, this
>thread now runs a busy loop at a very high priority, preventing other threads
>on that CPU from progressing.
>
>On that scenario, it seems that the thread holding the HW semaphore is also
>waiting for a lock held by other task. This whole scenario leads to RCU stall
>warnings, that have as side effects a crescent number of threads being stuck.
>As this progresses, the livelock reaches threads on other CPUs and the system
>becomes more and more unresponsive.

So you are saying someone is holding the lock and never gets on the CPU
in order to release the lock while in the meantime everyone gets boosted
to grab the lock and busy loops until you call it a day?

If so, then you should tell the locking code about the hw semaphore and that
it needs to boost the owner of the semaphore in order to get it
released. Something like this should do the job:

diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.h b/drivers/net/ethernet/intel/e1000/e1000_hw.h
index 11578c8..8b7299f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.h
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.h
@@ -1433,6 +1433,7 @@ struct e1000_hw {
 	bool leave_av_bit_off;
 	bool bad_tx_carr_stats_fd;
 	bool has_smbus;
+	spin_lock_t hwsem_lock;
 };
 
 #define E1000_EEPROM_SWDPIN0   0x0001	/* SWDPIN 0 EEPROM Value */
diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
index 2559d70..285cc81 100644
--- a/drivers/net/ethernet/intel/igb/e1000_mac.c
+++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
@@ -1198,6 +1198,8 @@ s32 igb_get_hw_semaphore(struct e1000_hw *hw)
 	s32 timeout = hw->nvm.word_size + 1;
 	s32 i = 0;
 
+	spin_lock(&hw->hwsem_lock);
+
 	/* Get the SW semaphore */
 	while (i < timeout) {
 		swsm = rd32(E1000_SWSM);
@@ -1235,6 +1237,8 @@ s32 igb_get_hw_semaphore(struct e1000_hw *hw)
 	}
 
 out:
+	if (ret_val)
+		spin_unlock(&hw->hwsem_lock);
 	return ret_val;
 }
 
@@ -1253,6 +1257,7 @@ void igb_put_hw_semaphore(struct e1000_hw *hw)
 	swsm &= ~(E1000_SWSM_SMBI | E1000_SWSM_SWESMBI);
 
 	wr32(E1000_SWSM, swsm);
+	spin_unlock(&hw->hwsem_lock);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 64cbe0d..4ae835a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2683,6 +2683,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
 	spin_lock_init(&adapter->stats64_lock);
+	spin_lock_init(&hw->hwsem_lock);
+
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
 	case e1000_82576:


So I don't even know if this compiles and the error code is wrong but I
think you get the idea:
Before you attempt to grab the hw semaphore you grab a lock. If the lock
is taken, then the semaphore is taken as well. In non-RT you spin on a
memory instead of IO-memory so I doubt somebody will complain :)
If you need to get the lock while it is taken and you are a high prio
thread then the code should boost the owner of the hw semaphore which it
knows now about.

Sebastian
