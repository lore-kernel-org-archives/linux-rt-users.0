From: Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Sun, 20 Aug 2017 16:48:24 +0200
Message-ID: <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:48806 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbdHTOs2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 20 Aug 2017 10:48:28 -0400
In-Reply-To: <20170818124406.6cem4po52xrzi5qc@linutronix.de>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-18 14:44, Sebastian Andrzej Siewior wrote:
> On 2017-08-14 20:03:26 [+0200], Jacek Konieczny wrote:
>> On 2017-08-07 15:19, Sebastian Andrzej Siewior wrote:
>>> One thing you could try, is to see if the latest v4.11 based RT kernel
>>> works more reliable.
>>
>> I tried 4.11.12-rt9 (with your patch applied, just in case). It worked
>> find for a day and then failed like the older kernels:
> 
> I see. Could you try to enable lockdep and see if it yell in dmesg?
> lockdep would be:
> 	CONFIG_DEBUG_RT_MUTEXES=y
> 	CONFIG_PROVE_LOCKING=y
> 	CONFIG_DEBUG_ATOMIC_SLEEP=y

Sure. I have recompiled the kernel with those settings, and got this:


======================================================
[ INFO: possible circular locking dependency detected ]
4.11.12-rt9-1 #3 Not tainted
-------------------------------------------------------
zabbix_agentd/1299 is trying to acquire lock:
 (&per_cpu(local_softirq_locks[i], __cpu).lock){+.+...}, at:
[<ffffffff8a06e1ed>] do_current_softirqs+0x14d/0x670

                              but task is already holding lock:
 ((tcp_sk_lock).lock){+.+...}, at: [<ffffffff8a65eab1>]
tcp_v4_send_reset+0x3b1/0x7d0

                              which lock already depends on the new lock.

                              the existing dependency chain (in reverse
order) is:

                              -> #1 ((tcp_sk_lock).lock){+.+...}:
       lock_acquire+0xb7/0x250
       rt_spin_lock+0x4b/0x60
       tcp_v4_send_reset+0x3b1/0x7d0
       tcp_v4_rcv+0x7c0/0xfb0
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
       ip_queue_xmit+0x1e8/0x5e0
       tcp_transmit_skb+0x4ce/0x9e0
       tcp_connect+0x658/0x9f0
       tcp_v4_connect+0x56e/0x5b0
       __inet_stream_connect+0xb7/0x320
       inet_stream_connect+0x3b/0x60
       SyS_connect+0xe1/0x120
       do_syscall_64+0x7f/0x210
       return_from_SYSCALL_64+0x0/0x7a

                              -> #0 (&per_cpu(local_softirq_locks[i],
__cpu).lock){+.+...}:
       __lock_acquire+0x1b84/0x1d30
       lock_acquire+0xb7/0x250
       rt_spin_lock+0x4b/0x60
       do_current_softirqs+0x14d/0x670
       __local_bh_enable+0x5b/0x80
       tcp_v4_send_reset+0x48b/0x7d0
       tcp_v4_do_rcv+0x73/0x200
       __release_sock+0x86/0x160
       release_sock+0x35/0xc0
       inet_shutdown+0x86/0x100
       SyS_shutdown+0x84/0x90
       do_syscall_64+0x7f/0x210
       return_from_SYSCALL_64+0x0/0x7a

                              other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock((tcp_sk_lock).lock);
                               lock(&per_cpu(local_softirq_locks[i],
__cpu).lock);
                               lock((tcp_sk_lock).lock);
  lock(&per_cpu(local_softirq_locks[i], __cpu).lock);

                               *** DEADLOCK ***
3 locks held by zabbix_agentd/1299:
 #0:  (sk_lock-AF_INET){+.+.+.}, at: [<ffffffff8a67d45b>]
inet_shutdown+0x3b/0x100
 #1:  (rcu_read_lock){......}, at: [<ffffffff8a65e834>]
tcp_v4_send_reset+0x134/0x7d0
 #2:  ((tcp_sk_lock).lock){+.+...}, at: [<ffffffff8a65eab1>]
tcp_v4_send_reset+0x3b1/0x7d0

                              stack backtrace:
CPU: 1 PID: 1299 Comm: zabbix_agentd Not tainted 4.11.12-rt9-1 #3
Hardware name: Acer Aspire E5-575/Ironman_SK  , BIOS V1.25 03/03/2017
Call Trace:
 dump_stack+0x68/0x92
 print_circular_bug+0x1f6/0x300
 __lock_acquire+0x1b84/0x1d30
 ? preempt_count_sub+0xa1/0x100
 lock_acquire+0xb7/0x250
 ? lock_acquire+0xb7/0x250
 ? do_current_softirqs+0x14d/0x670
 rt_spin_lock+0x4b/0x60
 ? do_current_softirqs+0x14d/0x670
 do_current_softirqs+0x14d/0x670
 ? __local_bh_enable+0x23/0x80
 __local_bh_enable+0x5b/0x80
 tcp_v4_send_reset+0x48b/0x7d0
 ? tcp_rcv_state_process+0x28c/0xf20
 tcp_v4_do_rcv+0x73/0x200
 ? tcp_v4_do_rcv+0x73/0x200
 __release_sock+0x86/0x160
 release_sock+0x35/0xc0
 inet_shutdown+0x86/0x100
 SyS_shutdown+0x84/0x90
 do_syscall_64+0x7f/0x210
 entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x7fbaa1dbbb57
RSP: 002b:00007ffd750de028 EFLAGS: 00000202 ORIG_RAX: 0000000000000030
RAX: ffffffffffffffda RBX: 00007ffd750de0b0 RCX: 00007fbaa1dbbb57
RDX: 00000000ffffffff RSI: 0000000000000002 RDI: 0000000000000007
RBP: 00000000006671f8 R08: 0000000000995de0 R09: 0000000000000000
R10: 00007fbaa206ebe8 R11: 0000000000000202 R12: 000000000044afb0
R13: 00000000006607dc R14: 00000000006615e0 R15: 00007ffd750de070

Does this help?

The system has not crashed yet, I may catch something more.

Jacek
