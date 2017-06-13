From: Niels Kolthoff <nkolthoff@gmail.com>
Subject: Fwd: RT and tty communication
Date: Tue, 13 Jun 2017 15:15:50 +0200
Message-ID: <CAD2hpBVq33RB5SsQ6FCoTyUZoBoTdv=Kt7drfhhdL3f6vLe4EQ@mail.gmail.com>
References: <CAD2hpBW1YNbS+C1osQ0zMF=f_w+fpmpZvsv=x6u-1BQrSvz3Dw@mail.gmail.com>
 <20170613122919.5qn2tojop67ye7wv@linutronix.de> <CAD2hpBWoe=dBoFOg9D0a2PJ0nWdUEX2ropJiE9MJkvcddgbWUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34176 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdFMNPv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Jun 2017 09:15:51 -0400
Received: by mail-yb0-f194.google.com with SMTP id o185so5953578yba.1
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jun 2017 06:15:51 -0700 (PDT)
In-Reply-To: <CAD2hpBWoe=dBoFOg9D0a2PJ0nWdUEX2ropJiE9MJkvcddgbWUA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jun 13, 2017 at 2:29 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-06-12 15:48:49 [+0200], Niels Kolthoff wrote:
>> Hi,
>>
>> I'm currently testing a RT application that communicates with sensor
>> hardware using a tty serial port. The application polls the tty port
>> (non-blocking) in a user space thread (priority 80) for incoming data.
>> On a raspberry PI3 (ttyAMA0), with kernel 4.4.9-rt17, response times <
>> 650usec are achieved, which is fine.
>>
>> Any version equal or above 4.4.12-rt20 will increase response peaks to
>> (about 0.1%) > 2msec, with some peaks > 5msec.
>>
>> cyclictest doesn't reproduce this, so I suspected a change in the tty
>> driver, or related to raspberry pi.
>>
>> I found that, by reverting the attached patch, response times return
>> to < 650usec. I suspect it has something to do with a change in the
>> read poll.
>>
>> I'd like to help solving this issue, can anyone give me some pointers
>> on how to continue?
>
> My guess is that the newly introduced tty_buffer_flush_work() waits
> until all in-kernel data is processed before returning -EAGAIN (if the
> buffer is empty) for the non-blocking case which unbreaks ssh. So this
> wait could blocking you for longer than required.
> If that is really it, then this is what could be optimized :)
>
Ok, thanks, that's valuable input. I'll investigate this and keep u posted.

>> Regards,
>> Niels Kolthoff
>
> Sebastian
