From: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>]
 kvm_vcpu_ioctl+0x30c/0x750
Date: Thu, 11 Feb 2016 15:31:17 +0000
Message-ID: <BY1PR0701MB1594007A5F1EFF068CDA78C6E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>
References: <BY1PR0701MB15941A279E3F363E107E268FE1D70@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
 <BY1PR0701MB1594B8D40529E2F7D60E2A85E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>,<20160211152808.GA28994@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Josh Cartwright <joshc@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoffer Dall <christoffer.dall@linaro.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bn1on0083.outbound.protection.outlook.com ([157.56.110.83]:56832
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750932AbcBKPbU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 10:31:20 -0500
In-Reply-To: <20160211152808.GA28994@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


________________________________________
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sent: Thursday, February 11, 2016 8:58 PM
To: Jaggi, Manish
Cc: Josh Cartwright; linux-rt-users; Christoffer Dall
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>] kvm_vcpu_ioctl+0x30c/0x750

* Jaggi, Manish | 2016-02-11 10:46:16 [+0000]:

>Thanks Josh.
>I tried both options
>a) replace prempt_XXX with migrate_XXX as per the patch
so Josh's patch worked, correct?

[manish] yes.
But latency is on higher side in vm. 

>b) replacing spin_lock in kvm_vgic_flush_hwstate with raw_spin_lock
>

Sebastian
