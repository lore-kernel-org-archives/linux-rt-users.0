From: Rik van Riel <riel@redhat.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Fri, 28 Aug 2009 09:25:59 -0400
Message-ID: <4A97DAE7.40603@redhat.com>
References: <1251282598.3514.20.camel@raz>	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>	 <1251297910.1791.22.camel@maxim-laptop> <1251298443.4791.7.camel@raz>	 <1251300625.18584.18.camel@twins>	 <alpine.DEB.1.10.0908261136590.9933@gentwo.org>	 <1251302598.18584.31.camel@twins>	 <alpine.DEB.1.10.0908261211340.9933@gentwo.org>	 <20090826180407.GA13632@elte.hu>	 <alpine.DEB.1.10.0908261509580.9933@gentwo.org>	 <20090826193252.GA14721@elte.hu>	 <alpine.DEB.1.10.0908261627110.5554@gentwo.org>	 <20090826135041.e6169d18.akpm@linux-foundation.org>	 <4A95A5EE.90400@nortel.com> <1251322663.3882.48.camel@raz>	 <4A96B997.1070001@nortel.com> <1251408785.3700.22.camel@raz>	 <alpine.LFD.2.00.0908272348370.2888@localhost.localdomain> <1251448697.3872.15.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Chris Friesen <cfriesen@nortel.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	wiseman@macs.biu.ac.il, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: raz ben yehuda <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2820 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbZH1N0p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Aug 2009 09:26:45 -0400
In-Reply-To: <1251448697.3872.15.camel@raz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

raz ben yehuda wrote:

> yes. latency is a crucial property. 

In the case of network packets, wouldn't you get a lower
latency by transmitting the packet from the CPU that
knows the packet should be transmitted, instead of sending
an IPI to another CPU and waiting for that CPU to do the
work?

Inter-CPU communication has always been the bottleneck
when it comes to SMP performance.  Why does adding more
inter-CPU communication make your system faster, instead
of slower like one would expect?

-- 
All rights reversed.
