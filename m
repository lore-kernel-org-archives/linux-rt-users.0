From: Peter Feuerer <peter@piie.net>
Subject: Re: catching interrupts
Date: Wed, 13 Jun 2007 10:31:08 +0200
Message-ID: <1181723468.5703.17.camel@localhost.localdomain>
References: <1181679431.4904.2.camel@localhost.localdomain>
	 <466F3484.3000202@l1nuxh4ck3r.de>
	 <1181721505.5703.7.camel@localhost.localdomain>
	 <1181722808.8176.255.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:51589 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755296AbXFMIbM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jun 2007 04:31:12 -0400
In-Reply-To: <1181722808.8176.255.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2007-06-13 at 10:20 +0200, Thomas Gleixner wrote:
> On Wed, 2007-06-13 at 09:58 +0200, Peter Feuerer wrote:
> > That would be a very fast and easy to implement solution, but then I
> > have to touch the kernel again. I wanted not to do that.
> > 
> > > But i guess a better variant would be to adopt the IIO framework
> > > for your purpose (http://lkml.org/lkml/2006/8/30/22)
> > 
> > Great, seems like that's what I'm searching for. I will have a deeper
> > look into this. Because if this is going to be in the mainline kernel, I
> > don't have to touch the kernel at all.
> 
> You have to touch it. You still need to write a kernel module which
> handles the interrupt in the first place.
> 

But wouldn't it be a good idea to create a kernel driver which offers an
abstract interface and add it to the mainline kernel or to the preempt
patch? So that handling interrupts can really just happen by coding a
userspace program?
Or is there no way to accomplish that? Sorry if this questions may sound
stupid, I'm not that deep in the code,.. yet.

--peter
