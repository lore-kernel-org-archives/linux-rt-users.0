From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: EDF - "earliest deadline first" scheduler
Date: Mon, 3 Apr 2017 15:53:27 +0300
Message-ID: <CAJ2oMhJ-QgYCttetEF49nDge2UkheudG1MXJemerPm0P7zvUhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Alison Chaiken <alison@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35150 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbdDCMx3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Apr 2017 08:53:29 -0400
Received: by mail-lf0-f44.google.com with SMTP id j90so72721483lfk.2
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Apr 2017 05:53:28 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Apr 3, 2017 at 8:06 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> On Mon, Apr 3, 2017 at 5:38 AM, Alison Chaiken <alison@peloton-tech.com> =
wrote:
>>  Ran Shalit <ranshalit@gmail.com> wrote:
>>> I have found in
>>> https://wiki.linuxfoundation.org/realtime/documentation/howto/applicati=
ons/cyclic
>>> that there is EDF scheduler option for creating a periodic RT thread.
>>> Yet, I could not understand what's behind the EDF scheduler
>>
>>
>> Have a look at "Using SCHED_DEADLINE" at
>>
>> http://elinux.org/ELC_Europe_2016_Presentations
>>
>> Also, look for papers on this topic by Juri Lelli.
>>
>> HTH,
>> Alison
>
> Hi Alison,
>
> Thank you very much.
> I reviewed the material, which is very interesting, but I am not yet
> sure which timer are used internally in SCHED_DEADLINE.
> Is it posix or non-posix ?
>
> Thanks,
> Ran

I am trying to understand which scheduler is better used with RT.
In the wiki there is an example for SCHED_FIFO, periodic time.
But in sched_deadline wiki ( https://wiki.automotivelinux.org/sched_deadlin=
e )
it is said as following:
"
 Using SCHED_FIFO/SCHED_RR, instead, we can give that kind of
guarantee only using a global period, with the constraint that =E2=80=9Ca
subgroup must have a smaller or equal period to its parent=E2=80=9D.
The latency experienced by a task (i.e., the time between two
consecutive executions of a task) is not deterministic and cannot be
bound, since it highly depends on the number of tasks running in the
system at that time. Using EDF, instead, this time is deterministic,
bounded and known at any instant of time."

I am not sure now. Does it mean that using more than one SCHED_FIFO
periodic thread is not deterministic compared with SCHED_DEADLINE?

Regards,
Ran
