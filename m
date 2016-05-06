From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: WARNING: complate_all() with 7 waiters at system boot
Date: Fri, 6 May 2016 16:23:07 +0200
Message-ID: <20160506142307.GA12705@linutronix.de>
References: <FC629F1A536C6F42B960B5E32E20BD358C23F21A@exc2.buero.ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Daniel Wagner <wagi@monom.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59550 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758270AbcEFOXJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 May 2016 10:23:09 -0400
Content-Disposition: inline
In-Reply-To: <FC629F1A536C6F42B960B5E32E20BD358C23F21A@exc2.buero.ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Roosen Henri | 2016-05-06 09:23:02 [+0000]:

>Hi all,
Hi,

>My x86_64 development PC with kernel 4.4.7-rt16 throws the following warning during system boot:

Thank you for the report. The warning is harmless I am just interrested
what kind of workload / usage triggers this warning.

>[   12.606217] ------------[ cut here ]------------
>[   12.606220] WARNING: CPU: 5 PID: 872 at kernel/sched/swait.c:48 complete_all+0x2a/0x40()
>[   12.606220] complate_all() with 7 waiters

Do I assume currectly that at this point you have your filesystem already
mounted? Do you use LUKS on your harddisk or what is it that trigger
the usage of crypto code here?

>[   12.606253] CPU: 5 PID: 872 Comm: cryptomgr_probe Not tainted 4.4.7-rt16 #2
>[   12.606254] Hardware name: FUJITSU CELSIUS W530/D3227-A1, BIOS V4.6.5.4 R1.34.0 for D3227-A1x 01/08/2015
>[   12.606256]  0000000000000000 ffffffff812e0e0e ffff88021142be30 ffffffff81731e02
>[   12.606257]  ffffffff81073f81 ffff88003614fd30 ffff88021142be80 0000000000000246
>[   12.606258]  ffff880212206400 0000000000000000 ffffffff8107401c ffffffff81726fb0
>[   12.606258] Call Trace:
>[   12.606262]  [<ffffffff812e0e0e>] ? dump_stack+0x5c/0x7e
>[   12.606265]  [<ffffffff81073f81>] ? warn_slowpath_common+0x81/0xd0
>[   12.606266]  [<ffffffff8107401c>] ? warn_slowpath_fmt+0x4c/0x50
>[   12.606267]  [<ffffffff810b5849>] ? swake_up_all_locked+0x29/0x80
>[   12.606268]  [<ffffffff810b5eca>] ? complete_all+0x2a/0x40
>[   12.606279]  [<ffffffff812a3241>] ? cryptomgr_probe+0x91/0xd0
>[   12.606280]  [<ffffffff812a31b0>] ? crypto_alg_put+0x20/0x20
>[   12.606282]  [<ffffffff81092cbf>] ? kthread+0xcf/0xf0
>[   12.606283]  [<ffffffff81092bf0>] ? kthread_worker_fn+0x190/0x190
>[   12.606286]  [<ffffffff8156e38f>] ? ret_from_fork+0x3f/0x70
>[   12.606287]  [<ffffffff81092bf0>] ? kthread_worker_fn+0x190/0x190
>[   12.606288] ---[ end trace 0000000000000002 ]---
>
>Thanks,
>Henri

Sebastian
