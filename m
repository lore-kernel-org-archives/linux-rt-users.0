From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 19:06:27 +0200
Message-ID: <op.wmo0g1qc6426ze@localhost.localdomain>
References: <alpine.LFD.2.02.1210202133470.2719@ionos>
 <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos>
 <op.wmnlvqm76426ze@localhost.localdomain>
 <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241156380.2756@ionos>
 <op.wmoiyqew6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241621060.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:37120 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075Ab2JXRGd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 13:06:33 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00AZ3Q6VS170@get-mta-out01.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 19:06:31 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D155A1F1A15F_882017B	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 17:06:31 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A49141F1A150_882017F	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 17:06:31 +0000 (GMT)
Received: from localhost.localdomain ([84.211.57.6])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00D2VQ6STT40@get-mta-in03.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 19:06:31 +0200 (MEST)
In-reply-to: <alpine.LFD.2.02.1210241621060.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012 16:27:54 +0200, Thomas Gleixner <tglx@linutronix.de>  
wrote:

> On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
>> On Wed, 24 Oct 2012 11:59:38 +0200, Thomas Gleixner <tglx@linutronix.de>
>> wrote:
>> > In any case it would be helpful if you provide the full dmesg output
>> > of a failing boot.
>>
>> Ok, you reall want to know. Well I can do anything to help you with  
>> that. Does
>> dmseg contain info from last boot? Or can it be accessed from the
>> console-thingy?
>
> If you have a serial port on that machine, then you can enable the
> serial console with "console=ttyS0,115200" on the kernel command
> line. Use a second machine to record the data.
>
> If you don't have a serial, then you should be able to do something
> from the initrd shell. Your ethernet driver should be loaded already,
> if not just compile it into the kernel instead into a module. Now you
> can get it out over the net from that shell.
> A third option is to use netconsole. Do this on mainline with the
> "threadirqs" option, as I haven't tried netconsole on RT.
> See Documentation/networking/netconsole.txt
>
>> Mainline does also not work with threadirq.
>
> Good. So it's not RT wreckage :)
>
> Thanks,
>
> 	tglx

Actually I don`t think I have a serial port, now that I think of it. Or  
atleast not 2 at the moment. I can try initrd shell first, and netconsole  
as the last alternative.

I can ofcourse always compile with net in, but what I needed was dmseg  
right? Actually I have an old pic of this error.
http://www.paradoxuncreated.com/tmp/rterror.jpg

Do you need more?

Peace Be With You.
