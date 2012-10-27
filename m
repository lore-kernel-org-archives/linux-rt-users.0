From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Sat, 27 Oct 2012 11:50:37 +0200
Message-ID: <op.wmt0antg6426ze@millennium.getinternet.no>
References: <op.wms2phwb6426ze@millennium.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:56294 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab2J0Jsw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Oct 2012 05:48:52 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCJ00DVHPXFTV80@get-mta-out03.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Sat, 27 Oct 2012 11:48:51 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id EC5711EA681B_8BAE02B	for <linux-rt-users@vger.kernel.org>; Sat,
 27 Oct 2012 09:48:50 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 78B211EA65E6_8BAE02F	for <linux-rt-users@vger.kernel.org>; Sat,
 27 Oct 2012 09:48:50 +0000 (GMT)
Received: from millennium.getinternet.no ([84.211.32.31])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCJ008W0PXE7M10@get-mta-in03.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Sat, 27 Oct 2012 11:48:50 +0200 (MEST)
In-reply-to: <op.wms2phwb6426ze@millennium.getinternet.no>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I did some small edits, but not really any difference to how the kernel  
works. Such as a 90hz timer. Which seemed to work the best here, for  
lowest jitter in OpenGL. I have actually had a lot of fun with the kernel,  
and games are indeed much more immersive with low-jitter. It just creates  
a higher expectation to quality, and for some games also make some  
paradigms a bit outdated. Such as some horrorscenes in doom 3. Doom 3  
plays extremely well here now though. Also improving the action on the  
fastest bus (PCIe), seem to generally improve the whole system.  
Videojitter is lower, although ofcourse it needs to be completely fixed  
with sync and refresh rate changes. System is more responsive. So I  
believe that reducing jitter, seems central to a good computing experience.

Will be fun to try rt patch also, although current mainline is very close  
to doing 0.2ms latency, there is just a few clicks at 0.3 (without  
realtime threads) here. Meaning that os-jitter on average is lower than  
0.2ms. Having used an amiga500, and knowing how that feels. 0.3ms feels  
close, but maybe just a bit lower. So 0.2ms. And that is the kind of  
computer I want.

I am also building a machine particulary for low-jitter.  
http://paradoxuncreated.com/Blog/wordpress/?p=4176

So if we can`t get RT running on this one, and it seems many are getting  
it to work, atleast maybe it will work on the new. And if mainline does  
maxjitter/latency below 0.2ms on the new machine, which will be very  
specifically tuned for low latency hardware-wise, I ofcourse don`t need  
rt, unless there should be an argument of better performance still, which  
most seem to think there isn`t.

So anyway down to 0.2ms is where I care. I think. Great job on doing RT  
though, but unfortunately it hasn`t worked here. Actually I could try a  
live RT distro, on my mac mini also. :)

Peace Be With You.
