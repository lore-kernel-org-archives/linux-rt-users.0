From: raz ben yehuda <raziebe@gmail.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Thu, 27 Aug 2009 00:34:13 +0300
Message-ID: <1251322453.3882.44.camel@raz>
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
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Christoph Lameter <cl@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, cfriesen@nortel.com,
	efault@gmx.de, riel@redhat.com, wiseman@macs.biu.ac.il,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:51026 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbZHZVeR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Aug 2009 17:34:17 -0400
In-Reply-To: <20090826135041.e6169d18.akpm@linux-foundation.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2009-08-26 at 13:50 -0700, Andrew Morton wrote:
> On Wed, 26 Aug 2009 16:40:09 -0400 (EDT)
> Christoph Lameter <cl@linux-foundation.org> wrote:
> 
> > Peter has not given a solution to the problem. Nor have you.
> 
> What problem?
> 
> All I've seen is "I want 100% access to a CPU".  That's not a problem
> statement - it's an implementation.
> 
> What is the problem statement?
> 
> 
> My take on these patches: the kernel gives userspace unmediated access
> to memory resources if it wants that.  The kernel gives userspace
> unmediated access to IO devices if it wants that.  But for some reason
> people freak out at the thought of providing unmediated access to CPU
> resources.
> 
> Don't get all religious about this.  If the change is clean,
> maintainable and useful then there's no reason to not merge it.
thank you Mr Morton. thank you !!!


