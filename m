From: luis.henrix@gmail.com
Subject: Linux, RT and virtualisation
Date: Tue, 22 Jun 2010 18:24:14 +0100
Message-ID: <20100622172414.GA13372@hades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53165 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab0FVR1r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Jun 2010 13:27:47 -0400
Received: by bwz9 with SMTP id 9so116059bwz.19
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Jun 2010 10:27:44 -0700 (PDT)
Received: from miguel by hades with local (Exim 4.72)
	(envelope-from <luis.henrix@gmail.com>)
	id 1OR7Co-0006h6-Ky
	for linux-rt-users@vger.kernel.org; Tue, 22 Jun 2010 18:24:14 +0100
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have the following scenario: a legacy application with RT constraints
that needs to be replicated.  Basically, I need to run several instances
of this application on a single multi-core box.  However, this is not as
simple as it sounds because the application assumes several things such
as exclusive access to HW, etc.

So, instead of re-designing the application to co-exist with different
instances, I was wondering whether this could be done using a lazy
approach: running each instance within a virtual machine.

I have enough cores available so that I can actually dedicate 1 or more
cores to each VM, but the problem is: will the application still be able
to meet its RT requirements?  I guess that, if two VMs share the same
core(s), meeting the deadlines will not be possible without having a
special scheduler on the VMs manager.  But what about if all the VMs have
their own cores?

Of course there is still the issue with the shared access to the HW,
but since this HW (Ethernet NICs) also have support for virtualisation,
I could create virtual NICs for each of the VM instances.

Any experiences/thoughts/links?  Would preemptrt+Xen be able to do this?
preemptrt+kvm? Other options?

Thanks,
--
Luis

