From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Linux, RT and virtualisation
Date: Tue, 22 Jun 2010 20:29:03 +0200
Message-ID: <4C2100EF.7030905@siemens.com>
References: <20100622172414.GA13372@hades>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, frank.rowand@am.sony.com
To: luis.henrix@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from david.siemens.de ([192.35.17.14]:21163 "EHLO david.siemens.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab0FVTBZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jun 2010 15:01:25 -0400
In-Reply-To: <20100622172414.GA13372@hades>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

luis.henrix@gmail.com wrote:
> Hi,
> 
> I have the following scenario: a legacy application with RT constraints
> that needs to be replicated.  Basically, I need to run several instances
> of this application on a single multi-core box.  However, this is not as
> simple as it sounds because the application assumes several things such
> as exclusive access to HW, etc.
> 
> So, instead of re-designing the application to co-exist with different
> instances, I was wondering whether this could be done using a lazy
> approach: running each instance within a virtual machine.
> 
> I have enough cores available so that I can actually dedicate 1 or more
> cores to each VM, but the problem is: will the application still be able
> to meet its RT requirements?

What are those RT requirements (order of magnitude, hard/soft, ie. what
may happen if some deadline is missed)?

>  I guess that, if two VMs share the same
> core(s), meeting the deadlines will not be possible without having a
> special scheduler on the VMs manager.  But what about if all the VMs have
> their own cores?
> 
> Of course there is still the issue with the shared access to the HW,
> but since this HW (Ethernet NICs) also have support for virtualisation,
> I could create virtual NICs for each of the VM instances.

For the tests Frank cited, I tried to avoid device emulation as far as
possible because it can be a bottleneck in QEMU (i.e. also KVM),
specifically if you go below the millisecond and there is other guest
I/O running in parallel. Still, if that may hurt you, depends on your RT
requirements.

> 
> Any experiences/thoughts/links?  Would preemptrt+Xen be able to do this?

Xen uses QEMU (a variant of it) in Dom0 for device emulation. Moreover,
you would have to merge Xen's Dom0 patches with Preempt-RT patches -
well, challenging, I bet.

> preemptrt+kvm? Other options?

Preempt-RT + kvm will at least allow you to tweak a lot, benefit from
ongoing optimizations of both projects, or maybe even apply some "dirty
tricks" to the hypervisor. IMO, a good starting point unless your
requirements are way off.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux
