From: Peter Xu <peterx@redhat.com>
Subject: [Question] MTRR init on secondary processors
Date: Wed, 20 Jan 2016 13:44:37 +0800
Message-ID: <20160120054437.GB5659@pxdev.xzpeter.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Xu <peterx@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933098AbcATFos (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2016 00:44:48 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Got a question about how we init MTRR for hot plugged processors.

I see that when init MTRR on new processors (online one processor,
possibly by hot-plugged), we need to stop all the active processors,
re-init MTRR on all the processors synchronously. Could anyone
explain why we need this sync-up for all the active processors
(please check mtrr_ap_init()) ?

I can understand that the OS software should make sure that every
processor's MTRR configurations are consistent, but why not we init
the new one only, just to make sure it is consistent with others
(since all the rest processors should be consistent in MTRR
configurations already)?

I am asking this since I found that this operation will force all
active processor to stop its work (the MTRR re-init is handled by
[migration/N] per-cpu kernel thread with FIFO 99 priority, which
will interrupt my RT application program), which brings very big
latency spikes on real-time CPUs.

I checked Intel manual volume 3 section 11.11.8, I think it's
following what the manual says. However I still cannot understand
the reason behind. Would appreciate if anyone knows this, and also
if anyone has suggestion on how I could avoid this spike on RT
systems.

Thanks in advance.
Peter
