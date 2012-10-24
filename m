From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 10:16:31 +0200
Message-ID: <op.wmobxtv66426ze@localhost.localdomain>
References: <alpine.LFD.2.02.1210202133470.2719@ionos>
 <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos>
 <op.wmnlvqm76426ze@localhost.localdomain>
 <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:45573 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757965Ab2JXIQg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 04:16:36 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00H4I1NM0640@get-mta-out02.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 10:16:34 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8E218179BBA0_87A76CB	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 08:31:40 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 23EDA1797757_87A76CF	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 08:31:40 +0000 (GMT)
Received: from localhost.localdomain ([84.211.57.6])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00AN71NL0J20@get-mta-in02.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 10:16:33 +0200 (MEST)
In-reply-to: <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012 07:01:54 +0200, Sven-Thorsten Dietrich  
<sven@thebigcorporation.com> wrote:

>
> On Oct 23, 2012, at 3:53 PM, Uwaysi Bin Kareem  
> <uwaysi.bin.kareem@paradoxuncreated.com> wrote:
>
>> I think it complains about not finding rootdevice. Anyway, I am getting  
>> a new machine, so it might not be much of an issue. If you still want  
>> to try and find the bug let me know. Also how do I compile without  
>> threadirqs, if I enable basic-rt, threadirqs are enabled in .config  
>> also.
>
> rootdevice issues are most likely drivers/initrd related. Does your  
> .config match a working Kernel's .config?

Yes, it works fine without basic-rt, or full-rt. Do you know if basic-rt  
can be compiled without threadirqs?

Peace Be With You.
