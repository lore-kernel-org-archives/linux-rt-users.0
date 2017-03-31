From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Fwd: changes to scheduler from mainline 4.8 to 4.10?
Date: Fri, 31 Mar 2017 13:30:48 +0200
Message-ID: <20170331113048.pvsersxc67yxqzwo@linutronix.de>
References: <CALd3UbSKV_Qzun=9Hhwe=omP5f4A3gyOi_nGNM6JA4d5ziFZ_g@mail.gmail.com>
 <CALd3UbQo=F6YtQ-LUrw0YaX2=PdpyXh+EFueKYn4MnRtUE748Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Bert Schiettecatte <bert@bertschiettecatte.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdCaLau (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 Mar 2017 07:30:50 -0400
Content-Disposition: inline
In-Reply-To: <CALd3UbQo=F6YtQ-LUrw0YaX2=PdpyXh+EFueKYn4MnRtUE748Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-03-29 08:55:33 [-0700], Bert Schiettecatte wrote:
> Hi all,
Hi,

> I have been using 44100 hz sample rate and 960 samples buffer size for
> testing. I increased the buffer size to 1280 which seemed to improve
> things a little, and then after googling around I changed the IO
> scheduler to noop (it was set to CFQ), which further increases the
> performance. I now only have occasional audio dropouts.

So v4.8 with CFG was working well but v4.10 does not?

> The application does a lot of I/O via HID and has 4 audio processing
> threads for signal processing, besides other threads and callbacks for
> HID I/O.
> 
> Questions:
> 
> 1) Does anyone know if something has changed between kernel 4.8 and
> 4.10 with regard to the scheduler that might negatively impact
> realtime audio or RT performance in general?
It should not. If you have a test case to fully reproduce the issue then
you could v4.9 and maybe bisect it further to check which change is
responsible for it.

> 2) are there specific kernel settings I should check?
not really. You should keep that debug stuff off and then if you take
your v4.8 .config and put through "make oldconfig" then you should only
see "new" options which are off/N by default.

> 3) I am wondering if RT patches are still relevant for newer kernels
> like 4.8 and 4.10?
We have plenty of them
	https://cdn.kernel.org/pub/linux/kernel/projects/rt/

but not all major versions you see there are currently supported
	https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

Not everything the RT patch provides is mainline.

> 4) I saw that the latest patches are for kernel 4.4, can they be
> applied to later kernels and is that a good idea or not?
They won't apply cleanly. I suggest you pick one tree with patches
provided if you want to try the RT patch.

> Thanks for helping!
> 
> Bert

Sebastian
