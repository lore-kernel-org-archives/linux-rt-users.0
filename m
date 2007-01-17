From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: changes to task_blocks_on_rt_mutex between 18-rt6 and 20-rc5-rt3
Date: Wed, 17 Jan 2007 12:14:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701171158320.16286@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0701161642470.16286@pcgl.dsa-ac.de>
 <1169025704.2941.215.camel@localhost.localdomain>
 <Pine.LNX.4.63.0701171127030.16286@pcgl.dsa-ac.de>
 <1169031749.2941.220.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:51456 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbXAQLOq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jan 2007 06:14:46 -0500
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1169031749.2941.220.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 17 Jan 2007, Thomas Gleixner wrote:

> On Wed, 2007-01-17 at 11:46 +0100, Guennadi Liakhovetski wrote:
>> Unable to handle kernel paging request at virtual address 00025d87
>
> Memory corruption ?

Looks like access after free or variable on old stack, but I cannot find 
anything like this in the code.

>> PC is at task_blocks_on_rt_mutex+0xb8/0x2a8
>
> Can you decode the exact code line, so we know what it tries to access ?

It crashes in different places, I think, it is in rt_mutex_top_waiter() 
line 440, in plist_first_entry(), that's where offset 44 comes from, I 
think. Sometimes it also crashes on BUG_ON(w->lock != lock); below that 
call.

>> (yes, tainted, you know, it's the software that has been written before
>>  Linux...)
>
> Sigh....

Sorry.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
