From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Kernel 2.6.33.1-rt11 on PPC405 UIC spinlock and serial input
 overruns
Date: Wed, 7 Apr 2010 16:19:08 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004071600030.32352@localhost.localdomain>
References: <1270145758.27946.48.camel@localhost.localdomain>  <alpine.LFD.2.00.1004060946000.32352@localhost.localdomain> <1270562527.30658.40.camel@localhost.localdomain> <alpine.LFD.2.00.1004061645090.32352@localhost.localdomain>
 <D61182AC8012EA4EBC531B3AF23BE10992AE68@tranzeo-mail2.12stewart.tranzeo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Darcy Watkins <DWatkins@tranzeo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51154 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283Ab0DGOTQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Apr 2010 10:19:16 -0400
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE10992AE68@tranzeo-mail2.12stewart.tranzeo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darcy,

On Tue, 6 Apr 2010, Darcy Watkins wrote:

Please do not top post.

> Hi Thomas,
> 
> Thanks for the suggestion.
> 
> I tried boosting priority of [irq/16-serial] to 70 and then 95 with no
> observable difference from before.  I still see the input overruns when
> I up-arrow to backup through shell history (and the terminal sends
> up-arrow escape sequences as small serial bursts at 115200).
> 
> /proc/interrupts also indicates that serial interrupts do count upwards
> in good quantity.

Ok. Can you try to fire up the function tracer to figure out what's
happening ?

Unfortunately n_tty_receive_overrun() is an inline function. Can you
make it a non inline so it gets covered by the function tracer ?

Then you can magically stop the tracer with a filter:

# echo 'n_tty_receive_overrun:traceoff' > DEBUGFSMOUNTPOINT/tracing/set_ftrace_filter

Further info about the tracer is here: http://lwn.net/Articles/370423/

If you have a trace please put it up to some ftp/http site or mail it
to me privately.

Thanks,

	tglx
