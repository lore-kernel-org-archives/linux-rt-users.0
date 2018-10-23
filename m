Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36520 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJWKR6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Oct 2018 06:17:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id l6-v6so1169461pgp.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2018 18:56:51 -0700 (PDT)
Date: Tue, 23 Oct 2018 10:56:45 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: Kernel v4.14.52-rt34 triggered a kernel-oops
Message-ID: <20181023015645.GA748@jagdpanzerIV>
References: <1540215012.26412.7.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1540215012.26412.7.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On (10/22/18 13:30), Roosen Henri wrote:
> Hi RT-experts,
> 
> One of our ARM iMX6Q systems running an SMP PREEMPT RT kernel version
> based on v4.14.52-rt34 triggered a kernel-oops after about 60 days
> duration test (running cyclic-test and additional load apps).
> 
> Looking at the trace (see https://paste.debian.net/1048486/), PC is
> incorrect. LR is c016816c, so the processor just executed the
> instruction at c0168168:
> 
> c0168168:       e12fff33        blx     r3
> (kernel/printk/printk.c:1666)
> 
> With r3 being ee4fe01c, the processor has jumped to that location
> causing the OOPS.
> 
> Looking at the console_unlock disassembly (see
> https://paste.debian.net/1048485/), r3 should have the con->write()
> function pointer. The console pointer con is retrieved while walking
> the console_drivers list.
> 
> So, I guess the list gets corrupted, maybe some kind of concurrency
> issue? Unfortunately there are a lot of locking primitives used in the
> console_unlock() function and some RT-specific code, so it's not so
> easy to find the root-cause at first glance. Could someone of you have
> a look?

Did you register/unregister consoles during the test? Nothing else
should modify the console drivers list.

	-ss
