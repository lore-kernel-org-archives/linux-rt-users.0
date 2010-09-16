From: Armin Steinhoff <armin@steinhoff.de>
Subject: Re: TinxCore and PREEMPT_RT
Date: Thu, 16 Sep 2010 13:51:36 +0200
Message-ID: <4C9204C8.4080001@steinhoff.de>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com>	<AANLkTi=v_vgk=QwCZPDZWVp+z57_jaPc5=CCnA0Wfmr_@mail.gmail.com>	<201009151059.23039.klaas.van.gend@mvista.com>	<4C90A814.8020605@steinhoff.de> <4C91E59E.5010203@steinhoff.de> <8762y6dmat.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: David Kastrup <dak@gnu.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56258 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab0IPLt3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 07:49:29 -0400
In-Reply-To: <8762y6dmat.fsf@lola.goethe.zz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  David Kastrup wrote:
> Armin Steinhoff<armin@steinhoff.de>  writes:
>
>> Hi all,
>>
>> yes, it's running !
>>
>> TinyCore is very small (10MB) , works with the PREEMPT_RT patch (at
>> least version 2.6.29.6), full SMP support and boots in few seconds!
>> The MicroCore version needs only 6MB ...
> Anybody else nostalgic about the times where it took around 10kB to host
> a realtime multi-tasking operating system including self-hosting target
> compiler?
>
> And the challenge was to fit bootstrap loader and operating system on
> one track of the floppy disk?
>
> Heck, the first UNIXes I used regularly were quite workable with 4MB of
> main memory.

   I developed years ago a control system for an automatic store system 
based on Xenix 1.x and Informix for a 512kB machine.
   So 4MB seems to be very huge :)

  --Armin

   PS: TinyCore is an issue for the guys addicted to the embedded 
real-time stuff ... based on the 2.6 kernel !

