From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Fri, 11 May 2012 13:56:22 +0000 (UTC)
Message-ID: <joj5q6$e3h$1@dough.gmane.org>
References: <joemui$6v0$1@dough.gmane.org> <joepd0$e4f$1@dough.gmane.org>
 <4FAAEBF3.10907@netacquire.com> <joetve$hm5$1@dough.gmane.org>
 <CANqCtQJsr6xV9aU5LbXuOOtYTvcHT6113cy0+6smKBtZAdcRGA@mail.gmail.com>
 <20120510135320.GA9568@grante>
 <CANqCtQ+HbGMUqJuZN-weX1CbK9ecTgfdenV4WgZiDQQ_ZAYSUA@mail.gmail.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41978 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab2EKN4i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 May 2012 09:56:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1SSqKh-0007Y7-D9
	for linux-rt-users@vger.kernel.org; Fri, 11 May 2012 15:56:35 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 11 May 2012 15:56:35 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 11 May 2012 15:56:35 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2012-05-11, Remy Bohmer <linux@bohmer.net> wrote:
> Hi,
>
> 2012/5/10 Grant Edwards <grant.b.edwards@gmail.com>:
>>> If the 20usec requirement is hard, you can also look at using an FIQ.
>>
>> Does the normal AT91 kernel not use FIQs at all? ?If so, I might be
>> able to dedicate the FIQ to this function and have it happen without
>> the Linux kernel knowing about it (or affecting it). ?Any
>> communication between it and a normal user-task would have to be
>> handled carefully...
>
> No, the kernel does not use the FIQ at all. It is free for you to use
> as you want. Communication with the FIQ handler can be done using a
> queue based on atomic instructions.

Thanks!  I was about to start looking into that...

-- 
Grant Edwards               grant.b.edwards        Yow! I just forgot my whole
                                  at               philosophy of life!!!
                              gmail.com            

