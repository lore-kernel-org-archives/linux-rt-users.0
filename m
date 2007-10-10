From: "Morten Mossige" <morten.mossige@gmail.com>
Subject: Re: Porting intLock()
Date: Wed, 10 Oct 2007 16:00:41 +0200
Message-ID: <feilud$lnt$1@sea.gmane.org>
References: <loom.20071004T185733-342@post.gmane.org> <Pine.LNX.4.64.0710100914180.8140@frodo.shire>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46607 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbXJJOHG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2007 10:07:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IfcAt-0007M2-Je
	for linux-rt-users@vger.kernel.org; Wed, 10 Oct 2007 14:04:35 +0000
Received: from 36.81-167-157.customer.lyse.net ([81.167.157.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Oct 2007 14:04:35 +0000
Received: from morten.mossige by 36.81-167-157.customer.lyse.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Oct 2007 14:04:35 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


"Esben Nielsen" <nielsen.esben@googlemail.com> skrev i melding 
news:Pine.LNX.4.64.0710100914180.8140@frodo.shire...
> On Thu, 4 Oct 2007, Morten Mossige wrote:
>
>> Hi
>> I'm porting an application from another realtime-os to Linux. This
>> application makes use of intLock() from time to time. I still need the 
>> the
>> application to be compilable on both Linux and my old os, so I  need a
>> portabel intLock()
>> I have tried the following approach:
>> When a thread needs to do intLock, I boost the thread-pri to max, and 
>> when
>> the thread does intUnLock() I set the thread-pri back. This woorks quite 
>> ok,
>
> but only on UP machines. On SMP machines you get into trouble.
>
>> but by using this approach, I will also lock other threads in other
>> applications running on Linux.
>
> That is a side effect of intLock(), too.
> But intLock/intUnlock are relatively cheap operations. 
> pthread_setschedprio() is expensive because it involves a system call.
>
>> What I really need is a way of blocking all other threads in my 
>> application,
>> without affecting other applications.
>
> Are you sure you need to prevent all other threads from preempting the 
> current one? Isn't it just a cheap way of implementing a mutex?
>
>> I know I can use mutex'es and semaphores, but that will require a major
>> rewriting of the application, and that is somthing I dont want to do.
>> Can someone come up with an idea how this is done best?
>
> The code paths sharing the data you need to protect via intLock should 
> also have intLock/intUnlock around them or being interrupthandlers in the 
> original application. What about having a global "interrupt_mutex" and 
> make two functions
>
> int intLock()
> {
>   pthread_mutex_lock(&interrupt_mutex);
>   return 0;
> }
>
> void intUnlock(int level)
> {
>   pthread_mutex_unlock(&interrupt_mutex);
>   return 0;
> }
>
> and put in extra intLock/intUnlock around the original interrupthandlers.
>
> Esben
>
>
>> Morten
>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

Tnx for many good recommendations about porting intLock/unLock.
Currently I'm using priboost, and that works for my application, but I will 
look into implementing the lock with a mutex later.

Morten 
