From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Wed, 25 Feb 2015 17:36:49 +0100
Message-ID: <20150225163649.GD6823@linutronix.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de>
 <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de>
 <1424734051.4698.17.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mihai.caraman@freescale.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Scott Wood <scottwood@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424734051.4698.17.camel@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Scott Wood | 2015-02-23 17:27:31 [-0600]:

>This isn't a host PIC driver.  It's guest PIC emulation, some of which
>is indeed not suitable for a rawlock (in particular, openpic_update_irq
>which loops on the number of vcpus, with a loop body that calls
>IRQ_check() which loops over all pending IRQs).  The vcpu limits are a
>temporary bandaid to avoid the worst latencies, but I'm still skeptical
>about this being upstream material.

Okay.

>-Scott

Sebastian
