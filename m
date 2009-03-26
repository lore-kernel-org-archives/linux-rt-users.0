From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: Small fix for MIPs
Date: Thu, 26 Mar 2009 15:26:00 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903261524490.3397@localhost.localdomain>
References: <400C43189542CE41BC0A5B252FC9013649F00BEF97@SJEXCHCCR02.corp.ad.broadcom.com> <400C43189542CE41BC0A5B252FC9013649F00BEF9A@SJEXCHCCR02.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: John Ulvr <julvr@broadcom.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42424 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755592AbZCZO0J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Mar 2009 10:26:09 -0400
In-Reply-To: <400C43189542CE41BC0A5B252FC9013649F00BEF9A@SJEXCHCCR02.corp.ad.broadcom.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 25 Mar 2009, John Ulvr wrote:

> Just to clarify, the bellow applies to the RT_PREEMPT patch on the
> 2.6.29-rc8 kernel, and fixes a compile error.

It needs a little more than that. The MIPS preempt-rt changes got
dropped, but I'll resurrect them in one of the next releases.

Thanks,

	tglx
