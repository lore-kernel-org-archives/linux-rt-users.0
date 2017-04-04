From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: EDF - "earliest deadline first" scheduler
Date: Tue, 4 Apr 2017 10:30:04 +0300
Message-ID: <CAJ2oMhJEzpw1QJB9HFQ1YPtBwsDaQ3h8jrSgLNke1qecBJg1cQ@mail.gmail.com>
References: <CAJ2oMhJ-QgYCttetEF49nDge2UkheudG1MXJemerPm0P7zvUhA@mail.gmail.com>
 <20170404053817.GD12288@icarus.home.austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Alison Chaiken <alison@peloton-tech.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35786 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbdDDHaH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Apr 2017 03:30:07 -0400
Received: by mail-wr0-f175.google.com with SMTP id k6so196551223wre.2
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Apr 2017 00:30:06 -0700 (PDT)
In-Reply-To: <20170404053817.GD12288@icarus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 4, 2017 at 8:38 AM, Henrik Austad <henrik@austad.us> wrote:
> On Mon, Apr 03, 2017 at 03:53:27PM +0300, Ran Shalit wrote:
>> On Mon, Apr 3, 2017 at 8:06 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>> > On Mon, Apr 3, 2017 at 5:38 AM, Alison Chaiken <alison@peloton-tech.co=
m> wrote:
>> >>  Ran Shalit <ranshalit@gmail.com> wrote:
>> >>> I have found in
>> >>> https://wiki.linuxfoundation.org/realtime/documentation/howto/applic=
ations/cyclic
>> >>> that there is EDF scheduler option for creating a periodic RT thread=
.
>> >>> Yet, I could not understand what's behind the EDF scheduler
>> >>
>> >>
>> >> Have a look at "Using SCHED_DEADLINE" at
>> >>
>> >> http://elinux.org/ELC_Europe_2016_Presentations
>> >>
>> >> Also, look for papers on this topic by Juri Lelli.
>> >>
>> >> HTH,
>> >> Alison
>> >
>> > Hi Alison,
>> >
>> > Thank you very much.
>> > I reviewed the material, which is very interesting, but I am not yet
>> > sure which timer are used internally in SCHED_DEADLINE.
>> > Is it posix or non-posix ?
>> >
>> > Thanks,
>> > Ran
>>
>> I am trying to understand which scheduler is better used with RT.
>> In the wiki there is an example for SCHED_FIFO, periodic time.
>> But in sched_deadline wiki ( https://wiki.automotivelinux.org/sched_dead=
line )
>> it is said as following:
>> "
>>  Using SCHED_FIFO/SCHED_RR, instead, we can give that kind of
>> guarantee only using a global period, with the constraint that =E2=80=9C=
a
>> subgroup must have a smaller or equal period to its parent=E2=80=9D.
>> The latency experienced by a task (i.e., the time between two
>> consecutive executions of a task) is not deterministic and cannot be
>> bound, since it highly depends on the number of tasks running in the
>> system at that time. Using EDF, instead, this time is deterministic,
>> bounded and known at any instant of time."
>>
>> I am not sure now. Does it mean that using more than one SCHED_FIFO
>> periodic thread is not deterministic compared with SCHED_DEADLINE?
>
> It means that when you use priorities, you basically do a one-way mapping
> between the inherit deadlines in your tasks to a set of static priorities=
.
> As a developer you know *when* the tasks needs to complete, right? So the=
n
> the job is to pick a priority and hope that no other higher-prioritized
> thread preempts you and cause you to miss your deadline.
>
> And that is the problem with a complicated system, many tasks lead to an
> intractable problem of getting all the priorities right, causing you no e=
nd
> to the headache.
>
> With SCHED_DEADLINE, you express your requirements directly as deadlines,
> thus avoid that whole one-way mapping and instead the tasks relative
> priority will adjust as the scheduler now has a _much_ more comprehensive
> view of the requirements.
>
> --
> Henrik Austad


Thanks for these comments, Henrik.
I have reviewed  examples of how to use SCHED_DEADLINE, yet I am not sure:
Does it use POSIX or non-POSIX timers ?
I ask because we've seen some issue with POSIX timers in some kernel
version, architectures.

Ran
