Return-Path: <SRS0=CYeZ=BV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED7C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Aug 2020 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CFA206C3
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Aug 2020 14:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austral-dynamics-com.20150623.gappssmtp.com header.i=@austral-dynamics-com.20150623.gappssmtp.com header.b="1Kjsbml4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgHKOnf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgHKOne (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Aug 2020 10:43:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA99C06174A
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Aug 2020 07:43:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z3so10823730ilh.3
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Aug 2020 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gXgm076nNxoyeciwWedUzEYJpQZ6zo4UFPfftlRpB6c=;
        b=1Kjsbml4q505aiidp0I5TOJllYWfef5x0x7284aeOZtAZ3hhmGFYfCq22D7NgF9qjp
         5Znqwqo4hpTDkGgyYuP0Ln1DoZwmT7ZNecC0k0wTgM8M/vkAeF9mtDB77C9PKb5ViH52
         elKgNpaNfcyC/lDdMGmDFYeZ0KmNuEctm6V/ktgmkaAxB6qyPzdb3C9QOs5k69U8qyxK
         vTT8jbUNtdYrHmXgj5pSKs7BkZ0crQKSNI0Olnynznl4m0AkNwrQiT7SMkEI1mIsvFg/
         ZZLC/i3Uh4pVdRPgOZQJgUC8iRY+iDq3n2rL/8HWAyPc7xUg8QZzsJwunaotZX4TkK3X
         A8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gXgm076nNxoyeciwWedUzEYJpQZ6zo4UFPfftlRpB6c=;
        b=unVzBe71wJtSCNsW8h+R+S14VG8n4nijBHQfmVZITTbSsr4iwrreYufrIq2DXVsi0A
         ocORyrfQlYg9lcB/rzYpG71Qro8P4ZB4PYb57cWPyixQM8UnhKsYFE8n8RKIyq8oBtAM
         45KqJpwfLr4+zbEPk9CHf21ihpQiDysHDSz9EC0q5oYwsMfKfu7A9MRpiNnXbQtAWvb9
         8xD+PQHouAyhxQIwWv9YxSr+piALOlUGCfPjpav87k23U3Z3HrpKPa3RIovAUZIbmWLY
         kLwgh2A5rGCGqLfgKUsV1Zl/s2r6RtDcO+GD/XLlLVmY/9LFFS/oavHUqY00Pxn3FWUK
         NHmA==
X-Gm-Message-State: AOAM53214hZspPDhd2OFlgpV3Osxm8fEKcVaIEXkOkWSw5FXSkxVEisu
        nxhWW8tXwmy84XW8W2FV42lDXO2Sx/dD+rvK8HRHsA==
X-Google-Smtp-Source: ABdhPJxbhbwbQa8bB+SVlj3x4aILfBD7qPak2RVzRjhQ0VF571OydQMfKKZixlumiv0Qwxu7lf4E7jMN+6PyFl2wncc=
X-Received: by 2002:a92:2c10:: with SMTP id t16mr22249522ile.24.1597157012592;
 Tue, 11 Aug 2020 07:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkbJ-wBoJUXzhLxsT4xaOgc3RcG7_U_H=WMKb=y=Ebks2cBcw@mail.gmail.com>
 <47AD6512-D260-414D-9727-EE8AB3CF7095@gmail.com>
In-Reply-To: <47AD6512-D260-414D-9727-EE8AB3CF7095@gmail.com>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Tue, 11 Aug 2020 11:43:21 -0300
Message-ID: <CAKkbJ-xyCH_RkOaihdN01sFRSznbX-Br7MrG9x0SRwDR6KAmYQ@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Itai Handler <itai.handler@gmail.com>,
        Austin Schuh <austin.linux@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Austin thanks for the Idea, those tests will give more reliable results.
Itai thanks for the idea, I will search more about ftrace.

Another newbie question, when I put a read or write call inside a
thread with real time priority, I can say that the call is real time
scheduled or should I code in a different way
to "make it" real time?  I mean, if just the fact that a function is
inside the RT thread with high priority  is enough to say it is real
time. I am asking this because I'm
still learning how the real time context fits into the Preempt RT
kernel concept.

Em qui., 6 de ago. de 2020 =C3=A0s 16:56, Itai Handler
<itai.handler@gmail.com> escreveu:
>
> Hi Michel,
>
> I think that you should first measure the resolution of your clock.
> You can do it by calling clock_gettime repeatedly and saving the results =
into an array.
> Don=E2=80=99t run this test at a real-time priority because your measurem=
ents may be affected by RT throttling in that case.
>
> If your clock resolution is good enough, you should proceed to analyze it=
 using ftrace.
> Steven Rostedt gave many talks about ftrace and you should be able to fin=
d some of his videos and slides online.
>
> Itai Handler
>
> > On 5 Aug 2020, at 22:52, Michel Macena Oliveira <michel@austral-dynamic=
s.com> wrote:
> >
> > =EF=BB=BFHi Itai,
> > I get  the end time after the tcdrain function. I found that my
> > CONFIG_HZ is 250 and know that you said it makes
> > sense the 4 ms. To be honest I've searched about this and still I
> > didn't understand this frequency and how it is related to time
> > functions such as clock_gettime. Is it kind
> > of frequency "given" to the user to have as a time base? I'm lost in
> > which context it applies, kernel space, user space or any abstraction
> > level of the system.
> > Could you elaborate or give me some good material as a reference?
> >
> > I searched about the ftrace, and if I understand correctly this and
> > the CONFIG_HZ option should be enabled during kernel compiling time.
> >
> >> Em qua., 5 de ago. de 2020 =C3=A0s 16:21, Itai Handler
> >> <itai.handler@gmail.com> escreveu:
> >>
> >> Hi Michel,
> >>
> >> If I understand correctly, you=E2=80=99re measuring the duration of th=
e write function to a serial port.
> >> I think that there is no guarantee that this function will return befo=
re the port finishes to transmit all data.
> >> However that doesn=E2=80=99t explain why you=E2=80=99re observing long=
er than expected duration.
> >> The difference in times of 4ms (from 8 to 12) suggests that the schedu=
ler is involved.
> >> I guess you=E2=80=99re working with CONFIG_HZ_250?
> >> May I suggest that you use function graph tracing (ftrace) to analyze =
it?
> >>
> >> Itai Handler
> >>
> >>
> >>
> >>>> On 5 Aug 2020, at 21:29, Michel Macena Oliveira <michel@austral-dyna=
mics.com> wrote:
> >>>
> >>> =EF=BB=BFHi, Thanks for your answers
> >>>
> >>> I've written two simple codes to write a buffer of characters
> >>> into the serial port. I'm reading the characters on another computer
> >>> (windows 10, Termite as serial monitor). I did a simple time analysis
> >>> to know how much time to write a given number of bytes into the port
> >>> for both codes.
> >>> In the first code the write function was called in the main function,
> >>> in the second I put inside a thread function with sched priority 90.
> >>>
> >>> I did the time analysis using the clock_gettime function with the
> >>> CLOCK_REALTIME flag to get time before and after the write call insid=
e
> >>> a testing loop. Then I got the time measures, calculated the average
> >>> and stored the maximum value.
> >>> I got the same results with non-threaded (NT) and threaded (T) code.
> >>> But I found something weird for both.
> >>>
> >>> For 1000 testing loops:
> >>>
> >>> buffer size:  1
> >>> Average Time: NT=3D 8.044138785 ms  T=3D 8.126175254 ms
> >>> Maximum Time: NT=3D 12.069355000 ms T=3D 12.102010000 ms
> >>>
> >>> buffer size:  48
> >>> Average Time:  NT=3D 8.021624309 ms  T=3D 8.038524315 ms
> >>> Maximum Time:  NT=3D 12.018302000 ms T=3D 12.054890000 ms
> >>>
> >>> buffer size:  49
> >>> Average Time: NT=3D 12.010010796 ms T=3D 12.044165909 ms
> >>> Maximum Time: NT=3D 16.019277000 ms T=3D 16.038130000 ms
> >>>
> >>> buffer size:  96
> >>> Average Time: NT=3D 12.057916205 ms T=3D 12.054206314 ms
> >>> Maximum Time: NT=3D 16.101405000 ms T=3D 16.040888000 ms
> >>>
> >>> buffer size:  144
> >>> Average Time: NT=3D 16.043416532 ms T=3D 16.020754198 ms
> >>> Maximum Time: NT=3D 20.069923000 ms T=3D 20.059298000 ms
> >>>
> >>> buffer size:  145
> >>> Average Time: NT=3D 20.039547930 ms T=3D 20.048668453 ms
> >>> Maximum Time: NT=3D 24.029462000 ms T=3D 24.038915000 ms
> >>>
> >>> The first weird thing as you can see is that the time taken is the
> >>> same for a range as long as it is a multiple of 48 bytes. Also it
> >>> doesn't change
> >>> between the prioritized threaded version and non-threaded version.
> >>>
> >>> The Second weird thing is that for buffer sizes with some values
> >>> multiples of 24 gives the message "stack smashing detected". Some
> >>> values are 72 and 120 bytes.
> >>>
> >>> Any Ideas of what it could be?
> >>>
> >>> My settings for serial:
> >>> - 115200 bauds. 8 bits, No parity bit, 1 stop bit
> >>> - ASYNC_LOW_LATENCY flag is set
> >>> - Raw input/output
> >>>
> >>> Also if I consider the settings above, I would have a frame of 10 bit=
s
> >>> (given 8N1 setting) per second received/delivered from which 8 bits
> >>> are useful data. So it gives 11520 chars (or useful bytes) per second=
.
> >>> For example, to send 96 bytes it would take 96/11520 seconds or
> >>> approx. 8.33 ms. I know that there is the overhead to system calls an=
d
> >>> other OS complexities, but is there any way to diminish the time take=
n
> >>> from 12 ms to something at least closer to 8.33 ms?
> >>>
> >>>> Em qui., 16 de jul. de 2020 =C3=A0s 17:40, Austin Schuh
> >>>> <austin.linux@gmail.com> escreveu:
> >>>>
> >>>>> On Thu, Jul 16, 2020 at 1:21 PM Michel Macena Oliveira
> >>>>> <michel@austral-dynamics.com> wrote:
> >>>>>
> >>>>> Em qui., 16 de jul. de 2020 =C3=A0s 16:26, Itai Handler
> >>>>> <itai.handler@gmail.com> escreveu:
> >>>>>>
> >>>>>> Hi Michel,
> >>>>>>
> >>>>>> On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> w=
rote:
> >>>>>>> Hi, sorry for my newbie question,
> >>>>>>> What is the status of the serial port driver?
> >>>>>>> I've written some code to use serial ports  for the generic kerne=
l linux,
> >>>>>>> And now I want to write something similar for the real time kerne=
l, do
> >>>>>>> I have to use some specific library, flags or something or is it =
just
> >>>>>>> the same settings?
> >>>>>>>
> >>>>>>> I'm asking because now I need to take into account the serial acc=
ess
> >>>>>>> in the scheduler to ensure a real time behavior .
> >>>>>>>
> >>>>>>> Any help, advice, hint or tips would be appreciated.
> >>>>>>>
> >>>>>>
> >>>>>> Do you mean that you wrote some code that works with a /dev/tty* s=
erial port?
> >>>>>>
> >>>>>> In some kernel versions (e.g 4.19) we saw high latencies in the rx
> >>>>>> path of serial drivers.
> >>>>>> I think that this is due to rx handled in the context of a workque=
ue
> >>>>>> which also handles other system activities.
> >>>>>> We found a workaround to this problem. If I remember correctly we
> >>>>>> create a dedicated thread for the port and assign it a high priori=
ty.
> >>>>>>
> >>>>>> Itai Handler
> >>>>>
> >>>>> Thanks for the answer,
> >>>>> Yes I wrote a code that works with  /dev/tty* serial using termios.=
h.
> >>>>> I thought exactly what you suggested, to use a dedicated thread, bu=
t
> >>>>> how to properly implement it?
> >>>>> I mean in a simple way, just need to put open and write calls insid=
e
> >>>>> the high priority (RT) thread?
> >>>>>
> >>>>> Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT
> >>>>
> >>>> Itai is talking about the kernel work to handle the serial data, not
> >>>> the userspace work.  We found the same thing, that the work goes
> >>>> through a work queue in the kernel, which adds unbounded latency.
> >>>>
> >>>> https://www.spinics.net/lists/linux-serial/msg07341.html looks
> >>>> relevant and matches my memory of what we did to solve this.  There'=
s
> >>>> either a flag in userspace or patch to apply to the kernel (and then=
 a
> >>>> flag) to skip the work queue.
> >>>>
> >>>> Austin
