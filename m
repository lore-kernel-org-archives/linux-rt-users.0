From: Austin Hendrix <ahendrix@willowgarage.com>
Subject: Re: kfree causing high latency on 3.4.4-rt13
Date: Mon, 4 Feb 2013 13:54:32 -0800
Message-ID: <CAOY97VZ-98xy-MaS5YuwUh9e00r8=eHQ1ZbG5yfp3xnHJjnSew@mail.gmail.com>
References: <CAOY97VYWzxz-=HNYamCdqOzjXPsAyKjETZ3Hv7V3K4CZ6YB1kQ@mail.gmail.com>
	<alpine.LFD.2.02.1302041245060.11905@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:45399 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab3BDVyd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 16:54:33 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so6958095obb.9
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Feb 2013 13:54:32 -0800 (PST)
In-Reply-To: <alpine.LFD.2.02.1302041245060.11905@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

An example of what I'm seeing from latencytop is:
[kfree]                                           7937.6 msec          6.4 %

I poked around the kernel source a bit and was pretty stumped by this,
so I'm glad it's not just me.

Thanks,
-Austin

On Mon, Feb 4, 2013 at 3:49 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 29 Jan 2013, Austin Hendrix wrote:
>> I'm running 3.4.4-rt13 on my systems, and while the realtime
>> performance is great, I occasionally see non-realtime processes block
>> for several seconds. Running latencytop, it looks like the kfree
>> kernel process is the worst offender. Does anyone have advice on how I
>
> There is no kfree process. kfree() is a function to release memory
> allocated by kmalloc.
>
> Can you provide the latencytop output please ?
>
> Thanks,
>
>         tglx
