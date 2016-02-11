From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>]
 kvm_vcpu_ioctl+0x30c/0x750
Date: Thu, 11 Feb 2016 16:28:08 +0100
Message-ID: <20160211152808.GA28994@linutronix.de>
References: <BY1PR0701MB15941A279E3F363E107E268FE1D70@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
 <BY1PR0701MB1594B8D40529E2F7D60E2A85E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Cartwright <joshc@ni.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoffer Dall <christoffer.dall@linaro.org>
To: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56920 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcBKP2M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 10:28:12 -0500
Content-Disposition: inline
In-Reply-To: <BY1PR0701MB1594B8D40529E2F7D60E2A85E1A80@BY1PR0701MB1594.namprd07.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Jaggi, Manish | 2016-02-11 10:46:16 [+0000]:

>Thanks Josh.
>I tried both options
>a) replace prempt_XXX with migrate_XXX as per the patch
so Josh's patch worked, correct?

>b) replacing spin_lock in kvm_vgic_flush_hwstate with raw_spin_lock
>

Sebastian
