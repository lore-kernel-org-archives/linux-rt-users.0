From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.4rt3] Preemption disabled at:[<ffff8000000aba44>]
 kvm_vcpu_ioctl+0x30c/0x750
Date: Thu, 11 Feb 2016 17:10:25 +0100
Message-ID: <20160211161025.GB28994@linutronix.de>
References: <BY1PR0701MB15941A279E3F363E107E268FE1D70@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoffer Dall <christoffer.dall@linaro.org>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57530 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbcBKQK2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Feb 2016 11:10:28 -0500
Content-Disposition: inline
In-Reply-To: <20160210163930.GN9579@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Josh Cartwright | 2016-02-10 10:39:30 [-0600]:

>If the concern is touching the wrong per-CPU GIC distributor registers,
>it should be sufficient on -rt to downgrade the preempt_disable() /
>preempt_enable() to a migrate_disable() / migrate_enable(), which is
>preemptible, but prevents the task from moving to another CPU.

Thanks Josh. Could you please post a patch with sign-of-by and
everything?

>
>  Josh

Sebastian
