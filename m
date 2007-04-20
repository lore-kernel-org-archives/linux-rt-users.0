From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: How to dedicate a CPU for real time applications?
Date: Fri, 20 Apr 2007 04:04:56 +0200
Message-ID: <46281FC8.2000209@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:32511 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbXDTCKd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Apr 2007 22:10:33 -0400
Received: from [192.168.0.1]
	(ppp-88-217-43-44.dynamic.mnet-online.de [88.217.43.44])
	by post.webmailer.de (mrclete mo7) (RZmta 5.5)
	with ESMTP id R00198j3JIQHPk for <linux-rt-users@vger.kernel.org>;
	Fri, 20 Apr 2007 04:04:32 +0200 (MEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hi!

Although -rt provides exceptionaly low latencies, i'd like
to try out further optimization by dedicating one CPU in
a SMP system for real time application ("Shielded CPU").

If applying "isolcpus=1", then most processes will be
bound to CPU0 as expected (per CPU kernel threads need
to stay), but, interrupts are still distributed amongst
CPUs. I tried to modify /proc/irq/*/smp_affinity, but
the cpu mask doesn't change for most interrupts.

Any ideas what could be the problem? TIA!

regards

Bernhard
