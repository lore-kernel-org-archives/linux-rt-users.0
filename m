From: Brian Hutchinson <b.hutchman@gmail.com>
Subject: Re: Seeing 800us of latency with cyclictest on a PC with 2.6.26.8 rt patch. Is that normal?
Date: Wed, 11 Mar 2009 19:31:01 +0000 (UTC)
Message-ID: <loom.20090311T192407-52@post.gmane.org>
References: <14400.1236703161@vtxmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38716 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923AbZCKTbR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Mar 2009 15:31:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LhU95-0008Iu-8g
	for linux-rt-users@vger.kernel.org; Wed, 11 Mar 2009 19:31:15 +0000
Received: from 64-4-119-229.va.mvl.ntelos.net ([64.4.119.229])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Mar 2009 19:31:15 +0000
Received: from b.hutchman by 64-4-119-229.va.mvl.ntelos.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Mar 2009 19:31:15 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Matthias Luescher <m.luescher <at> vtxmail.ch> writes:

> 
> > Specifically, my laptop is a Dell Latitude D620.
> 
> We have tried very hard to achieve real time performance with the 
> Dell Latitude D620 (we have tested different kernels, different configurations,
> different bios versions, modified the bios settings, called the Dell customer
service, ...). 
> After all it looks like there is no way to achieve hard real time performance
with this
> type of device.
> 
> We had more luck (sub 100us latency) with the following notebooks:
> - Lenovo T61, with dual core processor T8300, 2 GB RAM
> - Asus V1SSeries with dual core processor T7500
> 
> On both devices we had to disable some power management features.
> Please note that pressing some function keys can still result in huge
latencies if 
> the bios implementation is bad enough.
> 
> Desktop PCs usually work without big latencies.
> 
> Best regards
> Matthias
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Just wanted to post an update.  I build 2.6.24.7 with rt patch and installed on
a 10 year old ASUS MEW motherboard with a 366MHz Celeron running Debian 5.0.

Cyclictest -a -t -n -p99 reports avg of 29us and max of 74us!!!  Wow!

OK, now I just need to do the same thing on a ARM 926EJ-S board (once I get one).

Thanks to everyone for all the suggestions.  I wouldn't have thought that 10
year old desktop hardware could beat the pants off a modern laptop.




