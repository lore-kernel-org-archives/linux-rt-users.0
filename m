From: Christoph Mathys <eraserix@gmail.com>
Subject: Re: Hung task for proc_cgroup_show
Date: Tue, 22 Dec 2015 13:36:19 +0100
Message-ID: <CALqGcGrzpA_95LiL+4dHKX6xf7iwz-uL0_y8BtnQJgKLkZD-4w@mail.gmail.com>
References: <CALqGcGoMqJuvzQpGb84LzyxQCJADB73YEreND0HgOFK5DOQ6ig@mail.gmail.com>
	<20150714150016.GC21820@linutronix.de>
	<CALqGcGqzWsNacBHRUgFOrtJB6MSoqR+kDJteA8mgi9E4_o8vxw@mail.gmail.com>
	<20151211161450.GA6720@linutronix.de>
	<CALqGcGob5_qWeK1ndErqN9Z3DkGTPciTojjkEOkvauZyNd59Bg@mail.gmail.com>
	<20151221181153.GB6714@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33466 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbbLVMgU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2015 07:36:20 -0500
Received: by mail-lf0-f52.google.com with SMTP id p203so129848373lfa.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2015 04:36:19 -0800 (PST)
In-Reply-To: <20151221181153.GB6714@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I tried to reproduce this bug in kvm, hoping to get copy/pastable
dumps. The test didn't run at all, instead I got a stunning number of
the following slowpath warning (seem like it was repeated over 100
times during 9ms). I see them occasionally (less than once every few
minutes) on real hardware as well. I don't know what to make of them
and if they can help in any way. Here is the repeated message:

[   63.141432] WARNING: CPU: 0 PID: 54 at kernel/res_counter.c:28
res_counter_uncharge_until+0x98/0xa0()
[   63.141434] Modules linked in: veth(E) xt_CHECKSUM(E)
iptable_mangle(E) ipt_MASQUERADE(E) nf_nat_masquerade_ipv4(E)
iptable_nat(E) nf_co
nntrack_ipv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E) nf_nat(E)
nf_conntrack(E) xt_tcpudp(E) bridge(E) stp(E) llc(E) iptable_filter(E)
ip_tables
(E) ppdev(E) x_tables(E) kvm(E) microcode(E) cirrus(E) ttm(E)
serio_raw(E) drm_kms_helper(E) virtio_balloon(E) drm(E) syscopyarea(E)
sysfil
lrect(E) sysimgblt(E) i2c_piix4(E) parport_pc(E) mac_hid(E) lp(E)
parport(E) psmouse(E) pata_acpi(E) floppy(E)
[   63.141456] CPU: 0 PID: 54 Comm: kworker/0:1 Tainted: G        W
E  3.18.24-realtime-1-with-patch-rt22+ #2
[   63.141457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[   63.141459] Workqueue: cgroup_destroy css_killed_work_fn
[   63.141462]  0000000000000009 ffff88013639bb98 ffffffff8174ad9a
0000000000000002
[   63.141465]  0000000000000000 ffff88013639bbd8 ffffffff8104f371
ffff8800ba093100
[   63.141467]  ffff8800ba093100 0000000000000000 0000000000001000
ffff8800ba093100
[   63.141468] Call Trace:
[   63.141470]  [<ffffffff8174ad9a>] dump_stack+0x4e/0x84
[   63.141471]  [<ffffffff8104f371>] warn_slowpath_common+0x81/0xc0
[   63.141473]  [<ffffffff8104f46a>] warn_slowpath_null+0x1a/0x20
[   63.141475]  [<ffffffff810f76a8>] res_counter_uncharge_until+0x98/0xa0
[   63.141476]  [<ffffffff811aa88e>] mem_cgroup_reparent_charges+0x2ee/0x3f0
[   63.141478]  [<ffffffff811aab0b>] mem_cgroup_css_offline+0x14b/0x3e0
[   63.141480]  [<ffffffff810ebf6e>] css_killed_work_fn+0x4e/0x170
[   63.141481]  [<ffffffff8106b89c>] process_one_work+0x20c/0x5b0
[   63.141483]  [<ffffffff8106b801>] ? process_one_work+0x171/0x5b0
[   63.141485]  [<ffffffff8106bdab>] worker_thread+0x16b/0x4c0
[   63.141486]  [<ffffffff8106bc40>] ? process_one_work+0x5b0/0x5b0
[   63.141488]  [<ffffffff81070fc9>] kthread+0xd9/0xf0
[   63.141490]  [<ffffffff8109e51d>] ? trace_hardirqs_on+0xd/0x10
[   63.141492]  [<ffffffff81070ef0>] ? kthread_create_on_node+0x240/0x240
[   63.141493]  [<ffffffff817528c8>] ret_from_fork+0x58/0x90
[   63.141495]  [<ffffffff81070ef0>] ? kthread_create_on_node+0x240/0x240
[   63.141496] ---[ end trace 0000000000000075 ]---
