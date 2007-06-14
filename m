From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH RT] fix migrating softirq [cause of network hang]
Date: Thu, 14 Jun 2007 00:02:17 -0700
Message-ID: <200706140002.17411.dvhltc@us.ibm.com>
References: <1181738836.10408.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40036 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbXFNHCV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Jun 2007 03:02:21 -0400
In-Reply-To: <1181738836.10408.54.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 13 June 2007 05:47:16 Steven Rostedt wrote:

> This patch temporarily binds the hardirq thread on the CPU that it runs
> the softirqs on.  With this patch I have not seen my network hang. I ran
> it over night, doing compiles and such, and it seems fine. I would be
> able to cause the hang with various loads within a minute, now I can't
> cause it after several minutes.
>
> I'm assuming that this fix may fix other bugs too.
>

I ran 2.6.21-rt10 + this patch with kernbench and then loops building a kernel 
(which would previously rapidly exhaust memory).  It successfully built 400 
kernels with "make -j 32" on an 8 opteron machine with 8 GB of RAM and has so 
far completed 25 "make -j" on the same system.  Looks like a winner to me so 
far.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
