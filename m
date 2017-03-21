From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.1.38-rt46 build: 1 failures 46 warnings (v4.1.38-rt46)
Date: Tue, 21 Mar 2017 21:40:29 +0100
Message-ID: <CAK8P3a066bfxM+B0DYyvKzMRfzTgFpS-WihH4YSYwODTLrz5SA@mail.gmail.com>
References: <E1cmQcG-0002cE-Cd@optimist> <CAK8P3a37VfnxHPxNs7A=3s-cOzZsZSK93f_wk-WaJpnCqk-6Bw@mail.gmail.com>
 <20170321201000.GE10423@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Build bot for Mark Brown <broonie@kernel.org>,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>
To: Julia Cartwright <julia@ni.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170321201000.GE10423@jcartwri.amer.corp.natinst.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Mar 21, 2017 at 9:10 PM, Julia Cartwright <julia@ni.com> wrote:

> I'm also happy to hear that the 4.1-rt is getting build testing by the
> build bot.  Is there any way I can be CC'd on build reports on this
> branch?  Or, is the best way for me just to subscribe to the list?

The build results for this tree get sent to these three lists:

kernel-build-reports@lists.linaro.org,
linaro-kernel@lists.linaro.org,
linux-rt-users@vger.kernel.org

They should all be open for subscription.

>> >         ../include/linux/spinlock.h:256:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>
>> I could not immediately find this one.
>
> I'm not sure if full logs are available somewhere, but the line above
> this is probably of more interest.  For example:
>
>         drivers/tty/serial/amba-pl011.c: In function 'pl011_console_write':
>         include/linux/spinlock.h:256:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>
> Which looks like perhaps gcc is confused about the conditional
> locking/unlocking in this function.

Mark might have a way of providing more verbose build logs, I don't
think he has a web interface though. kernelci.org and
http://arm-soc.lixom.net/buildlogs/ have some more logs, but don't
build this tree.

It might be the exact warning you cite, I think I bisected this one in the past
to an -rt specific commit and provided a patch, but it wasn't clear whether
this was the best solution.

      Arnd
