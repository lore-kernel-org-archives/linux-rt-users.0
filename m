From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Patches to drop from the next RT series
Date: Tue, 19 Aug 2008 22:44:04 -0400
Message-ID: <20080820024339.GA16876@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:17809 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751594AbYHTCoH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Aug 2008 22:44:07 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've identified some patches that can be dropped from the series file
going forward (vs what was in the 26-rt1 series).  Note that this should
not be considered a complete list; i.e. I'd rather send what I have now
in the hopes that it saves some folks time -- and then update as I find
more.  Currently I'm still comparing/updating 26rt1 onto 27-rc1.  I expect
the deltas for going from rc1 to rc2 and then rc2 to rc3 will be easier.

Here is the list, and the upstream commit IDs that make these patches
now redundant.

--in 27rc1;  b8f8c3cf0a4ac0632ec3f0e15e9dc0c29de917af
 idle-fix.patch

--in 27rc1;  e338125b8a886923ba8367207c144764dc352584
 idle2-fix.patch

--in 27rc1;  2b9a69861c39ae4c232385def833816acc07a0a4
 m68knommu_fixes_ontop_of_v2.6.26.patch

--in 27rc1;  6b148507d3d042a3c11f4c3f6c0f649c6a89220d
 pmtmr-override.patch

--in 27-rc1;  6e0534f278199f1e3dd1049b9bc19a7a5b87ada1
 sched-use-a-2d-bitmap-search-prio-cpu.patch

--in 27-rc1;  001b6767b1d0c89e458e5ddb039245b268f569fb
ftrace-function-record-nop.patch

--goes away due to 32/64 merge;  see 8fbbc4b45ce3e4c0eeb15004c79c72b6896a79c2
native-sched-clock-booboo.patch

--in 27-rc1;  a41eebab7537890409ea9dfe0fcda9b5fbdb090d
ftrace-document-update1.patch

--in 27-rc1;  1e01cb0c6ff7e9ddb6547551794c6aa82785a7cb
ftrace-preempt-trace-check.patch

--no longer needed, due to 2510495e208e7a69b64fcf5cdf8966d873536d9e
fix-acpi-build-weirdness.patch

--drop.  PPC is dead, dead, *dead*.
latency-tracing-ppc.patch

I'm guessing that a good chunk (all?) of what was "ftrace-upstream.patch"
@26 is now present in 27, and that we'll have a new ftrace-upstream as
time progresses.  Given that Steven probably knows this like the back of
his hand, I didn't see any point in me trying to sub-divide that patch and
look for what has been merged since.

For other patches, where there are updates required due to the upstream
changesets, what is the best way to present those in a way that integrates
best with your existing maintainer workflow?  I want to ensure my input is
an assistance and not a burden to you guys.

Thanks,
Paul.
