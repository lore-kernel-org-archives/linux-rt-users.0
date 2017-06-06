From: Feng Feng24 Liu <liufeng24@lenovo.com>
Subject: kernel BUG at kernel/locking/rtmutex.c:1027
Date: Tue, 6 Jun 2017 15:18:23 +0000
Message-ID: <2B18E8E1DDAE074A82D1060396451DAE263C772E@CNMAILEX04.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Tong Tong3 Li <litong3@lenovo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT experts,

I upgrate our kernel from kernel-3.10 to kernel4.4.6-rt14 in our environment.  But the RT kernel alway report deadlock.

I added the following debugging statement:

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

And the result is:

Following is the dmesg of the RT kernel:
[51893.656645] ============================================
[51893.656645] [ BUG: circular locking deadlock detected! ]
[51893.656646] Not tainted
[51893.656646] --------------------------------------------
[51893.656647] gmond/9537 is deadlocking current task gmetad/4455
[51893.656647] 
[51893.656648] 
[51893.656648] 1) gmetad/4455 is trying to acquire this lock:
[51893.656649]  [ffff88023fc8d340] {&(&base->lock)->lock}
[51893.656650] 
[51893.656650] 2) gmond/9537 is blocked on this lock:
[51893.656650]  [ffff880030fe6c08] {&(&(sk)->sk_lock.slock)->lock}
[51893.656651] .. ->owner: ffff8800b9c2bc01
[51893.656652] .. held by:            gmetad: 4455 [ffff8800b9c2bc00, 120]
[51893.656653] 
[51893.656653] gmond/9537's [blocked] stackdump:
[51893.656653] 
[51893.656655]  ffff8802157f7b28 ffff880216278c00 ffff880014c1c800 ffff8802157f8000
[51893.656656]  0000000000000000 ffff880014c1c800 ffff8800b9c2bc00 ffff880030fe6c08
[51893.656657]  ffff8802157f7b48 ffffffff81a7ae07 ffff8802157f7c30 0000000000000282
[51893.656658] Call Trace:
[51893.656665]  [<ffffffff81a7ae07>] preempt_schedule_irq+0x57/0xc0
[51893.656668]  [<ffffffff81a7e93b>] do_preempt_schedule_irq+0x5/0x7
[51893.656670]  [<ffffffff81a7c294>] ? rt_spin_lock_slowlock+0x2e4/0x3a0
[51893.656672]  [<ffffffff81a7c27f>] ? rt_spin_lock_slowlock+0x2cf/0x3a0
[51893.656674]  [<ffffffff81a7d93f>] rt_spin_lock+0x1f/0x30
[51893.656678]  [<ffffffff81866fc3>] lock_sock_nested+0x23/0x60
[51893.656680]  [<ffffffff818de576>] tcp_sendmsg+0x26/0xad0
[51893.656683]  [<ffffffff8190872f>] inet_sendmsg+0x7f/0xb0
[51893.656685]  [<ffffffff81864558>] sock_sendmsg+0x38/0x50
[51893.656686]  [<ffffffff818645eb>] sock_write_iter+0x7b/0xd0
[51893.656690]  [<ffffffff811a986d>] __vfs_write+0xad/0xe0
[51893.656692]  [<ffffffff811a9e71>] vfs_write+0xa1/0x180
[51893.656694]  [<ffffffff811aab19>] SyS_write+0x49/0xb0
[51893.656695]  [<ffffffff8114392d>] ? context_tracking_enter+0x1d/0x30
[51893.656697]  [<ffffffff81a7de2e>] entry_SYSCALL_64_fastpath+0x12/0x71
[51893.656698] 
[51893.656698] gmetad/4455's [current] stackdump:
[51893.656698] 
[51893.656700] CPU: 2 PID: 4455 Comm: gmetad Not tainted 4.4.6-thinkcloud-nfv #1
[51893.656701] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[51893.656702]  0000000000000000 ffff8800ba207618 ffffffff8140113e ffff8800ba207688
[51893.656703]  ffff880014c1c800 ffff8800ba207650 ffffffff810a2f5e ffff8800ba207688
[51893.656704]  0000000000000286 ffff8800b9c2bc00 000000000000d340 ffff88023fc8d340
[51893.656705] Call Trace:
[51893.656707]  [<ffffffff8140113e>] dump_stack+0x65/0x87
[51893.656710]  [<ffffffff810a2f5e>] debug_rt_mutex_print_deadlock+0x15e/0x180
[51893.656712]  [<ffffffff81a7c322>] rt_spin_lock_slowlock+0x372/0x3a0
[51893.656715]  [<ffffffff818d27a9>] ? ip_finish_output+0x139/0x1f0
[51893.656717]  [<ffffffff81a7d93f>] rt_spin_lock+0x1f/0x30
[51893.656720]  [<ffffffff810c2078>] lock_timer_base.isra.33+0x58/0x70
[51893.656722]  [<ffffffff810c456b>] mod_timer+0x7b/0x210
[51893.656724]  [<ffffffff81867758>] sk_reset_timer+0x18/0x30
[51893.656725]  [<ffffffff818e5e4b>] tcp_rearm_rto+0x6b/0xb0
[51893.656727]  [<ffffffff818e9583>] tcp_event_new_data_sent+0x83/0x90
[51893.656729]  [<ffffffff818eb344>] tcp_write_xmit+0x174/0xe90
[51893.656730]  [<ffffffff818ec2b1>] __tcp_push_pending_frames+0x31/0xa0
[51893.656732]  [<ffffffff818e79e7>] tcp_rcv_established+0x227/0x770
[51893.656733]  [<ffffffff818f20bc>] tcp_v4_do_rcv+0x10c/0x230
[51893.656734]  [<ffffffff818f32e9>] tcp_v4_rcv+0x8a9/0xa10
[51893.656737]  [<ffffffff818ce20c>] ip_local_deliver_finish+0x9c/0x240
[51893.656738]  [<ffffffff818ce5bd>] ip_local_deliver+0xbd/0xd0
[51893.656740]  [<ffffffff818ce170>] ? ip_rcv_finish+0x310/0x310
[51893.656741]  [<ffffffff818cdedd>] ip_rcv_finish+0x7d/0x310
[51893.656743]  [<ffffffff818ce8b8>] ip_rcv+0x2e8/0x420
[51893.656744]  [<ffffffff818cde60>] ? inet_del_offload+0x40/0x40
[51893.656747]  [<ffffffff8187fd1c>] __netif_receive_skb_core+0x37c/0xa20
[51893.656748]  [<ffffffff818d3c00>] ? ip_output+0x80/0xc0
[51893.656750]  [<ffffffff818d3302>] ? __ip_local_out+0x62/0xe0
[51893.656751]  [<ffffffff818d2670>] ? ip_fragment.constprop.50+0x80/0x80
[51893.656752]  [<ffffffff818803dd>] __netif_receive_skb+0x1d/0x60
[51893.656754]  [<ffffffff818812ea>] process_backlog+0xba/0x1c0
[51893.656755]  [<ffffffff818808c5>] net_rx_action+0x175/0x3a0
[51893.656759]  [<ffffffff8106621b>] do_current_softirqs+0x20b/0x420
[51893.656761]  [<ffffffff81066490>] __local_bh_enable+0x60/0x80
[51893.656762]  [<ffffffff81868798>] release_sock+0x128/0x170
[51893.656764]  [<ffffffff818dc7b6>] tcp_recvmsg+0x2f6/0xb90
[51893.656765]  [<ffffffff81084d33>] ? preempt_count_add+0xa3/0xc0
[51893.656767]  [<ffffffff81a7d590>] ? _raw_spin_unlock_irqrestore+0x20/0x50
[51893.656768]  [<ffffffff819088e0>] inet_recvmsg+0x90/0xb0
[51893.656769]  [<ffffffff8186417b>] sock_recvmsg+0x3b/0x50
[51893.656770]  [<ffffffff81864218>] sock_read_iter+0x88/0xd0
[51893.656772]  [<ffffffff811a978a>] __vfs_read+0xaa/0xe0
[51893.656774]  [<ffffffff811a9d42>] vfs_read+0x82/0x110
[51893.656775]  [<ffffffff811aaa69>] SyS_read+0x49/0xb0
[51893.656776]  [<ffffffff8114392d>] ? context_tracking_enter+0x1d/0x30
[51893.656778]  [<ffffffff81a7de2e>] entry_SYSCALL_64_fastpath+0x12/0x71
[51893.656778] [ turning off deadlock detection.Please report this trace. ]
[51893.656778] 
[51893.656796] ------------[ cut here ]------------
[51893.656796] kernel BUG at kernel/locking/rtmutex.c:1027!
[51893.656798] invalid opcode: 0000 [#1] PREEMPT SMP 
[51893.656822] Modules linked in: xt_REDIRECT nf_nat_redirect xt_nat xt_mark ip6table_raw ip6table_mangle ip6table_filter ip6_tables xt_connmark 8021q garp mrp veth openvswitch xt_CHECKSUM iptable_mangle xt_tcpudp xt_multiport xt_conntrack iptable_filter xt_CT iptable_raw ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_comment iptable_nat nf_nat_ipv4 nf_nat kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul aesni_intel aes_x86_64 glue_helper lrw ablk_helper cryptd snd_hda_codec_generic snd_hda_intel snd_hda_codec input_leds snd_hwdep snd_hda_core led_class tpm_tis nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables x_tables raid1 serio_raw pata_acpi [last unloaded: ipmi_msghandler]
[51893.656824] CPU: 2 PID: 4455 Comm: gmetad Not tainted 4.4.6-thinkcloud-nfv #1
[51893.656824] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[51893.656825] task: ffff8800b9c2bc00 ti: ffff8800ba204000 task.ti: ffff8800ba204000
[51893.656828] RIP: 0010:[<ffffffff81a7c322>]  [<ffffffff81a7c322>] rt_spin_lock_slowlock+0x372/0x3a0
[51893.656829] RSP: 0018:ffff8800ba207660  EFLAGS: 00010086
[51893.656830] RAX: 000000000000003d RBX: ffff8800ba207688 RCX: 0000000000000000
[51893.656831] RDX: 0000000000000002 RSI: ffffffff81c89168 RDI: ffffffff81cb316f
[51893.656832] RBP: ffff8800ba207718 R08: 000000000000015c R09: ffffffff8211a7e5
[51893.656832] R10: 000000000000f698 R11: 0000000000000000 R12: 0000000000000286
[51893.656833] R13: ffff8800b9c2bc00 R14: 000000000000d340 R15: ffff88023fc8d340
[51893.656835] FS:  00007f05d85ca700(0000) GS:ffff88023fd00000(0000) knlGS:0000000000000000
[51893.656836] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[51893.656841] CR2: 0000000004595ff0 CR3: 00000000b9835000 CR4: 00000000000006e0
[51893.656845] Stack:
[51893.656847]  010000000000ffff 0000000000000000 ffff8800ba2076b0 ffffffff818d27a9
[51893.656849]  ffff8800b9c2c2e8 0000000000000001 0000000000000000 0000000000000000
[51893.656851]  ffff8800ba2076a0 0000000000000000 0000000000000000 ffff8800b9c2bc00
[51893.656851] Call Trace:
[51893.656854]  [<ffffffff818d27a9>] ? ip_finish_output+0x139/0x1f0
[51893.656857]  [<ffffffff81a7d93f>] rt_spin_lock+0x1f/0x30
[51893.656859]  [<ffffffff810c2078>] lock_timer_base.isra.33+0x58/0x70
[51893.656861]  [<ffffffff810c456b>] mod_timer+0x7b/0x210
[51893.656863]  [<ffffffff81867758>] sk_reset_timer+0x18/0x30
[51893.656864]  [<ffffffff818e5e4b>] tcp_rearm_rto+0x6b/0xb0
[51893.656865]  [<ffffffff818e9583>] tcp_event_new_data_sent+0x83/0x90
[51893.656867]  [<ffffffff818eb344>] tcp_write_xmit+0x174/0xe90
[51893.656869]  [<ffffffff818ec2b1>] __tcp_push_pending_frames+0x31/0xa0
[51893.656870]  [<ffffffff818e79e7>] tcp_rcv_established+0x227/0x770
[51893.656871]  [<ffffffff818f20bc>] tcp_v4_do_rcv+0x10c/0x230
[51893.656872]  [<ffffffff818f32e9>] tcp_v4_rcv+0x8a9/0xa10
[51893.656874]  [<ffffffff818ce20c>] ip_local_deliver_finish+0x9c/0x240
[51893.656875]  [<ffffffff818ce5bd>] ip_local_deliver+0xbd/0xd0
[51893.656877]  [<ffffffff818ce170>] ? ip_rcv_finish+0x310/0x310
[51893.656878]  [<ffffffff818cdedd>] ip_rcv_finish+0x7d/0x310
[51893.656880]  [<ffffffff818ce8b8>] ip_rcv+0x2e8/0x420
[51893.656881]  [<ffffffff818cde60>] ? inet_del_offload+0x40/0x40
[51893.656883]  [<ffffffff8187fd1c>] __netif_receive_skb_core+0x37c/0xa20
[51893.656884]  [<ffffffff818d3c00>] ? ip_output+0x80/0xc0
[51893.656886]  [<ffffffff818d3302>] ? __ip_local_out+0x62/0xe0
[51893.656887]  [<ffffffff818d2670>] ? ip_fragment.constprop.50+0x80/0x80
[51893.656889]  [<ffffffff818803dd>] __netif_receive_skb+0x1d/0x60
[51893.656890]  [<ffffffff818812ea>] process_backlog+0xba/0x1c0
[51893.656891]  [<ffffffff818808c5>] net_rx_action+0x175/0x3a0
[51893.656893]  [<ffffffff8106621b>] do_current_softirqs+0x20b/0x420
[51893.656895]  [<ffffffff81066490>] __local_bh_enable+0x60/0x80
[51893.656897]  [<ffffffff81868798>] release_sock+0x128/0x170
[51893.656898]  [<ffffffff818dc7b6>] tcp_recvmsg+0x2f6/0xb90
[51893.656899]  [<ffffffff81084d33>] ? preempt_count_add+0xa3/0xc0
[51893.656901]  [<ffffffff81a7d590>] ? _raw_spin_unlock_irqrestore+0x20/0x50
[51893.656902]  [<ffffffff819088e0>] inet_recvmsg+0x90/0xb0
[51893.656903]  [<ffffffff8186417b>] sock_recvmsg+0x3b/0x50
[51893.656905]  [<ffffffff81864218>] sock_read_iter+0x88/0xd0
[51893.656906]  [<ffffffff811a978a>] __vfs_read+0xaa/0xe0
[51893.656908]  [<ffffffff811a9d42>] vfs_read+0x82/0x110
[51893.656909]  [<ffffffff811aaa69>] SyS_read+0x49/0xb0
[51893.656911]  [<ffffffff8114392d>] ? context_tracking_enter+0x1d/0x30
[51893.656912]  [<ffffffff81a7de2e>] entry_SYSCALL_64_fastpath+0x12/0x71
[51893.656925] Code: 4d 58 ff e9 3e fe ff ff 0f 0b 49 8b 57 18 e9 22 fd ff ff 89 c6 48 c7 c7 a0 ba c7 81 31 c0 e8 27 83 6c ff 48 89 df e8 de 6a 62 ff <0f> 0b 0f 0b e8 c5 57 62 ff e8 d0 4c 58 ff e9 6c fd ff ff 0f 0b 
[51893.656927] RIP  [<ffffffff81a7c322>] rt_spin_lock_slowlock+0x372/0x3a0
[51893.656927]  RSP <ffff8800ba207660>

I find there is a discuss at:
	https://groups.google.com/forum/#!topic/fa.linux.kernel/aV2peeXs71E
Whether it is the same problem as above?  And why is these correction not apply into rtmutex.c(4.4.6-rt14)?
Is this a defect which need to be fix?

Thanks
Feng
