From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: IBM test question
Date: Tue, 12 Feb 2008 11:57:48 +0100
Message-ID: <47B17BAC.2000105@parrot.com>
References: <47AB0C53.3050703@parrot.com> <20080207163440.174181f2@frecb000686.frec.bull.fr> <47AB3189.7080505@parrot.com> <20080208100603.0d825e1d@frecb000686.frec.bull.fr> <Pine.LNX.4.64.0802121108010.11973@frodo.shire>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
	linux-rt-users@vger.kernel.org
To: Esben Nielsen <nielsen.esben@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:52853 "EHLO
	toronto.xi-lite.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752651AbYBLK6t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2008 05:58:49 -0500
In-Reply-To: <Pine.LNX.4.64.0802121108010.11973@frodo.shire>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Esben Nielsen wrote:
> 
>>>> for userland atomic operations (aside from swapping).
>>> I can, if I use a kernel helper :) [1]
>>
>>  Yep, but much slower.
>>
> 
> I worked with an ARMv4 at my former job and wanted to run Linux on it. I 
> thus gave this problem a thought. I got the following idea:
> Make a user space preemt-disable counter just like the in-kernel one. 
> This can be done by registering a address in userspace per thread 
> pointing where to find the counter. When the kernel wants to schedule it 
> checks if the counter is non-zero. If it is (the very rare case), it 
> doesn't reschedule but sets up a timer of some configurable time (say 1 
> ms or
> whatever you need). If the counter is not back to 0 after the timer has 
> expired we schedule anyway and signals the thread to let it know that an
> atomic operation have failed. Notice, that this can only happen due to an
> error in the program: You must always be able finish your atomic 
> operations in 1 ms.
> 
> (There are a lot of details to this, ofcourse.  Forinstance. in the case 
> the kernel wanted to schedule and sets up he timer, the user space 
> program needs to know it so it can disable the timer reschedule as soon 
> as the counter reaches 0. And there is the problem of not swapping out 
> the page where the counter is stored....)
> 

The kernel helper is not slow for armv5. There no userspace->kernel 
switch with some magic. That's just 15 instructions instead of one.
The kernel helper is at a special address. When a context switch occurs, 
  the kernel check if it wasn't in the helper and finish the atomic 
operation or set a flag.


Matthieu
