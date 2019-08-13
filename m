Return-Path: <SRS0=IBCX=WJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4A5C32750
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7024B20840
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Aug 2019 16:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfHMQRW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:17:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35447 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfHMQRW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Aug 2019 12:17:22 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hxZU7-0002NR-10; Tue, 13 Aug 2019 18:17:19 +0200
Date:   Tue, 13 Aug 2019 18:17:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Cc:     Clark Williams <williams@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.2-rt1: kernel: BUG: assuming atomic context at
 net/core/ptp_classifier.c:106 current
Message-ID: <20190813161718.ki2q24hi2lx57y75@linutronix.de>
References: <20190718204655.GA4097@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190718204655.GA4097@uudg.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-07-18 17:46:55 [-0300], Luis Claudio R. Goncalves wrote:
> Hello,
> 
> Sounds like ptp_classify_raw() should be reached with IRQs disabled to
> safely call BPF_PROG_RUN(). I am just unsure where, down the road, the
> proper context should have been set.
> 
> 08:46:58 darkmatter kernel: BUG: assuming atomic context at net/core/ptp_classifier.c:106
> Jul 17 08:46:58 darkmatter kernel: in_atomic(): 0, irqs_disabled(): 0, pid: 1129, name: irq/35-enp4s0
> Jul 17 08:46:58 darkmatter kernel: CPU: 1 PID: 1129 Comm: irq/35-enp4s0 Not tainted 5.2.0-rt1 #1
> Jul 17 08:46:58 darkmatter kernel: Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
> Jul 17 08:46:58 darkmatter kernel: Call Trace:
> Jul 17 08:46:58 darkmatter kernel: dump_stack+0x67/0x90
> Jul 17 08:46:58 darkmatter kernel: __cant_sleep.cold+0x68/0x74
> Jul 17 08:46:58 darkmatter kernel: ptp_classify_raw+0x1f/0xa0
> Jul 17 08:46:58 darkmatter kernel: skb_defer_rx_timestamp+0x5a/0xb0
> Jul 17 08:46:58 darkmatter kernel: netif_receive_skb_internal+0x34/0xe0
> Jul 17 08:46:58 darkmatter kernel: napi_gro_receive+0x66/0x1c0
> Jul 17 08:46:58 darkmatter kernel: rtl8169_poll+0x216/0x610 [r8169]
> Jul 17 08:46:58 darkmatter kernel: net_rx_action+0x208/0x490
> Jul 17 08:46:58 darkmatter kernel: __do_softirq+0x140/0x3c9
> Jul 17 08:46:58 darkmatter kernel: __local_bh_enable_ip+0x13d/0x160
> Jul 17 08:46:58 darkmatter kernel: irq_forced_thread_fn+0x70/0x80
> Jul 17 08:46:58 darkmatter kernel: irq_thread+0xf6/0x1d0
> Jul 17 08:46:58 darkmatter kernel: kthread+0x103/0x140
> Jul 17 08:46:58 darkmatter kernel: ret_from_fork+0x3a/0x50
> Jul 17 08:46:58 darkmatter kernel: bpfilter: Loaded bpfilter_umh pid 1160
> Jul 17 08:46:58 darkmatter kernel: bpfilter: read fail -13

I would argue that this cant_sleep() thingy is nonsense. On !RT you run
in softirq and while this check does not trigger (because the preemption
counter is != 0) you can be preempted by an IRQ.
I have no idea what it intends to protect. The commit does not explain
why it is important to keep preemption disabled while invoking a BPF
program.

> Luis

Sebastian
