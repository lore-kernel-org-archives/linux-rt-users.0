From: Nicholas Mc Guire <mcguire@lzu.edu.cn>
Subject: Re: Strange spikes using linux-rt kernel
Date: Fri, 3 Jul 2009 16:48:06 +0200
Message-ID: <20090703144806.GB18330@opentech.at>
References: <175121.57868.qm@web112506.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Pedro R <eusou15@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [212.69.189.236] ([212.69.189.236]:36592 "EHLO mail.hofr.at"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753983AbZGCO5R (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Jul 2009 10:57:17 -0400
Content-Disposition: inline
In-Reply-To: <175121.57868.qm@web112506.mail.gq1.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 03 Jul 2009, Pedro R wrote:

> 
> Hi!
> 
> I'll resume my problem: in CyclicTest I have an average of about 20-30us and peaks of 5000-6000us. These peaks are really annoying, since i'm using this system for firewire audio and each time there is a peak, an underrun in jackd causes a drop in sound. I have confirmed that these peaks are the direct cause of the underruns.
> The peaks appear to occur randomly, most of the time in less than a minute of using CyclicTest and continue every minute or twice a minute (hard to say, since when CyclicTest hits a max value like 6000us, i'm not quick enough to read the actual peaks which achieve less than that - but the peaks continue).
> 
> I left my system running the hwlat_detector module for 8 hours and all i got in the sample file was a bunch of 1's along with their timestamps, so the problem must not be the SMI.
> 
> This problem also happens without the rt patch. I have tried using 2.6.26.2 (non-rt) kernel and I have the same problem. I also tried using 2.6.23-rt and 2.6.26-rt and it also happens.
>

two thoughts:
 - first it might be that you are runing a SCHED_FIFO task with
  a priority above the interrupt threads in which case you might
  be starving the data processing 
- second it might be a driver problem of the firewire driver you
  are using.

so to detect case two with resonable likelyhood could you run cyclictest on an 
idle system for some time and on a loaded system not using the firewire ? 
but write the entire log into a file (sorry forgot which flag to cyclictest 
that was -v or -o I think) - look at the distribution of jitter not only the
maxima. regarding the first case - check the priority of the SCHED_FIFO tasks
in the system to make sure you are not simply starving the irq threads. 

hofrat
