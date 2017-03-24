From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: v4.1.38-rt46 build: 1 failures 46 warnings (v4.1.38-rt46)
Date: Fri, 24 Mar 2017 19:59:40 +0100
Message-ID: <CAK8P3a2a6yNEKxTUA1kqYg-nTU_5=Kz1FcmjJ1Qf=2hJkTOW8Q@mail.gmail.com>
References: <E1cmQcG-0002cE-Cd@optimist> <CAK8P3a37VfnxHPxNs7A=3s-cOzZsZSK93f_wk-WaJpnCqk-6Bw@mail.gmail.com>
 <20170321201000.GE10423@jcartwri.amer.corp.natinst.com> <CAK8P3a066bfxM+B0DYyvKzMRfzTgFpS-WihH4YSYwODTLrz5SA@mail.gmail.com>
 <20170324185655.knt6vdmohkamzs4n@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linaro-kernel@lists.linaro.org, linux-rt-users@vger.kernel.org,
        kernel-build-reports@lists.linaro.org,
        Julia Cartwright <julia@ni.com>, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@verizon.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170324185655.knt6vdmohkamzs4n@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Mar 24, 2017 at 7:56 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 21, 2017 at 09:40:29PM +0100, Arnd Bergmann wrote:
>> On Tue, Mar 21, 2017 at 9:10 PM, Julia Cartwright <julia@ni.com> wrote:
>
>> >         drivers/tty/serial/amba-pl011.c: In function 'pl011_console_write':
>> >         include/linux/spinlock.h:256:3: warning: 'flags' may be used uninitialized in this function [-Wmaybe-uninitialized]
>
>> > Which looks like perhaps gcc is confused about the conditional
>> > locking/unlocking in this function.
>
>> Mark might have a way of providing more verbose build logs, I don't
>> think he has a web interface though. kernelci.org and
>> http://arm-soc.lixom.net/buildlogs/ have some more logs, but don't
>> build this tree.
>
> I do have https://builds.sirena.org.uk/ but it's just a dump of files.
>

I get "access denied" on that.

        Arnd
