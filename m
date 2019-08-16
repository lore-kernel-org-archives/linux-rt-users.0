Return-Path: <SRS0=9Pks=WM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE2CC3A59C
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E403121721
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Aug 2019 15:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfHPPXW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:23:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHPPXV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Aug 2019 11:23:21 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hye4U-0003nz-Ii; Fri, 16 Aug 2019 17:23:18 +0200
Date:   Fri, 16 Aug 2019 17:23:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        anna-maria@linutronix.de,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: KVM Arm64 and Linux-RT issues
Message-ID: <20190816152317.pbhctfiyurjrepju@linutronix.de>
References: <b9867c43-7fe3-5d64-9939-b1a7ab7f1061@arm.com>
 <cd310858-2c0f-6af1-bf82-ee1e01a2cfb8@arm.com>
 <alpine.DEB.2.21.1907270053360.1791@nanos.tec.linutronix.de>
 <86zhkzn319.wl-maz@kernel.org>
 <960b5ed1-6d0f-3cee-da37-6061b4946c1a@arm.com>
 <20190813125835.5v26s4iuv44lw2xg@linutronix.de>
 <adc0b2e2-3a2e-5685-8eb5-2ce927d2139e@arm.com>
 <865zn1nidx.wl-maz@kernel.org>
 <1f76c277-665a-e962-8cbe-b3c4ecad41b0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1f76c277-665a-e962-8cbe-b3c4ecad41b0@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-16 16:18:20 [+0100], Julien Grall wrote:
> Sadly, I managed to hit the same BUG_ON() today with this patch
> applied on top v5.2-rt1-rebase. :/ Although, it is more difficult
> to hit than previously.
> 
> [  157.449545] 000: BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
> [  157.449569] 000: in_atomic(): 1, irqs_disabled(): 0, pid: 990, name: kvm-vcpu-1
> [  157.449579] 000: 2 locks held by kvm-vcpu-1/990:
> [  157.449592] 000:  #0: 00000000c2fc8217 (&vcpu->mutex){+.+.}, at: kvm_vcpu_ioctl+0x70/0xae0
> [  157.449638] 000:  #1: 0000000096863801 (&cpu_base->softirq_expiry_lock){+.+.}, at: hrtimer_grab_expiry_lock+0x24/0x40
> [  157.449677] 000: Preemption disabled at:
> [  157.449679] 000: [<ffff0000111a4538>] schedule+0x30/0xd8
> [  157.449702] 000: CPU: 0 PID: 990 Comm: kvm-vcpu-1 Tainted: G        W 5.2.0-rt1-00001-gd368139e892f #104
> [  157.449712] 000: Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 23 2017
> [  157.449718] 000: Call trace:
> [  157.449722] 000:  dump_backtrace+0x0/0x130
> [  157.449730] 000:  show_stack+0x14/0x20
> [  157.449738] 000:  dump_stack+0xbc/0x104
> [  157.449747] 000:  ___might_sleep+0x198/0x238
> [  157.449756] 000:  rt_spin_lock+0x5c/0x70
> [  157.449765] 000:  hrtimer_grab_expiry_lock+0x24/0x40
> [  157.449773] 000:  hrtimer_cancel+0x1c/0x38
> [  157.449780] 000:  kvm_timer_vcpu_load+0x78/0x3e0

…
> I will do some debug and see what I can find.

which timer is this? Is there another one?
In the meantime I do a release with that patch included.

> 
> Cheers,

Sebastian
