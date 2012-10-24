From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 12:48:16 +0200
Message-ID: <op.wmoiyqew6426ze@localhost.localdomain>
References: <alpine.LFD.2.02.1210202133470.2719@ionos>
 <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos>
 <op.wmnlvqm76426ze@localhost.localdomain>
 <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241156380.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:34694 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758120Ab2JXKsU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 06:48:20 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00L6B8OJSM70@get-mta-out01.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 12:48:19 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 530801EF97B4_87CAFEB	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 11:03:26 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 0583A1EF97A5_87CAFEF	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 11:03:26 +0000 (GMT)
Received: from localhost.localdomain ([84.211.57.6])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00GCI8OID800@get-mta-in01.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 12:48:19 +0200 (MEST)
In-reply-to: <alpine.LFD.2.02.1210241156380.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012 11:59:38 +0200, Thomas Gleixner <tglx@linutronix.de>  
wrote:

> On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
>> On Wed, 24 Oct 2012 07:01:54 +0200, Sven-Thorsten Dietrich
>> <sven@thebigcorporation.com> wrote:
>>
>> >
>> > On Oct 23, 2012, at 3:53 PM, Uwaysi Bin Kareem
>> > <uwaysi.bin.kareem@paradoxuncreated.com> wrote:
>> >
>> > > I think it complains about not finding rootdevice. Anyway, I am  
>> getting a
>> > > new machine, so it might not be much of an issue. If you still want  
>> to try
>> > > and find the bug let me know. Also how do I compile without  
>> threadirqs, if
>> > > I enable basic-rt, threadirqs are enabled in .config also.
>> >
>> > rootdevice issues are most likely drivers/initrd related. Does your  
>> .config
>> > match a working Kernel's .config?
>>
>> Yes, it works fine without basic-rt, or full-rt. Do you know if  
>> basic-rt can
>> be compiled without threadirqs?
>
> No. And that's not interesting at all. We really want to know what's
> going wrong when you have irq threading enabled.
>
> You can also try the following. Compile the kernel without RT and add
> "threadirqs" on the kernel command line. So that's just mainline + irq
> threading. Does that work?
>
> In any case it would be helpful if you provide the full dmesg output
> of a failing boot.
>
> Thanks,
>
> 	tglx
>

Ok, you reall want to know. Well I can do anything to help you with that.  
Does dmseg contain info from last boot? Or can it be accessed from the  
console-thingy?

Mainline does also not work with threadirq.

Peace Be With You.
