From: Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Wed, 23 Aug 2017 19:04:20 +0200
Message-ID: <52e67cfd-0bb3-ce97-7b28-f2afb1d3c1cb@jajcus.net>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
 <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
 <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:54736 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932271AbdHWREb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 Aug 2017 13:04:31 -0400
In-Reply-To: <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-21 15:12, Sebastian Andrzej Siewior wrote:
> On 2017-08-20 16:48:24 [+0200], Jacek Konieczny wrote:
>> Does this help?
> 
> yup, the following patch should make it go away.
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
[...]

I have applied the patch, no crash since then, but I got another problem
detected:


======================================================
[ INFO: possible circular locking dependency detected ]
4.11.12-rt9-1 #4 Not tainted
-------------------------------------------------------
irq/132-ath10k_/1008 is trying to acquire lock:
 ((icmp_sk_lock).lock){+.+...}, at: [<ffffffff92677264>]
icmp_send+0x144/0x7a0

                              but task is already holding lock:
 ((xt_write_lock).lock){+.+...}, at: [<ffffffffc059b256>]
ipt_do_table+0xd6/0x710 [ip_tables]

                              which lock already depends on the new lock.

                              the existing dependency chain (in reverse
order) is:

                              -> #1 ((xt_write_lock).lock){+.+...}:
       lock_acquire+0xb7/0x250
       rt_spin_lock+0x4b/0x60
       ipt_do_table+0xd6/0x710 [ip_tables]
       iptable_raw_hook+0x27/0x60 [iptable_raw]
       nf_hook_slow+0x2c/0xf0
       __ip_local_out+0x134/0x2e0
       ip_local_out+0x1c/0x70
       ip_send_skb+0x19/0x40
       ip_push_pending_frames+0x33/0x40
       icmp_push_reply+0xf5/0x130
       icmp_send+0x754/0x7a0
       __udp4_lib_rcv+0x927/0xc00
       udp_rcv+0x1a/0x20
       ip_local_deliver_finish+0xe4/0x3d0
       ip_local_deliver+0x1a7/0x220
       ip_rcv_finish+0x222/0x6e0
       ip_rcv+0x3aa/0x540
       __netif_receive_skb_core+0x790/0xdc0
       __netif_receive_skb+0x1d/0x60
       process_backlog+0x9f/0x270
       net_rx_action+0x389/0x6c0
       do_current_softirqs+0x22e/0x670
       __local_bh_enable+0x5b/0x80
       ip_finish_output2+0x2aa/0x5e0
       ip_finish_output+0x229/0x320
       ip_output+0x182/0x260
       ip_local_out+0x39/0x70
       ip_send_skb+0x19/0x40
       udp_send_skb+0x14d/0x280
       udp_sendmsg+0x364/0xb30
       inet_sendmsg+0x4a/0x1c0
       sock_sendmsg+0x38/0x50
       SyS_sendto+0x10a/0x190
       do_syscall_64+0x7f/0x210
       return_from_SYSCALL_64+0x0/0x7a

                              -> #0 ((icmp_sk_lock).lock){+.+...}:
       __lock_acquire+0x1b84/0x1d30
       lock_acquire+0xb7/0x250
       rt_spin_lock+0x4b/0x60
       icmp_send+0x144/0x7a0
       nf_send_unreach+0x97/0xa00 [nf_reject_ipv4]
       reject_tg+0x2b/0x96 [ipt_REJECT]
       ipt_do_table+0x353/0x710 [ip_tables]
       iptable_filter_hook+0x27/0x57 [iptable_filter]
       nf_hook_slow+0x2c/0xf0
       ip_local_deliver+0xfb/0x220
       ip_rcv_finish+0x222/0x6e0
       ip_rcv+0x3aa/0x540
       __netif_receive_skb_core+0x790/0xdc0
       __netif_receive_skb+0x1d/0x60
       netif_receive_skb_internal+0x7c/0x200
       napi_gro_receive+0x16b/0x210
       ieee80211_deliver_skb+0xe9/0x220 [mac80211]
       ieee80211_rx_handlers+0x1df8/0x2700 [mac80211]
       ieee80211_invoke_rx_handlers+0x155/0x750 [mac80211]
       ieee80211_prepare_and_rx_handle+0x586/0xb00 [mac80211]
       ieee80211_rx_napi+0x35a/0xc10 [mac80211]
       ath10k_htt_rx_h_deliver+0xae/0x120 [ath10k_core]
       ath10k_htt_rx_handle_amsdu+0x7c0/0x910 [ath10k_core]
       ath10k_htt_txrx_compl_task+0x61e/0x790 [ath10k_core]
       ath10k_pci_napi_poll+0x4a/0xf0 [ath10k_pci]
       net_rx_action+0x389/0x6c0
       do_current_softirqs+0x22e/0x670
       __local_bh_enable+0x5b/0x80
       irq_forced_thread_fn+0x55/0x70
       irq_thread+0x15e/0x200
       kthread+0x114/0x150
       ret_from_fork+0x27/0x40

                              other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock((xt_write_lock).lock);
                               lock((icmp_sk_lock).lock);
                               lock((xt_write_lock).lock);
  lock((icmp_sk_lock).lock);

                               *** DEADLOCK ***
6 locks held by irq/132-ath10k_/1008:
 #0:  (&per_cpu(local_softirq_locks[i], __cpu).lock){+.+...}, at:
[<ffffffff9206e1ed>] do_current_softirqs+0x14d/0x670
 #1:  (rcu_read_lock){......}, at: [<ffffffffc0b15762>]
ieee80211_rx_napi+0xb2/0xc10 [mac80211]
 #2:  (&local->rx_path_lock){+.+...}, at: [<ffffffffc0b11a60>]
ieee80211_rx_handlers+0x40/0x2700 [mac80211]
 #3:  (rcu_read_lock){......}, at: [<ffffffff925e138e>]
netif_receive_skb_internal+0x2e/0x200
 #4:  (rcu_read_lock){......}, at: [<ffffffff92636356>]
ip_local_deliver+0x66/0x220
 #5:  ((xt_write_lock).lock){+.+...}, at: [<ffffffffc059b256>]
ipt_do_table+0xd6/0x710 [ip_tables]

                              stack backtrace:
CPU: 0 PID: 1008 Comm: irq/132-ath10k_ Not tainted 4.11.12-rt9-1 #4
Hardware name: Acer Aspire E5-575/Ironman_SK  , BIOS V1.25 03/03/2017
Call Trace:
 dump_stack+0x68/0x92
 print_circular_bug+0x1f6/0x300
 __lock_acquire+0x1b84/0x1d30
 ? __this_cpu_preempt_check+0x13/0x20
 lock_acquire+0xb7/0x250
 ? lock_acquire+0xb7/0x250
 ? icmp_send+0x144/0x7a0
 rt_spin_lock+0x4b/0x60
 ? icmp_send+0x144/0x7a0
 icmp_send+0x144/0x7a0
 ? __this_cpu_preempt_check+0x13/0x20
 ? trace_hardirqs_on_caller+0xef/0x210
 ? preempt_count_sub+0xa1/0x100
 ? lock_acquire+0xb7/0x250
 ? ipt_do_table+0xd6/0x710 [ip_tables]
 nf_send_unreach+0x97/0xa00 [nf_reject_ipv4]
 reject_tg+0x2b/0x96 [ipt_REJECT]
 ipt_do_table+0x353/0x710 [ip_tables]
 iptable_filter_hook+0x27/0x57 [iptable_filter]
 nf_hook_slow+0x2c/0xf0
 ip_local_deliver+0xfb/0x220
 ? inet_del_offload+0x40/0x40
 ip_rcv_finish+0x222/0x6e0
 ip_rcv+0x3aa/0x540
 ? ip_local_deliver_finish+0x3d0/0x3d0
 __netif_receive_skb_core+0x790/0xdc0
 ? lock_acquire+0xb7/0x250
 ? __this_cpu_preempt_check+0x13/0x20
 ? netif_receive_skb_internal+0x2e/0x200
 __netif_receive_skb+0x1d/0x60
 netif_receive_skb_internal+0x7c/0x200
 napi_gro_receive+0x16b/0x210
 ieee80211_deliver_skb+0xe9/0x220 [mac80211]
 ieee80211_rx_handlers+0x1df8/0x2700 [mac80211]
 ieee80211_invoke_rx_handlers+0x155/0x750 [mac80211]
 ? __lock_acquire+0x516/0x1d30
 ieee80211_prepare_and_rx_handle+0x586/0xb00 [mac80211]
 ? sta_info_hash_lookup+0x13a/0x250 [mac80211]
 ieee80211_rx_napi+0x35a/0xc10 [mac80211]
 ? ath10k_htt_rx_h_mpdu+0x40d/0x840 [ath10k_core]
 ath10k_htt_rx_h_deliver+0xae/0x120 [ath10k_core]
 ? ath10k_htt_rx_h_ppdu+0xbe/0x2c0 [ath10k_core]
 ath10k_htt_rx_handle_amsdu+0x7c0/0x910 [ath10k_core]
 ? __lock_acquire+0x516/0x1d30
 ath10k_htt_txrx_compl_task+0x61e/0x790 [ath10k_core]
 ? _raw_spin_unlock_irqrestore+0x80/0x90
 ? __this_cpu_preempt_check+0x13/0x20
 ? __local_bh_enable+0x31/0x80
 ? __this_cpu_preempt_check+0x13/0x20
 ? trace_hardirqs_on_caller+0xef/0x210
 ? trace_hardirqs_on+0xd/0x10
 ? __local_bh_enable+0x31/0x80
 ? ath10k_ce_per_engine_service+0xc3/0xe0 [ath10k_pci]
 ath10k_pci_napi_poll+0x4a/0xf0 [ath10k_pci]
 net_rx_action+0x389/0x6c0
 ? trace_hardirqs_on_caller+0xef/0x210
 ? preempt_count_sub+0xa1/0x100
 do_current_softirqs+0x22e/0x670
 __local_bh_enable+0x5b/0x80
 irq_forced_thread_fn+0x55/0x70
 ? irq_thread+0xb7/0x200
 irq_thread+0x15e/0x200
 ? irq_finalize_oneshot.part.2+0xe0/0xe0
 ? wake_threads_waitq+0x30/0x30
 kthread+0x114/0x150
 ? irq_thread_dtor+0xc0/0xc0
 ? kthread_create_on_node+0x70/0x70
 ret_from_fork+0x27/0x40


Jacek
