From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Thu, 26 Feb 2015 14:02:38 +0100
Message-ID: <54EF196E.4090805@redhat.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>	 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>	 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mihai.caraman@freescale.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Scott Wood <scottwood@freescale.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424734051.4698.17.camel@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 24/02/2015 00:27, Scott Wood wrote:
> This isn't a host PIC driver.  It's guest PIC emulation, some of which
> is indeed not suitable for a rawlock (in particular, openpic_update_irq
> which loops on the number of vcpus, with a loop body that calls
> IRQ_check() which loops over all pending IRQs).

The question is what behavior is wanted of code that isn't quite
RT-ready.  What is preferred, bugs or bad latency?

If the answer is bad latency (which can be avoided simply by not running
KVM on a RT kernel in production), patch 1 can be applied.  If the
answer is bugs, patch 1 is not upstream material.

I myself prefer to have bad latency; if something takes a spinlock in
atomic context, that spinlock should be raw.  If it hurts (latency),
don't do it (use the affected code).

Paolo

> The vcpu limits are a
> temporary bandaid to avoid the worst latencies, but I'm still skeptical
> about this being upstream material.
