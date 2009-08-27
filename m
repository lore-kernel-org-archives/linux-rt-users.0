From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Thu, 27 Aug 2009 10:51:35 -0600
Message-ID: <4A96B997.1070001@nortel.com>
References: <1251282598.3514.20.camel@raz>	 <alpine.DEB.1.10.0908260943090.9924@gentwo.org>	 <1251297910.1791.22.camel@maxim-laptop>	<1251298443.4791.7.camel@raz>	 <1251300625.18584.18.camel@twins>	 <alpine.DEB.1.10.0908261136590.9933@gentwo.org>	 <1251302598.18584.31.camel@twins>	 <alpine.DEB.1.10.0908261211340.9933@gentwo.org>	 <20090826180407.GA13632@elte.hu>	 <alpine.DEB.1.10.0908261509580.9933@gentwo.org>	 <20090826193252.GA14721@elte.hu>	 <alpine.DEB.1.10.0908261627110.5554@gentwo.org>	 <20090826135041.e6169d18.akpm@linux-foundation.org>	 <4A95A5EE.90400@nortel.com> <1251322663.3882.48.camel@raz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	riel@redhat.com, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: raz ben yehuda <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from zrtps0kp.nortel.com ([47.140.192.56]:57762 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbZH0QwG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Aug 2009 12:52:06 -0400
In-Reply-To: <1251322663.3882.48.camel@raz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/26/2009 03:37 PM, raz ben yehuda wrote:
> 
> On Wed, 2009-08-26 at 15:15 -0600, Chris Friesen wrote:

>> We gave it as close to a whole cpu as we could using cpu and irq
>> affinity and we used message queues in shared memory to allow another
>> cpu to handle I/O.  In our case we still had kernel threads running on
>> the app cpu, but if we'd had a straightforward way to avoid them we
>> would have used it.

> Chris. I offer myself to help anyone wishes to apply OFFSCHED.

I just went and read the docs.  One of the things I noticed is that it
says that the offlined cpu cannot run userspace tasks.  For our
situation that's a showstopper, unfortunately.

Chris

