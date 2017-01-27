From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: Fail to load module wcn36xx
Date: Fri, 27 Jan 2017 16:24:02 -0500
Message-ID: <CAEYdEeQ6SdogbomzdEsxOBeXxgaaEvthbc3DOkj15Lxwrt-s4g@mail.gmail.com>
References: <CAEYdEeT960G82ONFrRSrzzxMajFfGp3tSDqU5NBCGcx00ci4gA@mail.gmail.com>
 <20170127211921.GM5599@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37741 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbdA0Vas (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 16:30:48 -0500
Received: by mail-it0-f53.google.com with SMTP id r185so65472898ita.0
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jan 2017 13:30:47 -0800 (PST)
In-Reply-To: <20170127211921.GM5599@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

So it looks like I found the culprit, which is related to your point.
In my config I had this:

CONFIG_WCN36XX=m

when I needed to have this:

CONFIG_WCN36XX=y

I thought the dependency that would have triggered the 'm' state of
the config item existed, but evidently not.  So indeed I was not
building the module when I thought I was.

Thank you again, Julia!

On Fri, Jan 27, 2017 at 4:19 PM, Julia Cartwright <julia@ni.com> wrote:
> On Fri, Jan 27, 2017 at 03:54:59PM -0500, Brian Wrenn wrote:
>> Hi,
>
> Hello again.
>
>> I'm trying to get the WLAN wcn36xx driver to load on PRREMPT RT.
>>
>> By some fluke I had this module load successfully in the PREEMPT RT
>> kernel at one point in time, but I have not been able to reproduce
>> getting to to load since my first trial build.
>>
>> I'm patching Linaro 4.4.9 with PREEMPT RT patch 4.4.9-rt17.  I've also
>> manually applied a patch for
>> kernel/drivers/pinctrl/qcom/pinctrl-msm.c, which replaces uses of
>> spinlock calls with raw_spinlock calls.
>>
>> Here's the dmesg output, which indicates unknown symbols as the
>> problem.  However, I'm not sure why this module can't load those
>> symbols.
>>
>> I can successfully load them if I just build plain Linaro 4.4.9,
>> without PREEMPT RT.
>>
>> [   14.023055] wcn36xx: Unknown symbol mutex_lock (err 0)
>> [   14.023105] wcn36xx: Unknown symbol __mutex_init (err 0)
>> [   14.027153] wcn36xx: Unknown symbol mutex_unlock (err 0)
>> [   14.027208] wcn36xx: Unknown symbol _raw_spin_unlock (err 0)
>> [   16.961824] wcn36xx: Unknown symbol mutex_lock (err 0)
>> [   16.961889] wcn36xx: Unknown symbol __mutex_init (err 0)
>> [   16.965955] wcn36xx: Unknown symbol mutex_unlock (err 0)
>> [   16.971391] wcn36xx: Unknown symbol _raw_spin_unlock (err 0)
>
> This just seems to indicate that you haven't rebuilt this module for the
> RT kernel.  These symbols don't exist w/ RT, because they're switched up
> through macros/inlines to make use of the rt_mutex type.
>
> You'll need to ensure you're building the module for the target kernel.
>
>    Julia
