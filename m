From: Peter Feuerer <peter@piie.net>
Subject: Re: catching interrupts
Date: Wed, 13 Jun 2007 09:58:25 +0200
Message-ID: <1181721505.5703.7.camel@localhost.localdomain>
References: <1181679431.4904.2.camel@localhost.localdomain>
	 <466F3484.3000202@l1nuxh4ck3r.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:44152 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012AbXFMH63 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jun 2007 03:58:29 -0400
In-Reply-To: <466F3484.3000202@l1nuxh4ck3r.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-06-13 at 02:04 +0200, Bernhard Kuhn wrote:
> Peter Feuerer wrote:
> 
> > is it possible to catch e.g. the interrupt of the Parallelport (IRQ7 in
> > my case) in userspace with a RT-Rreempt patched kernel?
> 
> A very simple solution would be to create a small kernel device driver
> that implements a blocking read function that always gets woken up
> by the parport interrupt service routine, then sending one dummy byte.

That would be a very fast and easy to implement solution, but then I
have to touch the kernel again. I wanted not to do that.

> But i guess a better variant would be to adopt the IIO framework
> for your purpose (http://lkml.org/lkml/2006/8/30/22)

Great, seems like that's what I'm searching for. I will have a deeper
look into this. Because if this is going to be in the mainline kernel, I
don't have to touch the kernel at all.
Thanks.

regards,
--peter
