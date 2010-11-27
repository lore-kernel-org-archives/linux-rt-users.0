From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: ebt_do_table calls smp_processor_id() in preemptible
Date: Sat, 27 Nov 2010 13:04:05 -0200
Message-ID: <20101127150404.GA20613@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44469 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541Ab0K0PEK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Nov 2010 10:04:10 -0500
Received: by ywl5 with SMTP id 5so1344217ywl.19
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Nov 2010 07:04:10 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas,

I added a patch by the end of this email with one possible way to fix t=
he
issue. Not througly thought but it is surviving for more than 4h now.

ebt_do_table: fix smp_processor_id() usage

I have been seeing several variations of this BUG message:

	BUG: using smp_processor_id() in preemptible [00000000] code: ...
	caller is ebt_do_table+0x94/0x60c [ebtables]

Backtrace:

BUG: using smp_processor_id() in preemptible [00000000] code: cupsd/135=
3
caller is ebt_do_table+0x94/0x60c [ebtables]
Pid: 1353, comm: cupsd Not tainted 2.6.33.7-rt29 #51
Call Trace:
 [<ffffffff81228df3>] debug_smp_processor_id+0xd7/0xf0
 [<ffffffffa00c5684>] ? ebt_do_table+0x6f/0x60c [ebtables]
 [<ffffffffa00c56a9>] ebt_do_table+0x94/0x60c [ebtables]
 [<ffffffffa00c5bfa>] ? ebt_do_table+0x5e5/0x60c [ebtables]
 [<ffffffff813d0d73>] ? rcu_read_lock+0x0/0x3a
 [<ffffffffa00ba0a0>] ebt_nat_out+0x1c/0x20 [ebtable_nat]
 [<ffffffff813d0f19>] nf_iterate+0x46/0x89
 [<ffffffffa044ce3b>] ? br_dev_queue_push_xmit+0x0/0x88 [bridge]
 [<ffffffff813d0fd4>] nf_hook_slow+0x78/0xe0
 [<ffffffffa044ce3b>] ? br_dev_queue_push_xmit+0x0/0x88 [bridge]
 [<ffffffff813d0d07>] ? genl_register_mc_group+0x175/0x1c6
 [<ffffffffa044cec3>] ? br_forward_finish+0x0/0x58 [bridge]
 [<ffffffffa044cfef>] ? __br_deliver+0x0/0x5b [bridge]
 [<ffffffffa044cf07>] br_forward_finish+0x44/0x58 [bridge]
 [<ffffffffa044d043>] __br_deliver+0x54/0x5b [bridge]
 [<ffffffffa044cdf4>] br_flood+0xb0/0xc9 [bridge]
 [<ffffffffa044ce39>] br_flood_deliver+0x15/0x17 [bridge]
 [<ffffffffa044c347>] br_dev_xmit+0x81/0x8e [bridge]
 [<ffffffff813b26de>] dev_hard_start_xmit+0x246/0x305
 [<ffffffff813b2c4e>] dev_queue_xmit+0x399/0x495
 [<ffffffff813b2a2a>] ? dev_queue_xmit+0x175/0x495
 [<ffffffff813e5269>] ip_finish_output2+0x26a/0x2b3
 [<ffffffff813e531f>] ip_finish_output+0x6d/0x6f
 [<ffffffff813e55e4>] ip_mc_output+0x1ee/0x1fd
 [<ffffffff813e47b5>] ip_local_out+0x25/0x29
 [<ffffffff813e4a9c>] ip_push_pending_frames+0x2e3/0x345
 [<ffffffff81402aee>] udp_push_pending_frames+0x2de/0x362
 [<ffffffff81403c01>] udp_sendmsg+0x565/0x680
 [<ffffffff81459d7d>] ? rt_spin_lock_slowlock+0x38/0x272
 [<ffffffff8140a3cc>] inet_sendmsg+0x57/0x60
 [<ffffffff813a12a4>] __sock_sendmsg+0x61/0x6c
 [<ffffffff81459d7d>] ? rt_spin_lock_slowlock+0x38/0x272
 [<ffffffff813a15c0>] sock_sendmsg+0xa8/0xc1
 [<ffffffff810809d5>] ? debug_rt_mutex_free_waiter+0x18/0xca
 [<ffffffff81459f8d>] ? rt_spin_lock_slowlock+0x248/0x272
 [<ffffffff81459cea>] ? rt_spin_lock_slowunlock+0x23/0x7e
 [<ffffffff813a0232>] ? might_fault+0x1c/0x1e
 [<ffffffff813a3240>] ? move_addr_to_kernel+0x49/0x4e
 [<ffffffff813a335b>] sys_sendto+0x116/0x15b
 [<ffffffff8145a825>] ? rt_spin_unlock+0x4d/0x51
 [<ffffffff8145a4be>] ? lockdep_sys_exit_thunk+0x35/0x67
 [<ffffffff810a0cc5>] ? audit_syscall_entry+0x11e/0x14a
 [<ffffffff81009d72>] system_call_fastpath+0x16/0x1b

Signed-off-by: Luis Claudio R. Gon=E7alves <lclaudio@uudg.org>


diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebt=
ables.c
index 0b7f262..2ffdd86 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -153,7 +153,7 @@ unsigned int ebt_do_table (unsigned int hook, struc=
t sk_buff *skb,
    const struct net_device *in, const struct net_device *out,
    struct ebt_table *table)
 {
-	int i, nentries;
+	int i, nentries, cpu;
 	struct ebt_entry *point;
 	struct ebt_counter *counter_base, *cb_base;
 	struct ebt_entry_target *t;
@@ -174,12 +174,14 @@ unsigned int ebt_do_table (unsigned int hook, str=
uct sk_buff *skb,
=20
 	read_lock_bh(&table->lock);
 	private =3D table->private;
-	cb_base =3D COUNTER_BASE(private->counters, private->nentries,
-	   smp_processor_id());
+	preempt_disable_rt();
+	cpu =3D smp_processor_id();
+	cb_base =3D COUNTER_BASE(private->counters, private->nentries, cpu);
 	if (private->chainstack)
-		cs =3D private->chainstack[smp_processor_id()];
+		cs =3D private->chainstack[cpu];
 	else
 		cs =3D NULL;
+	preempt_enable_rt();
 	chaininfo =3D private->hook_entry[hook];
 	nentries =3D private->hook_entry[hook]->nentries;
 	point =3D (struct ebt_entry *)(private->hook_entry[hook]->data);

--=20
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
