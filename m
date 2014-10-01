From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Wed, 01 Oct 2014 09:27:45 +0200
Message-ID: <542BACF1.3090405@steinhoff.de>
References: <542A88A8.7060800@steinhoff.de> <alpine.DEB.2.11.1410010058160.4455@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64496 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaJAH1v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Oct 2014 03:27:51 -0400
In-Reply-To: <alpine.DEB.2.11.1410010058160.4455@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner schrieb:
> On Tue, 30 Sep 2014, Armin Steinhoff wrote:
>> a "pthread_setschedparam" call of the code below terminates with an
>> errno == 1  ... means "Operation not permitted"
> ...
>> I'm using a PREEMPT_RT kernel 3.4.0-rc7-rt7-2.16  for SuSE 12.2
>> Milestone 2 (3.4.11-2.16).
>>
>> How to solve that problem ?
> Hint #1: 3.4.0-rc7-rt7-2.16 
I'm using the vanilla kernel "linux-3.4-rc7.tar.gz" and the related(?)
RT patch "patch-3.4-rt7.patch.xz" from "kernel.org"
The suffix -2.16 seems to be a naming convention from SuSE ?

The patch, recompilation and installation was working perfectly. ( Only
the compilation of a 3COM adapter was broken) 
>
> Hint #2: linux/REPORTING-BUGS
OK  ... still TODO 

Regards

--Armin
>
> Hint #3: Start over at Hint #1
>
> Thanks,
>
> 	tglx
>
>


