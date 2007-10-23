From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: KVM and Prempt?
Date: Tue, 23 Oct 2007 10:35:28 +0200
Message-ID: <471DB250.3030301@siemens.com>
References: <003F437218F04842B2A6976FA19368B1886B99@ERLM863A.ww001.siemens.net> <1193076845.5738.23.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Back, Michael (ext)" <michael.back.ext@siemens.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lizzard.sbs.de ([194.138.37.39]:18836 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbXJWIfg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 04:35:36 -0400
In-Reply-To: <1193076845.5738.23.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sven-Thorsten Dietrich wrote:
> On Mon, 2007-10-22 at 09:01 +0200, Back, Michael (ext) wrote:
>> Hallo,
>> I tried to run Windows XP with KVM on Linux 2.6.31.1 on a 
> 
> You mean .21.1 ? 

Classic typo I interestingly also did several times the last week. :)

> 
>> AMD Opteron and on a Intel Xeon, on both it works fine!
> 
>> After this test I patch the kernel with the current prempt-patch and on
>> both it doesn't works! 
> 
> Did you try against 2.6.23-rt1.

kvm in -rt1 is not usable. It's too old, lacking PREEMPT_NOTIFIER
support, thus quickly triggering lockdep.

> 
> If you must stay on .21, you might have some other issues with the AMD
> and NUMA.
> 
> At the very least, you will need to apply the attached patch from git
> somehow, although this patch is against a new scheduler post 2.6.22, so
> good luck :)

<--snip-->

Those patches are already mainline... :->

What you rather need are latest kvm patches, or - if building the kvm
distribution out of tree - a patch to enabled CONFIG_PREEMPT_NOTIFIERS
unconditionally:

--- linux-2.6.23.1-rt/kernel/Kconfig.preempt.orig
+++ linux-2.6.23.1-rt/kernel/Kconfig.preempt
@@ -136,6 +136,7 @@

 config PREEMPT_NOTIFIERS
 	bool
+	default y

 config PREEMPT_BKL
 	bool


Still, I'm seeing oopses here (more precisely, lock validator
complaints), but I need to re-test, better using kvm from git instead of
kvm-48.

Beyond this, I'm struggling to understand 300-400 us vm-exit latencies
(over Intel VMX), which appear to be independent of the underlying
system. See kvm-devel. Such latencies would limit the RT usability of
kvm - unless you spent dedicated CPUs.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux
