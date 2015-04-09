From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Thu, 9 Apr 2015 18:53:31 -0500
Message-ID: <1428623611.22867.561.camel@freescale.com>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
				 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
				 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>
				 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de>
			 <1424999159.4698.78.camel@freescale.com> <55158E6D.40304@freescale.com>
		 <1428016310.22867.289.camel@freescale.com>
	 <551E4A41.1080705@freescale.com> <1428096375.22867.369.camel@freescale.com>
	 <55262DD3.2050707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Bogdan Purcareata <bogdan.purcareata@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mihai.caraman@freescale.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Purcareata Bogdan <b43198@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bn1on0138.outbound.protection.outlook.com ([157.56.110.138]:7615
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753284AbbDIXxn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Apr 2015 19:53:43 -0400
In-Reply-To: <55262DD3.2050707@freescale.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2015-04-09 at 10:44 +0300, Purcareata Bogdan wrote:
> So at this point I was getting kinda frustrated so I decided to measure
> the time spend in kvm_mpic_write and kvm_mpic_read. I assumed these were
> the main entry points in the in-kernel MPIC and were basically executed
> while holding the spinlock. The scenario was the same - 24 VCPUs guest,
> with 24 virtio+vhost interfaces, only this time I ran 24 ping flood
> threads to another board instead of netperf. I assumed this would impose
> a heavier stress.
> 
> The latencies look pretty ok, around 1-2 us on average, with the max
> shown below:
> 
> .kvm_mpic_read	14.560
> .kvm_mpic_write	12.608
> 
> Those are also microseconds. This was run for about 15 mins.

What about other entry points such as kvm_set_msi() and
kvmppc_mpic_set_epr()?

-Scott


