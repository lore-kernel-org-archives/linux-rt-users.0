From: John Kacur <jkacur@redhat.com>
Subject: Re: Problem with hwlat detector in smp_processor_id()
Date: Wed, 22 Jul 2009 11:18:40 +0200
Message-ID: <20090722091840.GC3507@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>,
	Jon Masters <jcm@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-rt-users@vger.kernel.org,
	Wolfgang Steinwender <wolfgang@psysteme.de>,
	Carsten Emde <Carsten.Emde@osadl.org>, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47312 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbZGVJTJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Jul 2009 05:19:09 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've tested this patch against 2.6.29.6-rt23 and 2.6.31-rc3-rtx
and it seems to solve the problem for me. I have not tested against vanilla
2.6.31-rc3 yet, but it looks to me like it should be applied there too.
(not just as an extra -rt patch)

