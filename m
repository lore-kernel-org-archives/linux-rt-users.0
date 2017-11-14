From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Cyclic task issue with 4.9.47-rt37
Date: Tue, 14 Nov 2017 16:07:15 -0600
Message-ID: <96d1c4f2-e083-42d8-f373-16a7edeb25bd@mvista.com>
References: <CAETxm6yGd1nM5SxJXTCGD8ANB=hB_nzWc0CyiOk5xensOBj6qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To: Tommaso Saudelli <tsaudelli@gmail.com>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:50949 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756292AbdKNWHR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Nov 2017 17:07:17 -0500
Received: by mail-ot0-f182.google.com with SMTP id g104so5922243otg.7
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2017 14:07:17 -0800 (PST)
In-Reply-To: <CAETxm6yGd1nM5SxJXTCGD8ANB=hB_nzWc0CyiOk5xensOBj6qw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/14/2017 03:49 PM, Tommaso Saudelli wrote:
> Hi,
> I'm writing since i am experiencing some difficulties through the
> development of an application which execute a cyclic task every 1 ms.
> The computer where this application should run is an embedded pc with
> an intel celeron j1900 quad core, 2G of ram and 32G of ssd. I have
> installed debian 9.2.1 on it, from a netinst iso image, with no
> graphical environment. I've downloaded the latest stable kernel source
> (4.9.47) with the respective rt patch (4.9.47-rt37) and followed the
> instructions as described in the web page "how to set up preempt_rt
> properly".
> I patched the kernel and then i ticked the box with the "Fully
> Preemptible Kernel" option, and compiled it (make, make
> modules_install, make install). Rebooted the pc, i checked that the
> new kernel was running (uname -a) and i wrote a small cpp application
> following the example of "how to build a simple rt application" web
> page and "how to build a basic cyclic application" web page.

Referencing web pages with names really isn't very helpful.  These might
be the right sites, and they might not be.

>   Then to
> be sure that the cycle keeps at a constant rate of 1 ms, i took the
> time in nano seconds (clock_gettime) each time the thread finished
> sleeping and woke up, and compared it with the previous woke up time
> by subtraction. In theory i should get this time to be around 1000000
> ns, but what i get is that it varies continuosly from 800000 to
> 1100000. Sometimes when i launch the program it stays around the
> desired cycle time, but if i stop and restart the program then it
> starts to behave as before. I am really confused, what am i doing
> wrong or am i missing to do? Any suggestion is appreciated. Thanks in
> advance.

Without seeing your program, it is hard to say.  It could be a lot of 
things.

-corey

> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


