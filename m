From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 3.0.4-rt14 "shutdown -h now" hangs on x86 32b
Date: Tue, 4 Oct 2011 23:20:24 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110042319060.18778@ionos>
References: <4E89FBDE.7080406@linux.intel.com>  <4E8ABB4B.6000204@iis.fraunhofer.de> <1317720489.6260.9.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon Sudler <Simon.Sudler@iis.fraunhofer.de>,
	Darren Hart <dvhart@linux.intel.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58432 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933247Ab1JDVU1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Oct 2011 17:20:27 -0400
In-Reply-To: <1317720489.6260.9.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 4 Oct 2011, Mike Galbraith wrote:

> On Tue, 2011-10-04 at 09:52 +0200, Simon Sudler wrote: 
> > Hi Darren,
> > 
> > i had the same problem on a Z530 with all RT kernels 3.0. I didn't 
> > search for the reason, however the problem went away when i used the 
> > "Intel Atom" at the "Processor family" option.
> 
> I see something similar at least on my Q6600 and E5620 boxen.

That should be solved by a CPU hotplug fix in rt16. Could you please
verify?

Thanks,

	tglx
