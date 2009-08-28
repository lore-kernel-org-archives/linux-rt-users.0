From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Fri, 28 Aug 2009 08:14:20 +0200
Message-ID: <1251440060.18584.103.camel@twins>
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
	 <4A96B997.1070001@nortel.com>
	 <alpine.DEB.1.10.0908271257270.17470@gentwo.org>
	 <alpine.LFD.2.00.0908272242500.2888@localhost.localdomain>
	 <4A97071F.5070804@novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Christoph Lameter <cl@linux-foundation.org>,
	Chris Friesen <cfriesen@nortel.com>,
	raz ben yehuda <raziebe@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	maximlevitsky@gmail.com, efault@gmx.de, riel@redhat.com,
	wiseman@macs.biu.ac.il, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:36327 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZH1GQG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Aug 2009 02:16:06 -0400
In-Reply-To: <4A97071F.5070804@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2009-08-27 at 18:22 -0400, Gregory Haskins wrote:

> I wonder if it makes sense to do something along the lines of the
> sched-class...

Disabling the tick isn't a big deal from the scheduler's point of view,
its all the other accounting crap that happens.


