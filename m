From: Juerg Haefliger <juergh@gmail.com>
Subject: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Tue, 2 Dec 2014 12:09:47 +0100
Message-ID: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:65204 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbaLBLJs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Dec 2014 06:09:48 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so27635351wiw.13
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Dec 2014 03:09:47 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT experts,

I have a simple test that runs two iperf clients in parallel with the
ltp network tests and it triggers a deadlock within a few minutes.
This is 100% repeatable. I've tried this on different RT kernels and
determined that prior to the following commit (which went into 3.10
upstream), the machine doesn't deadlock and seems to run just fine:

fb52f40e085ef4074f1335672cd62c1f832af13b rtmutex: Handle deadlock
detection smarter

I've reverted part of the above commit in v3.14.23-rt20 and now that
kernel also runs through the test. Specifically, I've applied:

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6c40660..0fff32a 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -471,7 +471,7 @@ static int rt_mutex_adjust_prio_chain(struct
task_struct *task,
        if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
                debug_rt_mutex_deadlock(deadlock_detect, orig_waiter, lock);
                raw_spin_unlock(&lock->wait_lock);
-               ret = -EDEADLK;
+               ret = deadlock_detect ? -EDEADLK : 0;
                goto out_unlock_pi;
        }

Not being an expert, I'm wondering if this is a false deadlock detection?


Trying to track this down, I added the following debugging statement:

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6c40660..e979aa9 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -994,6 +994,10 @@ static void  noinline __sched
rt_spin_lock_slowlock(struct rt_mutex *lock)
        pi_unlock(&self->pi_lock);

        ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
+        if (unlikely(ret)) {
+          debug_rt_mutex_print_deadlock(&waiter);
+        }
+
        BUG_ON(ret);

        for (;;) {

And the result (without the 'fix') is:

============================================
[   71.436289] [ BUG: circular locking deadlock detected! ]
[   71.436291] Not tainted
[   71.436292] --------------------------------------------
[   71.436295] iperf/4007 is deadlocking current task irq/111-eth1-q5/1698

[   71.436296]
1) irq/111-eth1-q5/1698 is trying to acquire this lock:
[   71.436299]  [ffff880e966b4000] {&(&base->lock)->lock}
[   71.436301]
2) iperf/4007 is blocked on this lock:
[   71.436302]  [ffff88103ca00070] {&(&(sk)->sk_lock.slock)->lock}
[   71.436303] .. ->owner: ffff88103bbc4d61
[   71.436307] .. held by:   irq/111-eth1-q5: 1698 [ffff88103bbc4d60,  49]
[   71.436308] INFO: lockdep is turned off.
[   71.436308] INFO: lockdep is turned off.
[   71.436309]
iperf/4007's [blocked] stackdump:

[   71.436317]  ffff88068f575c60 0000000000000000 ffff88103bbc4d60
0000000000000501
[   71.436326]  0000000000000000 0000000000000000 0000000000000001
ffff8806926957c8
[   71.436331]  ffff880692695790 0000000000000001 0000000000000286
ffffffffffffff10
[   71.436332] Call Trace:
[   71.436342]  [<ffffffff815552a0>] ? retint_kernel+0x20/0x30
[   71.436350]  [<ffffffff81552aaa>] ? rt_spin_lock_slowlock+0x27a/0x330
[   71.436353]  [<ffffffff81552a50>] ? rt_spin_lock_slowlock+0x220/0x330
[   71.436358]  [<ffffffff8155447c>] rt_spin_lock+0x2c/0x60
[   71.436364]  [<ffffffff8142d371>] lock_sock_nested+0x41/0xa0
[   71.436370]  [<ffffffff8149208c>] tcp_sendmsg+0x2c/0xd90
[   71.436376]  [<ffffffff81090e4d>] ? get_parent_ip+0xd/0x50
[   71.436381]  [<ffffffff81559185>] ? preempt_count_add+0x55/0xb0
[   71.436385]  [<ffffffff810acb3b>] ? get_lock_stats+0x2b/0x60
[   71.436388]  [<ffffffff810acb7e>] ? put_lock_stats.isra.21+0xe/0x30
[   71.436394]  [<ffffffff814c05e1>] ? inet_sendmsg+0x81/0xf0
[   71.436397]  [<ffffffff814c0621>] inet_sendmsg+0xc1/0xf0
[   71.436401]  [<ffffffff814c0565>] ? inet_sendmsg+0x5/0xf0
[   71.436409]  [<ffffffff81429940>] sock_aio_write+0x110/0x140
[   71.436415]  [<ffffffff811c817a>] do_sync_write+0x5a/0x90
[   71.436418]  [<ffffffff811c8a95>] vfs_write+0x1c5/0x1e0
[   71.436422]  [<ffffffff811c93b9>] SyS_write+0x49/0xb0
[   71.436427]  [<ffffffff8155d869>] system_call_fastpath+0x16/0x1b
[   71.436430]
irq/111-eth1-q5/1698's [current] stackdump:

[   71.436432] CPU: 22 PID: 1698 Comm: irq/111-eth1-q5 Not tainted
3.14.23-rt20+ #3
[   71.436435] Hardware name: HP ProLiant BL460c Gen8, BIOS I31 12/20/2013
[   71.436443]  ffff880692694d60 ffff880e90c3d720 ffffffff8154eb68
ffff880e90c3d780
[   71.436452]  ffff880e90c3d750 ffffffff810b8693 ffffffff810b84a8
ffff880e90c3d780
[   71.436458]  ffff88103bbc56c8 ffff88103bbc4d60 ffff880e90c3d810
ffffffff81552b08
[   71.436459] Call Trace:
[   71.436462]  [<ffffffff8154eb68>] dump_stack+0x4e/0x7a
[   71.436467]  [<ffffffff810b8693>] debug_rt_mutex_print_deadlock+0x203/0x240
[   71.436470]  [<ffffffff810b84a8>] ? debug_rt_mutex_print_deadlock+0x18/0x240
[   71.436472]  [<ffffffff81552b08>] rt_spin_lock_slowlock+0x2d8/0x330
[   71.436475]  [<ffffffff8155447c>] rt_spin_lock+0x2c/0x60
[   71.436481]  [<ffffffff81064fd7>] lock_timer_base.isra.33+0x37/0x70
[   71.436486]  [<ffffffff81067665>] mod_timer+0x75/0x2a0
[   71.436490]  [<ffffffff8142dc98>] sk_reset_timer+0x18/0x30
[   71.436494]  [<ffffffff8149afbb>] tcp_rearm_rto+0x6b/0xc0
[   71.436498]  [<ffffffff8149e67d>] tcp_event_new_data_sent+0x6d/0x70
[   71.436501]  [<ffffffff814a0362>] tcp_write_xmit+0x1c2/0xba0
[   71.436505]  [<ffffffff8149df7b>] ? tcp_established_options+0x3b/0xe0
[   71.436508]  [<ffffffff814a100e>] __tcp_push_pending_frames+0x2e/0xa0
[   71.436512]  [<ffffffff8149c72a>] tcp_rcv_established+0x11a/0x680
[   71.436517]  [<ffffffff814a75a6>] tcp_v4_do_rcv+0x1a6/0x640
[   71.436520]  [<ffffffff814a9e07>] tcp_v4_rcv+0xb77/0xc50
[   71.436526]  [<ffffffff8148041e>] ? ip_local_deliver_finish+0x3e/0x380
[   71.436529]  [<ffffffff814804c8>] ip_local_deliver_finish+0xe8/0x380
[   71.436534]  [<ffffffff8148041e>] ? ip_local_deliver_finish+0x3e/0x380
[   71.436537]  [<ffffffff81481068>] ip_local_deliver+0x48/0x80
[   71.436540]  [<ffffffff81480810>] ip_rcv_finish+0xb0/0x770
[   71.436543]  [<ffffffff8148131f>] ip_rcv+0x27f/0x380
[   71.436547]  [<ffffffff8144619a>] __netif_receive_skb_core+0x4da/0x990
[   71.436551]  [<ffffffff81445dd5>] ? __netif_receive_skb_core+0x115/0x990
[   71.436554]  [<ffffffff81446666>] __netif_receive_skb+0x16/0x70
[   71.436558]  [<ffffffff814466e3>] netif_receive_skb_internal+0x23/0x100
[   71.436562]  [<ffffffff81447338>] napi_gro_frags+0xf8/0x170
[   71.436572]  [<ffffffffa001f692>] be_process_rx+0x2c2/0x800 [be2net]
[   71.436578]  [<ffffffffa001fec0>] be_poll+0x2f0/0x410 [be2net]
[   71.436581]  [<ffffffff81446c49>] net_rx_action+0x1d9/0x310
[   71.436584]  [<ffffffff8105cd1c>] do_current_softirqs+0x27c/0x510
[   71.436589]  [<ffffffff810c81c0>] ? irq_thread_fn+0x50/0x50
[   71.436591]  [<ffffffff8105d03d>] __local_bh_enable+0x8d/0xb0
[   71.436594]  [<ffffffff8105d06e>] local_bh_enable+0xe/0x10
[   71.436597]  [<ffffffff810c8201>] irq_forced_thread_fn+0x41/0x70
[   71.436599]  [<ffffffff810c87ef>] irq_thread+0x12f/0x180
[   71.436602]  [<ffffffff810c8260>] ? wake_threads_waitq+0x30/0x30
[   71.436604]  [<ffffffff810c86c0>] ? irq_thread_check_affinity+0xb0/0xb0
[   71.436609]  [<ffffffff810801eb>] kthread+0xeb/0x110
[   71.436612]  [<ffffffff81080100>] ? kthread_create_on_node+0x230/0x230
[   71.436615]  [<ffffffff8155d7bc>] ret_from_fork+0x7c/0xb0
[   71.436617]  [<ffffffff81080100>] ? kthread_create_on_node+0x230/0x230
[   71.436619] INFO: lockdep is turned off.
[   71.436620] [ turning off deadlock detection.Please report this trace. ]

[   71.436631] ------------[ cut here ]------------
[   71.436632] kernel BUG at /root/linux-rt/kernel/locking/rtmutex.c:1000!
[   71.436636] invalid opcode: 0000 [#1] PREEMPT SMP
[   71.436732] Modules linked in: ib_iser rdma_cm iw_cm ib_cm ib_sa
ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp ip6table_filter
ip6_tables ipt_REJECT xt_conntrack iptable_filter xt_CHECKSUM
xt_tcpudp iptable_mangle ipt_MASQUERADE iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack ip_tables x_tables
dm_multipath scsi_dh dm_mod tun openvswitch gre libcrc32c
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel aes_x86_64
lrw gf128mul glue_helper ablk_helper cryptd evdev iTCO_wdt mgag200
iTCO_vendor_support ttm drm_kms_helper drm psmouse serio_raw agpgart
i2c_algo_bit syscopyarea sysfillrect sb_edac sysimgblt edac_core
mlx4_en mlx4_core hpwdt i2c_core hpilo ioatdma lpc_ich ptp pps_core
mfd_core dca ipmi_si ipmi_msghandler
[   71.436750]  video wmi acpi_power_meter button processor ext4 crc16
mbcache jbd2 be2iscsi iscsi_boot_sysfs sd_mod crc_t10dif
crct10dif_common sg uhci_hcd ehci_pci ehci_hcd usbcore usb_common
libiscsi hpsa scsi_transport_iscsi scsi_mod be2net thermal thermal_sys
[   71.436751] CPU: 22 PID: 1698 Comm: irq/111-eth1-q5 Not tainted
3.14.23-rt20+ #3
[   71.436752] Hardware name: HP ProLiant BL460c Gen8, BIOS I31 12/20/2013
[   71.436754] task: ffff88103bbc4d60 ti: ffff880e90c3c000 task.ti:
ffff880e90c3c000
[   71.436757] RIP: 0010:[<ffffffff81552b08>]  [<ffffffff81552b08>]
rt_spin_lock_slowlock+0x2d8/0x330
[   71.436758] RSP: 0000:ffff880e90c3d760  EFLAGS: 00010282
[   71.436759] RAX: 000000000000003d RBX: ffff880e90c3d780 RCX: 0000000000000000
[   71.436760] RDX: 0000000000005a4e RSI: 0000000000000001 RDI: 0000000000000246
[   71.436761] RBP: ffff880e90c3d810 R08: 000000000000003d R09: 000000000000004d
[   71.436762] R10: 0000000000000000 R11: 000000000001e254 R12: ffff88103bbc56c8
[   71.436763] R13: ffff88103bbc4d60 R14: ffff880e90c3d878 R15: ffff880e966b4000
[   71.436764] FS:  0000000000000000(0000) GS:ffff88081d800000(0000)
knlGS:0000000000000000
[   71.436765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.436766] CR2: 00007f867e134d2c CR3: 000000103ea15000 CR4: 00000000000407e0
[   71.436768] Stack:
[   71.436773]  ffff880e90c3d780 0000000000000006 ffff880e96047000
ffff88069ae114e8
[   71.436778]  0000000000000001 0000000000000000 0000000000000000
ffff880e90c3d798
[   71.436782]  0000000000000000 0000000000000000 ffff88103bbc4d60
ffff880e966b4000
[   71.436783] Call Trace:
[   71.436786]  [<ffffffff8155447c>] rt_spin_lock+0x2c/0x60
[   71.436789]  [<ffffffff81064fd7>] lock_timer_base.isra.33+0x37/0x70
[   71.436792]  [<ffffffff81067665>] mod_timer+0x75/0x2a0
[   71.436795]  [<ffffffff8142dc98>] sk_reset_timer+0x18/0x30
[   71.436798]  [<ffffffff8149afbb>] tcp_rearm_rto+0x6b/0xc0
[   71.436801]  [<ffffffff8149e67d>] tcp_event_new_data_sent+0x6d/0x70
[   71.436804]  [<ffffffff814a0362>] tcp_write_xmit+0x1c2/0xba0
[   71.436806]  [<ffffffff8149df7b>] ? tcp_established_options+0x3b/0xe0
[   71.436809]  [<ffffffff814a100e>] __tcp_push_pending_frames+0x2e/0xa0
[   71.436812]  [<ffffffff8149c72a>] tcp_rcv_established+0x11a/0x680
[   71.436815]  [<ffffffff814a75a6>] tcp_v4_do_rcv+0x1a6/0x640
[   71.436818]  [<ffffffff814a9e07>] tcp_v4_rcv+0xb77/0xc50
[   71.436821]  [<ffffffff8148041e>] ? ip_local_deliver_finish+0x3e/0x380
[   71.436836]  [<ffffffff814804c8>] ip_local_deliver_finish+0xe8/0x380
[   71.436841]  [<ffffffff8148041e>] ? ip_local_deliver_finish+0x3e/0x380
[   71.436846]  [<ffffffff81481068>] ip_local_deliver+0x48/0x80
[   71.436851]  [<ffffffff81480810>] ip_rcv_finish+0xb0/0x770
[   71.436855]  [<ffffffff8148131f>] ip_rcv+0x27f/0x380
[   71.436862]  [<ffffffff8144619a>] __netif_receive_skb_core+0x4da/0x990
[   71.436867]  [<ffffffff81445dd5>] ? __netif_receive_skb_core+0x115/0x990
[   71.436872]  [<ffffffff81446666>] __netif_receive_skb+0x16/0x70
[   71.436877]  [<ffffffff814466e3>] netif_receive_skb_internal+0x23/0x100
[   71.436883]  [<ffffffff81447338>] napi_gro_frags+0xf8/0x170
[   71.436894]  [<ffffffffa001f692>] be_process_rx+0x2c2/0x800 [be2net]
[   71.436905]  [<ffffffffa001fec0>] be_poll+0x2f0/0x410 [be2net]
[   71.436910]  [<ffffffff81446c49>] net_rx_action+0x1d9/0x310
[   71.436927]  [<ffffffff8105cd1c>] do_current_softirqs+0x27c/0x510
[   71.436930]  [<ffffffff810c81c0>] ? irq_thread_fn+0x50/0x50
[   71.436932]  [<ffffffff8105d03d>] __local_bh_enable+0x8d/0xb0
[   71.436935]  [<ffffffff8105d06e>] local_bh_enable+0xe/0x10
[   71.436937]  [<ffffffff810c8201>] irq_forced_thread_fn+0x41/0x70
[   71.436939]  [<ffffffff810c87ef>] irq_thread+0x12f/0x180
[   71.436942]  [<ffffffff810c8260>] ? wake_threads_waitq+0x30/0x30
[   71.436944]  [<ffffffff810c86c0>] ? irq_thread_check_affinity+0xb0/0xb0
[   71.436947]  [<ffffffff810801eb>] kthread+0xeb/0x110
[   71.436950]  [<ffffffff81080100>] ? kthread_create_on_node+0x230/0x230
[   71.436953]  [<ffffffff8155d7bc>] ret_from_fork+0x7c/0xb0
[   71.436956]  [<ffffffff81080100>] ? kthread_create_on_node+0x230/0x230
[   71.436998] Code: e8 5e 14 b6 ff e8 19 af b7 ff 8b 85 58 ff ff ff
85 c0 0f 85 9b fe ff ff e9 2b fe ff ff 66 0f 1f 44 00 00 48 89 df e8
88 59 b6 ff <0f> 0b 66 0f 1f 44 00 00 31 c0 eb b0 0f 1f 40 00 0f 0b 66
0f 1f
[   71.437002] RIP  [<ffffffff81552b08>] rt_spin_lock_slowlock+0x2d8/0x330
[   71.437002]  RSP <ffff880e90c3d760>


Added lots of tracing and here is the sequence of events that lead to
the deadlock:

mutex A is free
mutex B is free

eth1: acquires mutex B (rt_spin_lock_nested)

iperf: wants to acquire mutex B (rt_spin_lock)
  iperf: blocks on rtmutex (mutex B, owner eth1)
    iperf: enqueue iperf on mutex B
    iperf: top waiter of mutex B is iperf
    iperf: enqueue_pi iperf on eth1
    iperf: chain_walk = 0
  iperf: for (;;)
    iperf: __try_to_take_rt_mutex(mutex B, owner eth1)

At this point iperf is in a tight loop trying to take mutex B

iperf: receives an smp_apic_timer_interrupt (which yankes it out of
the previous for (;;) loop)
  iperf: acquires mutex A (rt_spin_trylock)

eth1: wants to acquire mutex A (rt_spin_lock)
  eth1: gets wait_lock of mutex A
  eth1: blocks on rtmutex (mutex A, owner iperf)

iperf: tries to release mutex A (rt_spin_unlock_after_trylock_in_irq)
  iperf: spins on trying to get wait_lock of mutex A (in
rt_spin_lock_slowunlock_hirq)

    eth1: enqueue eth1 on mutex A
    eth1: top waiter of mutex A is eth1
    eth1: enqueue_pi eth1 on iperf
    eth1: adjust prio of iperf from 120 to 49
    eth1: iperf is blocked on mutex B
    eth1: chain_walk = 1
    eth1: releases wait_lock of mutex A

  iperf: gets wait_lock of mutex A
    iperf: __rt_spin_lock_slowunlock mutex A

    eth1: rt_mutex_adjust_prio_chain(task=iperf, orig_lock=mutex A,
next_lock=mutex B, orig_waiter=eth1,mutex A, top_task=eth1)
      eth1: waiter is iperf,mutex B
      eth1: lock is mutex B
      eth1: raw_spin_trylock mutex B
      eth1: rt_mutex_owner(mutex B) == eth1 ---> -EDEADLOCK

Does that make sense? Please let me know if I need to provide more
info. I have detailed ftrace and crash dumps that I could provided if
need be.
Is this a 'real' problem or is the above fix (ignore the deadlock) sufficient?

Thanks
...Juerg
