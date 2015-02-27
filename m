From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Fri, 27 Feb 2015 14:06:03 +0100
Message-ID: <54F06BBB.9050709@redhat.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>	 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>	 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>	 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de> <1424999159.4698.78.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, mihai.caraman@freescale.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Scott Wood <scottwood@freescale.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424999159.4698.78.camel@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 27/02/2015 02:05, Scott Wood wrote:
> Obviously leaving it in a buggy state is not what we want -- but I lean
> towards a short term "fix" of putting "depends on !PREEMPT_RT" on the
> in-kernel MPIC emulation (which is itself just an optimization -- you
> can still use KVM without it).  This way people don't enable it with RT
> without being aware of the issue, and there's more of an incentive to
> fix it properly.

That would indeed work for me.

Paolo
