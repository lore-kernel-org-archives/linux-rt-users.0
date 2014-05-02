From: Mau Z <zmau1962@gmail.com>
Subject: Re: Can PAX and Rt-patch co-exist ?
Date: Fri, 2 May 2014 10:40:16 +0300
Message-ID: <CAPFcPTJLcZ3RJ0VsUvEJbtx1tj4_y6P31YhRiTW+OnsfUHT_9Q@mail.gmail.com>
References: <CAPFcPTL10dY0NjYUrQ-q_W81RRFReiA0jTeseC8tC8_FZViWkQ@mail.gmail.com>
	<53618D0A.2050609@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Corey Minyard <cminyard@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:61072 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbaEBHkR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 03:40:17 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi5so976008wib.1
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 00:40:16 -0700 (PDT)
In-Reply-To: <53618D0A.2050609@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks

The answer is very surprising.
I would assume that more than one person would have such an experience.


I am curious regarding the magnitude of work to be done. I am
especially intersted what happens when you have to handle another
Linux version for your distribution.

Is this job done just once (for one specific Linux version) ?
 or
You do the job once, and then do the same fixes on the other Linux
version (more or less) ?
 or
You have to do the same job all over again in every linux version ?


Is the following discription correct ?
Basically the job is
1) Download kernel
2) apply RT-patch
3) apply PAX patch
4) compile and fix warnings and errors


Thanks
again
zmau


On Thu, May 1, 2014 at 2:53 AM, Corey Minyard <cminyard@mvista.com> wrote:
> On 04/30/2014 05:47 PM, Mau Z wrote:
>> I have some more questions concerning the relation between PAX and the
>> RT-Patch :
>> A) Can they work together ?
>
> It can be made to work.  We have it working together in our distribution.
>
>> B) Do you know if it matters which patch is applied first ?
>
> Not really.
>
>> C) Is there any documentation about this subject ?
>
> None that I know of.  I imagine that I'm the only person who has ever
> done this.
>
> There are some conflicts (a few are non-trivial, but not excessively
> complicated, IIRC).  But it's not something insurmountable.  You do have
> to have a fairly good understanding of kernel code.
>
> -corey
>
>>
>>
>> Thanks
>> zmau
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
