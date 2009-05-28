From: John Connor <jconnor@gdrs.com>
Subject: network hanging on heavy load
Date: Thu, 28 May 2009 14:22:48 +0000 (UTC)
Message-ID: <loom.20090528T141638-240@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:33212 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759030AbZE1OZE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2009 10:25:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M9gXX-0006xM-2m
	for linux-rt-users@vger.kernel.org; Thu, 28 May 2009 14:25:03 +0000
Received: from mail.gdrs.com ([198.136.134.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 28 May 2009 14:25:03 +0000
Received: from jconnor by mail.gdrs.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 28 May 2009 14:25:03 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

can anyone explain this

kernel: INFO: task sirq-net-rx/0:8 blocked for more than 120 seconds.
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: sirq-net-rx/0 M (005) [f78660f0] c483b600 [on rq #0]     0     8      2
kernel:        f7852e44 00000046 c483b600 c483b600 00000001 00000078 41dd129d
0000015e 
kernel:        f78660f0 f7866384 c483b600 00000000 f7852000 c0445a58 f5f0e7a4
0000000a 
kernel:        00000000 00000000 c48389c0 f5f0e7a0 f7852e64 f5f0e338 f5f0e330
c48389c0 
kernel: Call Trace:
kernel:  [<c0445a58>] ? __rt_mutex_adjust_prio+0x19/0x1c
kernel:  [<c0632f85>] schedule+0xbf/0xd8
kernel:  [<c063439d>] rt_spin_lock_slowlock+0x134/0x1eb
kernel:  [<c06348c3>] __rt_spin_lock+0x5e/0x61
kernel:  [<c06348fe>] rt_spin_lock+0x38/0x3b
kernel:  [<c04832c5>] kfree+0x29/0x7b
kernel:  [<c05bdbdd>] skb_release_data+0x82/0x87
kernel:  [<c05be19b>] skb_release_all+0xab/0xae
kernel:  [<c05bda81>] __kfree_skb+0xb/0x66
kernel:  [<c05bdb0a>] kfree_skb+0x2e/0x30
kernel:  [<c05c451f>] dev_kfree_skb_any+0x40/0x42
kernel:  [<f8a54e8b>] e1000_put_txbuf+0x52/0x61 [e1000e]
kernel:  [<f8a54fed>] e1000_clean_tx_irq+0xae/0x288 [e1000e]
kernel:  [<c0421966>] ? finish_task_switch+0x4e/0xf0
kernel:  [<f8a55484>] e1000_clean+0x3e/0x1d7 [e1000e]
kernel:  [<c05c467d>] net_rx_action+0xa6/0x1af
kernel:  [<c042dfec>] ksoftirqd+0x155/0x239
kernel:  [<c042de97>] ? ksoftirqd+0x0/0x239
kernel:  [<c0439f63>] kthread+0x3b/0x64
kernel:  [<c0439f28>] ? kthread+0x0/0x64
kernel:  [<c0405803>] kernel_thread_helper+0x7/0x10
kernel:  =======================


