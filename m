From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.24-rc7-rt2
Date: Wed, 16 Jan 2008 13:17:03 +0000
Message-ID: <20080116131703.62d76abe@lxorguk.ukuu.org.uk>
References: <1200336080.318.8.camel@localhost.localdomain>
	<200801150237.44029.caglar@pardus.org.tr>
	<24149.1200455417@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: caglar@pardus.org.tr, Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Valdis.Kletnieks@vt.edu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59213 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753050AbYAPNTI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Jan 2008 08:19:08 -0500
In-Reply-To: <24149.1200455417@turing-police.cc.vt.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Playing devil's advocate here - the claim is that EXPORT_SYMBOL_GPL is to
> indicate that code is getting too chummy with Linux internals.
> 
> However, in *this* case, isn't it "code that is too chummy with *GCC* internals",
> and thus it isn't our place to say what can and can't be done with code that
> is derivative of the GCC compiler? ;)

Yes. It would be something to discuss with the FSF.

However I don't think it matters. If you are doing instruction profiling
you need *all* the code built with profiling to get good results. You
can't rebuild the Nvidia modules so you can't profile them. 

Alan
