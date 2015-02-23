From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/kvm: Convert openpic lock to raw_spinlock
Date: Mon, 23 Feb 2015 16:43:40 -0600
Message-ID: <1424731420.4698.13.camel@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
	 <1424251955-308-2-git-send-email-bogdan.purcareata@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>,
	<bigeasy@linutronix.de>, <agraf@suse.de>, <pbonzini@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mihai.caraman@freescale.com>
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424251955-308-2-git-send-email-bogdan.purcareata@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2015-02-18 at 09:32 +0000, Bogdan Purcareata wrote:
> This patch enables running intensive I/O workloads, e.g. netperf, in a guest
> deployed on a RT host. It also enable guests to be SMP.
> 
> The openpic spinlock becomes a sleeping mutex on a RT system. This no longer
> guarantees that EPR is atomic with exception delivery. The guest VCPU thread
> fails due to a BUG_ON(preemptible()) when running netperf.
> 
> In order to make the kvmppc_mpic_set_epr() call safe on RT from non-atomic
> context, convert the openpic lock to a raw_spinlock. A similar approach can
> be seen for x86 platforms in the following commit [1].
> 
> Here are some comparative cyclitest measurements run inside a high priority RT
> guest run on a RT host. The guest has 1 VCPU and the test has been run for 15
> minutes. The guest runs ~750 hackbench processes as background stress.
> 
>                   spinlock  raw_spinlock
> Min latency (us)  4         4
> Avg latency (us)  15        19
> Max latency (us)  70        62
> 
> [1] https://lkml.org/lkml/2010/1/11/289
> 
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> Reviewed-by: Scott Wood <scottwood@freescale.com>

Where did that Reviewed-by: come from?

A +1 in Gerrit on an internal tree does not translate into an upstream
Reviewed-by.

-Scott
