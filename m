From: Brian Hutchinson <b.hutchman@gmail.com>
Subject: Re: Seeing 800us of latency with cyclictest on a PC with 2.6.26.8 rt patch. Is that normal?
Date: Tue, 10 Mar 2009 15:40:27 +0000 (UTC)
Message-ID: <loom.20090310T153726-200@post.gmane.org>
References: <loom.20090310T140426-205@post.gmane.org> <1236696976.28103.40.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:54419 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbZCJPkl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 10 Mar 2009 11:40:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lh44I-0000uz-Ol
	for linux-rt-users@vger.kernel.org; Tue, 10 Mar 2009 15:40:35 +0000
Received: from us194px01-pat.tycoelectronics.net ([us194px01-pat.tycoelectronics.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2009 15:40:34 +0000
Received: from b.hutchman by us194px01-pat.tycoelectronics.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Mar 2009 15:40:34 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sven-Thorsten Dietrich <sven <at> thebigcorporation.com> writes:


> What hardware are you testing on? 
> 
> You should compare to the 2.6.24-RT patch set first of all, I would
> expect worst-cases to be 25% of what you are seeing.
> 
> If it does not, then your configuration may have too much debugging
> turned on (boot log warns about some of these) - or you are indeed
> getting some SMI interference.
> 
> SMIs can be turned off in many cases. 
> 
> Some vendors have warranty/support programs tied to SMI architectures,
> in these cases you might be able to press them for a custom BIOS
> (depending on volume and how much hell you want to raise)
> 
> Cheers,
> 
> Sven

Thanks for your quick reply.

Specifically, my laptop is a Dell Latitude D620.  I turned off a lot of the
features in Kernel Hacking section (stack checking etc.)

I haven't ran cyclictest with the -b option yet as I can't find some of the
.config parameters in this kernel that match the cyclictest latency checking
documentation.  Before I beat my head against the wall too hard I thought I'd
ping others and see if what I'm seeing is normal or if others were able to run
on a PC and obtain very low latency.

I'm trying to come up to speed on the latest 2.6 kernels after having most
experience with 2.4 and early 2.6.  I see the TSC isn't used anymore.  I thought
about just not using ACPI but I think that will kill my high res timers.  I do
see a local ACPI option so I don't know if that will make high res timers work
... I'm reading conflicting/dated info. so I thought I'd consult the experts so
they can show me the way :)

Regards,

Brian 




