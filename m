From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] clockevents: Reinstate the per cpu tick skew
Date: Wed, 28 Dec 2011 17:57:24 +0100
Message-ID: <1325091444.2651.1.camel@laptop>
References: <1324717569.5025.73.camel@marge.simson.net>
	 <1324968044.5217.103.camel@marge.simson.net>
	 <1324977605.5217.132.camel@marge.simson.net>
	 <1325049448.4726.16.camel@marge.simson.net>
	 <4EFB1B28.7090203@linux.intel.com>
	 <1325084349.16165.22.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Arjan van de Ven <arjan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60061 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab1L1Q4B (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Dec 2011 11:56:01 -0500
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1RfwnH-0005YN-P5
	for linux-rt-users@vger.kernel.org; Wed, 28 Dec 2011 16:55:59 +0000
In-Reply-To: <1325084349.16165.22.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2011-12-28 at 15:59 +0100, Mike Galbraith wrote:
> 
> > (and are you using a system where tsc/lapic can be used, or are you
> > using one of those boatanchors that need hpet?)
> 
> Box is an HP DL980, 64 x X7560. 

That smells like NHM-EX, aka boatanchor.

