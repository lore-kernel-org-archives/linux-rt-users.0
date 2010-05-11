From: "Asier Tamayo" <asier.tamayo@ona-electroerosion.com>
Subject: RE: PREEMPT_RT patch vs RTAI/Xenomai
Date: Tue, 11 May 2010 17:30:33 +0200
Message-ID: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com>
References: <4BE975BF.1030305@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "Nivedita Singhvi" <niv@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ona-electroerosion.com ([212.81.200.66]:48195 "EHLO
	mail.ona-electroerosion.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753611Ab0EKPjG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 May 2010 11:39:06 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4BE975BF.1030305@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Nivedita,

Thanks for your answer.

> What are your criteria?  Do you care about anything other
> than performance (availability, upgrades, cost, support,
> compatibility, tools, ...)?
> 
> (...) you're best off testing the solutions that you can 
> get hold of with your own workload, in your own environment.
> 
Performance is a must. Besides, costs and tools are very important. Support is also important, but I guess I'd find some good support for any of the solutions.

My new CPU has an Intel Atom N270 @1.6 GHz processor. At the moment (during the porting it might be optimized), I have 5 drivers requering hard real-time (no loop can be skipped) and being called every 2 to 10 ms. In fact, at the beginning I was using 1 ms, but I had some problems with the hard real-time and changed the timing to 2 ms. I do not consider using a legacy OS emulation.

I know my final decission will have to be made after some real tests on my own system, but at this moment I'm trying to gather as much information as I can, regarding the pros and cons of each solution.

> Also, fwiw, there are 2 enterprise distros (Red Hat's MRG
> and Novell's SLERT) providing real-time (both based on the
> Linux RT patchset).
> 
Thank you very much. I'll have a look at them.

Best regards,

Asier.



> -----Original Message-----
> From: Nivedita Singhvi [mailto:niv@us.ibm.com]
> Sent: Tuesday, May 11, 2010 5:21 PM
> To: Asier Tamayo
> Cc: linux-rt-users@vger.kernel.org
> Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
> 
> 
> Asier Tamayo wrote:
> > Hello all:
> > 
> > I'm just a newbie to this list, so just forgive me if my 
> question is obvious or has been answered many times ;-)
> > 
> > I want to do a port from an old system running a 
> proprietary RTOS to a new one based in Linux. My system runs 
> many applications at the same time (GUI, parsers, ...), a few 
> of which are hard real-time. 
> > 
> > I've searched the web, but am still unable to decide which 
> system to use: RTAI, Xenomai or the PREEMPT_RT patch. Can 
> anyone give me some clue in this issue? Are there any 
> advantages in choosing the PREEMPT_RT patches over Xenomai or 
> RTAI? Running the GUI, which demands a lot of CPU and RAM, 
> can have any effect on the real-time behaviour?
> > 
> > I've seen many comparisons, but in this fast-changing 
> world, most of them seem to me to be quite out of date.
> > 
> > Any hint will be really helpful,
> 
> What are your criteria?  Do you care about anything other
> than performance (availability, upgrades, cost, support,
> compatibility, tools, ...)?
> 
> If your most important criteria is how well your applications
> perform (whatever that means for you), you're best off testing
> the solutions that you can get hold of with your own workload,
> in your own environment.
> 
> Also, fwiw, there are 2 enterprise distros (Red Hat's MRG
> and Novell's SLERT) providing real-time (both based on the
> Linux RT patchset).
> 
> thanks,
> Nivedita
> 
