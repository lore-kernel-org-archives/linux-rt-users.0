From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: Fail to load module wcn36xx
Date: Fri, 27 Jan 2017 16:43:24 -0500
Message-ID: <CAEYdEeR4KvL3sv5CeALjrwQVdSyCdohpZDLqa0JRHGiayEjCjA@mail.gmail.com>
References: <CAEYdEeT960G82ONFrRSrzzxMajFfGp3tSDqU5NBCGcx00ci4gA@mail.gmail.com>
 <20170127211921.GM5599@jcartwri.amer.corp.natinst.com> <CAEYdEeQ6SdogbomzdEsxOBeXxgaaEvthbc3DOkj15Lxwrt-s4g@mail.gmail.com>
 <20170127213029.GN5599@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34101 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdA0Vnx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 16:43:53 -0500
Received: by mail-io0-f179.google.com with SMTP id l66so70817671ioi.1
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Jan 2017 13:43:25 -0800 (PST)
In-Reply-To: <20170127213029.GN5599@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 27, 2017 at 4:30 PM, Julia Cartwright <julia@ni.com> wrote:
> Hey Brian-
>
> Please respond inline in the future.
>
> On Fri, Jan 27, 2017 at 04:24:02PM -0500, Brian Wrenn wrote:
>> On Fri, Jan 27, 2017 at 4:19 PM, Julia Cartwright <julia@ni.com> wrote:
>> > On Fri, Jan 27, 2017 at 03:54:59PM -0500, Brian Wrenn wrote:
> [..]
>> >> Here's the dmesg output, which indicates unknown symbols as the
>> >> problem.  However, I'm not sure why this module can't load those
>> >> symbols.
>> >>
>> >> I can successfully load them if I just build plain Linaro 4.4.9,
>> >> without PREEMPT RT.
>> >>
>> >> [   14.023055] wcn36xx: Unknown symbol mutex_lock (err 0)
>> >> [   14.023105] wcn36xx: Unknown symbol __mutex_init (err 0)
>> >> [   14.027153] wcn36xx: Unknown symbol mutex_unlock (err 0)
>> >> [   14.027208] wcn36xx: Unknown symbol _raw_spin_unlock (err 0)
>> >> [   16.961824] wcn36xx: Unknown symbol mutex_lock (err 0)
>> >> [   16.961889] wcn36xx: Unknown symbol __mutex_init (err 0)
>> >> [   16.965955] wcn36xx: Unknown symbol mutex_unlock (err 0)
>> >> [   16.971391] wcn36xx: Unknown symbol _raw_spin_unlock (err 0)
>> >
>> > This just seems to indicate that you haven't rebuilt this module for t=
he
>> > RT kernel.  These symbols don't exist w/ RT, because they're switched =
up
>> > through macros/inlines to make use of the rt_mutex type.
>> >
>> > You'll need to ensure you're building the module for the target kernel=
.
>> >
>>
>> So it looks like I found the culprit, which is related to your point.
>> In my config I had this:
>>
>> CONFIG_WCN36XX=3Dm
>>
>> when I needed to have this:
>>
>> CONFIG_WCN36XX=3Dy
>>
>> I thought the dependency that would have triggered the 'm' state of
>> the config item existed, but evidently not.  So indeed I was not
>> building the module when I thought I was.
>
> I want to ensure you walk away with the right conclusion :).
>
> There is nothing fundamentally wrong with building with
> CONFIG_WCN36XX=3Dm.  This should Just Work(tm).  The problem is when ther=
e
> exists a mismatch between the target kernel you are booting, and the
> module set that was built with that kernel.
>
> It looks like, what you've done is booted a PREEMPT_RT_FULL build of
> Linux, but then tried to load a module which was built against a
> non-PREEMPT_RT_FULL configuration.
>
> Glad I could help,
>    Julia

Yes, it was indeed built against a non-PREEMPT_RT_FULL config
initially.  I just thought I had forced it to recompile when I did a
make clean before make, which maybe I did wrongly.

After I toggled the flag from 'm' to 'y', I noticed something got
built even without a clean build.  In particular...

  CC      drivers/net/wireless/ath/wcn36xx/main.o
  CC      drivers/net/wireless/ath/wcn36xx/dxe.o
  CC      drivers/net/wireless/ath/wcn36xx/txrx.o
  CC      drivers/net/wireless/ath/wcn36xx/smd.o
In file included from drivers/net/wireless/ath/wcn36xx/dxe.c:26:0:
include/linux/soc/qcom/smem_state.h:15:92: warning: =E2=80=98struct
device_node=E2=80=99 declared inside parameter list [enabled by default]
 struct qcom_smem_state *qcom_smem_state_register(struct device_node
*of_node, const struct qcom_smem_state_ops *ops, void *data);

                     ^
include/linux/soc/qcom/smem_state.h:15:92: warning: its scope is only
this definition or declaration, which is probably not what you want
[enabled by default]
  CC      drivers/net/wireless/ath/wcn36xx/pmc.o
  CC      drivers/net/wireless/ath/wcn36xx/debug.o

So toggling that flag must have indicated to the make file that it
must rebuild the module in some way.

Thanks again, and have a great weekend.
