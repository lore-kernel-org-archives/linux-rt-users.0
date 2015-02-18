From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] powerpc/kvm: Limit MAX_VCPUS for guests running on
 RT Linux
Date: Wed, 18 Feb 2015 10:36:49 +0100
Message-ID: <54E45D31.3020302@linutronix.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com> <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com,
	mihai.caraman@freescale.com
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
	agraf@suse.de, pbonzini@redhat.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/18/2015 10:32 AM, Bogdan Purcareata wrote:
> Due to the introduction of the raw_spinlock for the KVM openpic, guests with a
> high number of VCPUs may induce great latencies on the underlying RT Linux
> system (e.g. cyclictest reports latencies of ~15ms for guests with 24 VCPUs).
> This can be further aggravated by sending a lot of external interrupts to the
> guest.
> 
> A malicious app can abuse this scenario, causing a DoS of the host Linux.
> Until the KVM openpic code is refactored to use finer lock granularity, impose
> a limitation on the number of VCPUs a guest can have when running on a
> PREEMPT_RT_FULL system with KVM_MPIC emulation.

How is this possible? You take the raw lock, write a register, release
the raw lock. How can the guest lockup the host? Is this write blocking
in guest?

Sebastian
