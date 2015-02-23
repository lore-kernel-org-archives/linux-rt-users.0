From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/kvm: Limit MAX_VCPUS for guests running on
 RT Linux
Date: Mon, 23 Feb 2015 16:48:30 -0600
Message-ID: <1424731710.4698.15.camel@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
	 <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
	 <54E73A64.5020608@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>,
	<bigeasy@linutronix.de>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E73A64.5020608@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2015-02-20 at 14:45 +0100, Alexander Graf wrote:
> 
> On 18.02.15 10:32, Bogdan Purcareata wrote:
> > Due to the introduction of the raw_spinlock for the KVM openpic, guests with a
> > high number of VCPUs may induce great latencies on the underlying RT Linux
> > system (e.g. cyclictest reports latencies of ~15ms for guests with 24 VCPUs).
> > This can be further aggravated by sending a lot of external interrupts to the
> > guest.
> > 
> > A malicious app can abuse this scenario, causing a DoS of the host Linux.
> > Until the KVM openpic code is refactored to use finer lock granularity, impose
> > a limitation on the number of VCPUs a guest can have when running on a
> > PREEMPT_RT_FULL system with KVM_MPIC emulation.
> > 
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> > Reviewed-by: Scott Wood <scottwood@freescale.com>
> 
> I don't think this patch is reasonable to take upstream.

I agree (or at least, I don't think the raw lock conversion should be
separated from the vcpu limitation that makes it clear that it's a
temporary hack), because it ought to be fixed properly.

>  If we have a
> latency issue, whoever spawned KVM VMs made a decision to spawn such big
> VMs.

I disagree.  The point of PREEMPT_RT is to prevent the majority of
kernel code from excessively impacting latency.  When you start using
raw locks you're stepping outside those bounds and need to ensure that
you don't hand things within those bounds (which includes userspace) the
ability to excessively impact latency.

-Scott
