Return-Path: <SRS0=2Kn/=BP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16BC433DF
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A457120842
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austral-dynamics-com.20150623.gappssmtp.com header.i=@austral-dynamics-com.20150623.gappssmtp.com header.b="QUmVn8vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgHETwz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgHETwv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Aug 2020 15:52:51 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236CC061575
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Aug 2020 12:52:50 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p13so9987752ilh.4
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Aug 2020 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qK6Ljhz4RdJ3JV3D8OhRjk4lQEa/zu6D8eZvGHeK820=;
        b=QUmVn8vvNhKvpyDgGrhDKg0d57Xx2igR4iEEM8siuRB+9ijWaTQsnrnQ5cTIdBKt1K
         YDRDpBfwiYjWfYiwwH7rKv16wgrLDKlRJAaACiBsKmDRlBN8uLNHTS+rWUkcro2fjqX+
         tl9gcvq6jNw10mZ8soQlIJ1mFYWZDWujL7duwVhQIzc6SZslhMQZS3VpgZdEBseiHSNL
         g8zlUC544CncF48YOtbheHz/QPA8aK3vwcGq8UL4xm8VWcxlTOF9bg9dxLN8M2pmSj2A
         0W9LNMSU6uzLf21IhZBCDJXixBJ8GElTChsWHepaDre1C1DMyBJXXNF8ne2yBZPK3lI7
         ESug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qK6Ljhz4RdJ3JV3D8OhRjk4lQEa/zu6D8eZvGHeK820=;
        b=cLVNlKfxqwAguFzACr3VyaxNd/LsvgRYaeNlhHuJQE3iPCARMlWrV3nHwpkzrvAwH5
         1BHyTr1BUtH6er61bbLLMvzgQw9cQ09O2bAWhsts6+XZtcmpPcLjXTu0c//z0g6E3E0G
         PGnwHkg3MatOl8LPpNZ5LF1ryE6AGGUMkXHIO+hywGDLGMihS7il0kykMFh10YyCWT8w
         FiyH3w6RGpg+ASCFIPWXamSSqOQ5Q0/2wfSnfKeaxT/oC9Y2Phdh+8BoDfD4uvCuQTXV
         WuozFsq5VTJecPj4frr6jU2v7FqHpgtNNMlK8tNvw41FsV6t2VWLPP772KyAsTr0n1FG
         HRUQ==
X-Gm-Message-State: AOAM5315OXMlIZzfdIUk1lqYBsG4ezJhJ/yTRpBuiBDff08K+alGoAP8
        JCcQf0mZw5I+B+duMdxOTkuQn8u+icKu5/DNEXhdlA==
X-Google-Smtp-Source: ABdhPJwjf/ClEEcQwwtkK/bbPJYwfc3jyfuZRh8le+/06x64cgodffrRsyKeRhO5w0fRor/VI360ZF/VeiM+hZwUGTk=
X-Received: by 2002:a92:2c10:: with SMTP id t16mr5508373ile.24.1596657169331;
 Wed, 05 Aug 2020 12:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkbJ-yHNiF2oqf8dx2RiVUPrMRAsxve-M9pS_62GYje7jx8tw@mail.gmail.com>
 <7071403B-CF64-4B4A-80F4-BCE7B593F555@gmail.com>
In-Reply-To: <7071403B-CF64-4B4A-80F4-BCE7B593F555@gmail.com>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Wed, 5 Aug 2020 16:52:39 -0300
Message-ID: <CAKkbJ-wBoJUXzhLxsT4xaOgc3RcG7_U_H=WMKb=y=Ebks2cBcw@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Itai Handler <itai.handler@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Itai,
I get  the end time after the tcdrain function. I found that my
CONFIG_HZ is 250 and know that you said it makes
sense the 4 ms. To be honest I've searched about this and still I
didn't understand this frequency and how it is related to time
functions such as clock_gettime. Is it kind
of frequency "given" to the user to have as a time base? I'm lost in
which context it applies, kernel space, user space or any abstraction
level of the system.
Could you elaborate or give me some good material as a reference?

I searched about the ftrace, and if I understand correctly this and
the CONFIG_HZ option should be enabled during kernel compiling time.

Em qua., 5 de ago. de 2020 =C3=A0s 16:21, Itai Handler
<itai.handler@gmail.com> escreveu:
>
> Hi Michel,
>
> If I understand correctly, you=E2=80=99re measuring the duration of the w=
rite function to a serial port.
> I think that there is no guarantee that this function will return before =
the port finishes to transmit all data.
> However that doesn=E2=80=99t explain why you=E2=80=99re observing longer =
than expected duration.
> The difference in times of 4ms (from 8 to 12) suggests that the scheduler=
 is involved.
> I guess you=E2=80=99re working with CONFIG_HZ_250?
> May I suggest that you use function graph tracing (ftrace) to analyze it?
>
> Itai Handler
>
>
>
> > On 5 Aug 2020, at 21:29, Michel Macena Oliveira <michel@austral-dynamic=
s.com> wrote:
> >
> > =EF=BB=BFHi, Thanks for your answers
> >
> > I've written two simple codes to write a buffer of characters
> > into the serial port. I'm reading the characters on another computer
> > (windows 10, Termite as serial monitor). I did a simple time analysis
> > to know how much time to write a given number of bytes into the port
> > for both codes.
> > In the first code the write function was called in the main function,
> > in the second I put inside a thread function with sched priority 90.
> >
> > I did the time analysis using the clock_gettime function with the
> > CLOCK_REALTIME flag to get time before and after the write call inside
> > a testing loop. Then I got the time measures, calculated the average
> > and stored the maximum value.
> > I got the same results with non-threaded (NT) and threaded (T) code.
> > But I found something weird for both.
> >
> > For 1000 testing loops:
> >
> > buffer size:  1
> > Average Time: NT=3D 8.044138785 ms  T=3D 8.126175254 ms
> > Maximum Time: NT=3D 12.069355000 ms T=3D 12.102010000 ms
> >
> > buffer size:  48
> > Average Time:  NT=3D 8.021624309 ms  T=3D 8.038524315 ms
> > Maximum Time:  NT=3D 12.018302000 ms T=3D 12.054890000 ms
> >
> > buffer size:  49
> > Average Time: NT=3D 12.010010796 ms T=3D 12.044165909 ms
> > Maximum Time: NT=3D 16.019277000 ms T=3D 16.038130000 ms
> >
> > buffer size:  96
> > Average Time: NT=3D 12.057916205 ms T=3D 12.054206314 ms
> > Maximum Time: NT=3D 16.101405000 ms T=3D 16.040888000 ms
> >
> > buffer size:  144
> > Average Time: NT=3D 16.043416532 ms T=3D 16.020754198 ms
> > Maximum Time: NT=3D 20.069923000 ms T=3D 20.059298000 ms
> >
> > buffer size:  145
> > Average Time: NT=3D 20.039547930 ms T=3D 20.048668453 ms
> > Maximum Time: NT=3D 24.029462000 ms T=3D 24.038915000 ms
> >
> > The first weird thing as you can see is that the time taken is the
> > same for a range as long as it is a multiple of 48 bytes. Also it
> > doesn't change
> > between the prioritized threaded version and non-threaded version.
> >
> > The Second weird thing is that for buffer sizes with some values
> > multiples of 24 gives the message "stack smashing detected". Some
> > values are 72 and 120 bytes.
> >
> > Any Ideas of what it could be?
> >
> > My settings for serial:
> > - 115200 bauds. 8 bits, No parity bit, 1 stop bit
> > - ASYNC_LOW_LATENCY flag is set
> > - Raw input/output
> >
> > Also if I consider the settings above, I would have a frame of 10 bits
> > (given 8N1 setting) per second received/delivered from which 8 bits
> > are useful data. So it gives 11520 chars (or useful bytes) per second.
> > For example, to send 96 bytes it would take 96/11520 seconds or
> > approx. 8.33 ms. I know that there is the overhead to system calls and
> > other OS complexities, but is there any way to diminish the time taken
> > from 12 ms to something at least closer to 8.33 ms?
> >
> >> Em qui., 16 de jul. de 2020 =C3=A0s 17:40, Austin Schuh
> >> <austin.linux@gmail.com> escreveu:
> >>
> >>> On Thu, Jul 16, 2020 at 1:21 PM Michel Macena Oliveira
> >>> <michel@austral-dynamics.com> wrote:
> >>>
> >>> Em qui., 16 de jul. de 2020 =C3=A0s 16:26, Itai Handler
> >>> <itai.handler@gmail.com> escreveu:
> >>>>
> >>>> Hi Michel,
> >>>>
> >>>> On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wro=
te:
> >>>>> Hi, sorry for my newbie question,
> >>>>> What is the status of the serial port driver?
> >>>>> I've written some code to use serial ports  for the generic kernel =
linux,
> >>>>> And now I want to write something similar for the real time kernel,=
 do
> >>>>> I have to use some specific library, flags or something or is it ju=
st
> >>>>> the same settings?
> >>>>>
> >>>>> I'm asking because now I need to take into account the serial acces=
s
> >>>>> in the scheduler to ensure a real time behavior .
> >>>>>
> >>>>> Any help, advice, hint or tips would be appreciated.
> >>>>>
> >>>>
> >>>> Do you mean that you wrote some code that works with a /dev/tty* ser=
ial port?
> >>>>
> >>>> In some kernel versions (e.g 4.19) we saw high latencies in the rx
> >>>> path of serial drivers.
> >>>> I think that this is due to rx handled in the context of a workqueue
> >>>> which also handles other system activities.
> >>>> We found a workaround to this problem. If I remember correctly we
> >>>> create a dedicated thread for the port and assign it a high priority=
.
> >>>>
> >>>> Itai Handler
> >>>
> >>> Thanks for the answer,
> >>> Yes I wrote a code that works with  /dev/tty* serial using termios.h.
> >>> I thought exactly what you suggested, to use a dedicated thread, but
> >>> how to properly implement it?
> >>> I mean in a simple way, just need to put open and write calls inside
> >>> the high priority (RT) thread?
> >>>
> >>> Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT
> >>
> >> Itai is talking about the kernel work to handle the serial data, not
> >> the userspace work.  We found the same thing, that the work goes
> >> through a work queue in the kernel, which adds unbounded latency.
> >>
> >> https://www.spinics.net/lists/linux-serial/msg07341.html looks
> >> relevant and matches my memory of what we did to solve this.  There's
> >> either a flag in userspace or patch to apply to the kernel (and then a
> >> flag) to skip the work queue.
> >>
> >> Austin
