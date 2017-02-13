From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Mon, 13 Feb 2017 22:32:33 +0200
Message-ID: <CAJ2oMhJmkUxiuohwYLDfg-GBFKOfrcuOgUGOGAbo09m--6bpvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "Patel, Vedang" <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35020 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbdBMUcf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2017 15:32:35 -0500
Received: by mail-wr0-f175.google.com with SMTP id c4so609430wrd.2
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2017 12:32:35 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 13, 2017 at 8:48 PM, Patel, Vedang <vedang.patel@intel.com> wrote:
> On Fri, 2017-02-10 at 20:07 +0100, Sebastian Andrzej Siewior wrote:
>> On 2017-02-08 18:41:25 [+0000], Patel, Vedang wrote:
>> >
>> > Hi,
>> Hi,
>>
>> >
>> > The results for the POSIX timers were not as I expected. The
>> > latency
>> > for real-time kernel (v4.9.4-rt2) was worse compared to the
>> > mainline
>> > kernel (v4.9.4). In almost all the cases, the latency is almost
>> > doubled
>> >  with the max value reaching about 10 times when performing the
>> > tests
>> > under load.
>> Is it also the case if you boost the priority of ktimersoftd/X
>> threads?
>> For clock_nanosleep, the wake-ups happen directly from hard-timer
>> interrupt. For the posix-timer we have to delay those to the
>> ktimersoftd
>> thread which runs usually RT prio 1.
>>
> I am getting very similar results even if I change the priority of
> ktimersoftd to 99. Are there any recent rt patches which might have
> changed the behaviour of POSIX timers?
>
> Also, are POSIX timers really suited for "real-time" applications?I
> believe a similar question was raised by Ran Shalit a few days back:
> http://www.spinics.net/lists/linux-rt-users/msg16249.html
>

Right.
I did  testing of recent kernels 4.1.15,  with Atom , and the
non-posix timers jitter was obviously better compared to non-posix
(42usec vs 180us),
On trying 4.4.x kernel I seen very strange behavior for both timers
(maybe I applied the patch wrongly or needed to disable some features
in config?) ,

So I decided eventually to use the 4.1.15 with non-posix timers only
with our Atom board. I hope that's a good decision.


> Thanks,
> Vedang
>> >
>> > Thanks,
>> > Vedang Patel
>> > Software Engineer
>> > Intel Corporation
>> Sebastian
