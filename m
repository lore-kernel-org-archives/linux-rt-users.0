From: Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: Random 3 to 4.5 second blocks of RT thread
Date: Mon, 11 Feb 2013 12:08:45 -0500
Message-ID: <CADkTA4MNMCm-6T7rN+9-kujpO4hUmXJmR7hTOkVy2y4xGWX5BQ@mail.gmail.com>
References: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Realtime Mailinglist <linux-rt-users@vger.kernel.org>,
	Thomas Weisser <thomas@bj-ig.de>
To: =?ISO-8859-1?Q?Ralf_M=FCller?= <ralf@bj-ig.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:37639 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099Ab3BKRIr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Feb 2013 12:08:47 -0500
Received: by mail-la0-f52.google.com with SMTP id fs12so5906479lab.25
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Feb 2013 09:08:46 -0800 (PST)
In-Reply-To: <8426D3F6-9553-4B6A-B318-4983625ACC8E@bj-ig.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Feb 11, 2013 at 10:54 AM, Ralf M=FCller <ralf@bj-ig.de> wrote:
> Hi.
>
> I've got a problem with a box at a customer, where about once a day (=
overall 20 events in 16 days) a realtime thread blocks for 3 to 4.5 sec=
onds. This threads only job is to define a kind of time normal for othe=
r subsystems. It basically is a loop that wakes up every milli second, =
increments a generation counter, does some statistics and goes to sleep=
 for another millisecond. It does this quite well - except for these ra=
ndom multi second sleeps.
>
> My problem: this only happens on a customer machine (actually two dif=
ferent machines at different places, both with very limited access). I =
tried to reproduce the bug on two test systems here, which are configur=
ed as close to the customer system as possible for me (bios settings, k=
ernel configuration, ... about the same load situation) but I was not a=
ble to get such a block for more then 3 month (I get jitters of less th=
en 30 micro seconds what is quite ok for the use case).
>
> The thread is configured to run with SCHED_RR priority 99 via pthread=
_setschedparam(). There are no other user threads in the system with su=
ch a high priority. There is no swap file, memory is locked via mlockal=
l. There are two 24/7 disks configured to never got to suspend, running=
 a md-RAID 1. The thread itself does not do anything time consuming, it=
 does not do anything that can block. All these systems run on an old O=
penSUSE 11.2 with kernel 2.6.33.2-jen97-rt. A maybe relevant kernel opt=
ion set, is "processor.max_cstate=3D0". I know it's not just a time war=
p on the system, it actually blocks that long because a connected syste=
m reports a communication error.
>
> My next try would be to change the board of a customer system by one =
of the boards of the test systems and hope the error moves to me. As th=
is is a bit expensive and I'm not sure it will really help I would like=
 to ask if someone here can give any hint how to debug such a problem o=
r has any idea what in a system blocks for 3 to 4.5 seconds and how I c=
an avoid such blocks.
>
> I know the problem is related to old software and the description is =
at least a bit vague. My real hope is that someone says: "yes, exactly =
the same problem I had the day before and I solved it by setting this o=
r that option". Hope dies last.

resending since gmail decide to mix html into my original message.

Since you mentioned BIOS, I assume that you are running on a x86 platfo=
rm.
I noted that you didn't mention if SMIs have been ruled out as a cause =
of the
latency issues. You've probably already ruled this out, but I figured I=
'd ask
anyway :)

Cheers,

Bruce

>
> Best regards and thanks in advance
> Ralf M=FCller--
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
