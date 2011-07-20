From: "Madovsky" <infos@madovsky.org>
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0
Date: Wed, 20 Jul 2011 11:59:24 -0400
Message-ID: <7735DD508B2B433B9B13F223209C5F85@e1705>
References: <alpine.LFD.2.02.1107200153070.2702@ionos> <4E26B721.9020103@steinhoff.de> <CCEC72C697934346AA1E7D01E8DA2EF5@e1705> <alpine.LFD.2.02.1107201753220.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ip-67-205-80-138.static.privatedns.com ([67.205.80.138]:32168
	"EHLO node250.e-blokos.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584Ab1GTP7f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jul 2011 11:59:35 -0400
Received: from e1705 (localhost.localdomain [127.0.0.1])
	by node250.e-blokos.com (8.14.3/8.14.3) with SMTP id p6KFxYSF006347
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Jul 2011 11:59:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

----- Original Message ----- 
From: "Thomas Gleixner" <tglx@linutronix.de>
To: "Madovsky" <infos@madovsky.org>
Cc: "linux-rt-users" <linux-rt-users@vger.kernel.org>
Sent: Wednesday, July 20, 2011 11:56 AM
Subject: Re: [ANNOUNCE] 3.0-rc7-rt0


> Franck,
> 
> On Wed, 20 Jul 2011, Madovsky wrote:
> 
>> Hi Thomas,
>> 
>> I just compiled the kernel with the patch on my whole cluster
>> of 6 fedora10 and the results are very stable and smooth.
> 
> Thanks for the report !
you're welcome ! :D

>> the only little thing is the cluster software heartbeat / pacemaker
>> takes 20% of cpu that 11% before on a dual xeon nocona with
>> linux command "top".
> 
> That might be related to the new mechanism how we handle softirqs. If
> the heartbeat/pacemaker app is using networking a lot then this might
> explain it.
> 
> Thanks,
> 
> tglx
yes it uses constantly the network (1GB hub between the nodes)
for high availability.

Thanks for the explaination

Franck
