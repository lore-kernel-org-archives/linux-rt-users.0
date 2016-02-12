From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH -rt 2/2] KVM: arm/arm64: downgrade preempt_disable()d
 region to migrate_disable()
Date: Sat, 13 Feb 2016 00:03:19 +0100
Message-ID: <20160212230319.GA7694@linutronix.de>
References: <d08185b69f64d90e4dc458eb5051b3186c7d25a8.1455213062.git.joshc@ni.com>
 <685c494e87e1b537881117a5098bc4b3447b3add.1455213062.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Christoffer Dall <christoffer.dall@linaro.org>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43534 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbcBLXDX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Feb 2016 18:03:23 -0500
Content-Disposition: inline
In-Reply-To: <685c494e87e1b537881117a5098bc4b3447b3add.1455213062.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Josh Cartwright | 2016-02-11 11:54:01 [-0600]:

>kvm_arch_vcpu_ioctl_run() disables the use of preemption when updating
>the vgic and timer states to prevent the calling task from migrating to
>another CPU.  It does so to prevent the task from writing to the
>incorrect per-CPU GIC distributor registers.
>
>On -rt kernels, it's possible to maintain the same guarantee with the
>use of migrate_{disable,enable}(), with the added benefit that the
>migrate-disabled region is preemptible.  Update
>kvm_arch_vcpu_ioctl_run() to do so.
>
>Cc: Christoffer Dall <christoffer.dall@linaro.org>
>Reported-by: Manish Jaggi <Manish.Jaggi@caviumnetworks.com>
>Signed-off-by: Josh Cartwright <joshc@ni.com>

Thanks, applied.

Sebastian
