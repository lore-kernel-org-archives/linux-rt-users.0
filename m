From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: merge of real-time 2.6.33.9-rt31 with stable 2.6.33.13
Date: Sat, 14 May 2011 18:28:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1105141827270.3078@ionos>
References: <alpine.LFD.2.00.1105141749180.29326@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45587 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab1ENQ23 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 May 2011 12:28:29 -0400
In-Reply-To: <alpine.LFD.2.00.1105141749180.29326@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 14 May 2011, John Kacur wrote:
> I did some light testing merging 2.6.33.13 into real-time 2.6.33.9-rt31.
> In addition I cherry-picked 3c955b407a084810f57260d61548cc92c14bc627
> in order to compile on newer distros.

Thanks.
 
> Here is the result of cyclic test on one machine
> sudo ./cyclictest -t32 -p 80 -n -i 10000 -l 10000
> policy: fifo: loadavg: 0.00 0.00 0.00 1/541 3759          
> 
> T: 0 ( 3728) P:80 I:10000 C:  10000 Min:      7 Act:  104 Avg:  114 Max:     470

The numbers are weird. How does that compare to older kernels on that
machine with the same test?

Thanks,

	tglx
