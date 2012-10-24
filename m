From: Uwaysi Bin Kareem <uwaysi.bin.kareem@paradoxuncreated.com>
Subject: Re: [ANNOUNCE] 3.6.2-rt4
Date: Wed, 24 Oct 2012 20:47:25 +0200
Message-ID: <op.wmo45bu46426ze@localhost.localdomain>
References: <alpine.LFD.2.02.1210202133470.2719@ionos>
 <op.wmk8f6m96426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210222029480.2756@ionos>
 <op.wmnlvqm76426ze@localhost.localdomain>
 <1B7B1319-351B-4E55-9BC7-DC8659605594@thebigcorporation.com>
 <op.wmobxtv66426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241156380.2756@ionos>
 <op.wmoiyqew6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210241621060.2756@ionos>
 <op.wmo0g1qc6426ze@localhost.localdomain>
 <alpine.LFD.2.02.1210242037440.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7BIT
Cc: sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.getmail.no ([84.208.15.66]:56750 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758580Ab2JXSr1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Oct 2012 14:47:27 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00B87UV29CA0@get-mta-out02.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 20:47:26 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 070A1179BC4F_8837BEB	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 18:47:26 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id CBC1717A1495_8837BDF	for <linux-rt-users@vger.kernel.org>; Wed,
 24 Oct 2012 18:47:25 +0000 (GMT)
Received: from localhost.localdomain ([84.211.57.6])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0MCE00H64UV1KL40@get-mta-in02.get.basefarm.net> for
 linux-rt-users@vger.kernel.org; Wed, 24 Oct 2012 20:47:25 +0200 (MEST)
In-reply-to: <alpine.LFD.2.02.1210242037440.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 24 Oct 2012 20:38:36 +0200, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Wed, 24 Oct 2012, Uwaysi Bin Kareem wrote:
>> On Wed, 24 Oct 2012 16:27:54 +0200, Thomas Gleixner <tglx@linutronix.de>
>> wrote:
>> I can ofcourse always compile with net in, but what I needed was dmseg  
>> right?
>> Actually I have an old pic of this error.
>> http://www.paradoxuncreated.com/tmp/rterror.jpg
>
> So the ata controller fails. Which driver is in use?
>
> Thanks,
>
> 	tglx

sata_nv
