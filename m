From: raz ben yehuda <raziebe@gmail.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Fri, 28 Aug 2009 18:22:43 +0300
Message-ID: <1251472963.3705.26.camel@raz>
References: <1251282598.3514.20.camel@raz>
	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
	 <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz>
	 <1251300625.18584.18.camel@twins>
	 <alpine.DEB.1.10.0908261136590.9933@gentwo.org>
	 <1251302598.18584.31.camel@twins>
	 <alpine.DEB.1.10.0908261211340.9933@gentwo.org>
	 <20090826180407.GA13632@elte.hu>
	 <alpine.DEB.1.10.0908261509580.9933@gentwo.org>
	 <20090826193252.GA14721@elte.hu>
	 <alpine.DEB.1.10.0908261627110.5554@gentwo.org>
	 <20090826135041.e6169d18.akpm@linux-foundation.org>
	 <4A95A5EE.90400@nortel.com> <1251322663.3882.48.camel@raz>
	 <4A96B997.1070001@nortel.com> <1251408785.3700.22.camel@raz>
	 <alpine.LFD.2.00.0908272348370.2888@localhost.localdomain>
	 <1251448697.3872.15.camel@raz>  <4A97DAE7.40603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Chris Friesen <cfriesen@nortel.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	wiseman@macs.biu.ac.il, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752558AbZH1PWp@vger.kernel.org>
In-Reply-To: <4A97DAE7.40603@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Fri, 2009-08-28 at 09:25 -0400, Rik van Riel wrote:
> raz ben yehuda wrote:
> 
> > yes. latency is a crucial property. 
> 
> In the case of network packets, wouldn't you get a lower
> latency by transmitting the packet from the CPU that
> knows the packet should be transmitted, instead of sending
> an IPI to another CPU and waiting for that CPU to do the
> work?
Hello Rik
If I understand what you are saying, you say that I pass 1.5K packets to
a offline CPU ?
If so, then this is not what I do, because you are very right, it does
not make any sense. 
I do not pass packets to an offline cpu , i pass assignments. an
assignment is a buffer with some context of what do with it (like aio)
and a buffer is of ~1MB. Also, the offline processor holds the network
interface as it own interface. No two offline processors transmit over a
single interface.( I modified the bonding driver to work with offline
processor for that ). I am aware of network queue per processors, but
benchmarks proved this was better.( I do not have these benchmarks
now). 
Also these engines do not release any sk_buffs to the operating system,
these packets are being reused over and over to reduce latency of
allocating memory and cache misses. 
Also, in some cases I disabled the transmit interrupts and I released
packets ( --skb->users was still greater than 0, not really release ) in
an offline context.I learned it from the chelsio driver. This way, I
reduced more load from the operating system. It proved to be better in
large 1Gbps arrays and was able to remove atomic_inc atomic_dec in some
variants of the code, atomic operations cost a lot.  
in MSI cards I did not find it useful.in the example i showed, i use MSI
and system is almost idle.
Also, as I recall , IPI will not pass to an offladed processor. offsced
it runs NMI.
Also, I would to express my apologies if any of this correspondence
seems to be as I am trying to PR offsched. I am not.
> Inter-CPU communication has always been the bottleneck
> when it comes to SMP performance.  Why does adding more
> inter-CPU communication make your system faster, instead
> of slower like one would expect?
> 
