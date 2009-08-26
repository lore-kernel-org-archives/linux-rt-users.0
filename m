From: raz ben yehuda <raziebe@gmail.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Thu, 27 Aug 2009 00:37:43 +0300
Message-ID: <1251322663.3882.48.camel@raz>
References: <1251282598.3514.20.camel@raz>
	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>
	 <1251297910.1791.22.camel@maxim-laptop>	<1251298443.4791.7.camel@raz>
	 <1251300625.18584.18.camel@twins>
	 <alpine.DEB.1.10.0908261136590.9933@gentwo.org>
	 <1251302598.18584.31.camel@twins>
	 <alpine.DEB.1.10.0908261211340.9933@gentwo.org>
	 <20090826180407.GA13632@elte.hu>
	 <alpine.DEB.1.10.0908261509580.9933@gentwo.org>
	 <20090826193252.GA14721@elte.hu>
	 <alpine.DEB.1.10.0908261627110.5554@gentwo.org>
	 <20090826135041.e6169d18.akpm@linux-foundation.org>
	 <4A95A5EE.90400@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	riel@redhat.com, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:50740 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbZHZVht (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 17:37:49 -0400
In-Reply-To: <4A95A5EE.90400@nortel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2009-08-26 at 15:15 -0600, Chris Friesen wrote:
> On 08/26/2009 02:50 PM, Andrew Morton wrote:
> 
> > What problem?
> > 
> > All I've seen is "I want 100% access to a CPU".  That's not a problem
> > statement - it's an implementation.
> > 
> > What is the problem statement?
> 
> I can only speak for myself...
> 
> In our case the problem statement was that we had an inherently
> single-threaded emulator app that we wanted to push as hard as
> absolutely possible.
> 
> We gave it as close to a whole cpu as we could using cpu and irq
> affinity and we used message queues in shared memory to allow another
> cpu to handle I/O.  In our case we still had kernel threads running on
> the app cpu, but if we'd had a straightforward way to avoid them we
> would have used it.
> 
> Chris
Chris. I offer myself to help anyone wishes to apply OFFSCHED.
  



