Return-Path: <SRS0=2Kn/=BP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B19C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Aug 2020 19:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC32D2064B
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Aug 2020 19:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=austral-dynamics-com.20150623.gappssmtp.com header.i=@austral-dynamics-com.20150623.gappssmtp.com header.b="YzCEYH63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgHETJM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgHES4S (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Aug 2020 14:56:18 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A183DC061756
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Aug 2020 11:29:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g14so9446108iom.0
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Aug 2020 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hx9xH2UaXbsy2M1IFcFx7SlEklyXDMJ3PK8qw4jPBGQ=;
        b=YzCEYH63YzYJpI7D1CtnjmXIVPRDGu1VXudu3vTwJ9o/jyhJsRxM4HKUVnuoK9BTOW
         CcN0/K685ltYZo4re4SFxJZZVQ0g9zqYgmWdbNH4l+1oMDwI8FeX5C3pNJmhyuOCwDjY
         XdLD/mLrBYDgzbwJHbnFHP3lYWybzLUxxd35CgbIl6bvscExXklwnOcaullYmLJL77P6
         lP5P6aDa6MrBtBVhvniMRv3BAHR65awGwX7iYb1jEe5F+r4gfyLCTIkDsah2E17MFTM7
         PGmrPc6pUwSkKGP2wryNH5MAc2NUGAA0B4mo1zLtupUYzrenuSJ6Qx2oJv1YvWyUfc8l
         Ju+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hx9xH2UaXbsy2M1IFcFx7SlEklyXDMJ3PK8qw4jPBGQ=;
        b=oeJAIC+6cMBQ+lCh1A4utxHNywupFkaZ19FWJZXAelQjteUe/plPrIrx3f9/l1y30Y
         C8Du/GxomqPM6NMEXnCLcqdw41haPXYePxAyMlLDoj0e68p7FoivvdVdBzTzJZFUxykW
         cqJSsBP+RVTbT8vBgLHjoneomk4jQLIfBg1ntu+2qLbqKO/0A1Z3PKCH3+fu52sPUBW3
         oL8M24WwRki7QNtU6wV7NvbP4hTLfyrZTRQpxkW6pe1zcbtBt2pYntOphuZjQ4Sj/vor
         xDzhSvm83iAJtyHPgX1jtF36sSycHoP06yJh8F/+g/B3mVyk4api41AaFLZK0hPGnLnR
         WdfA==
X-Gm-Message-State: AOAM5336mAEFY99suvqL4jr0hpousoJ9NHI0lATH1FYJf4J3PSTan61f
        oEiDl7nrl6TKn7R7VWNqBs7Akzr7lt67isfqPnzywstqhuI=
X-Google-Smtp-Source: ABdhPJwa5IpfiOSZtY39pI2yzm3/YrMVRH7+aezFaEMjHQU+3fDL7kyVcAFdZaUPbE/8dao164n72T9vkTqE4z6ibtc=
X-Received: by 2002:a6b:c88f:: with SMTP id y137mr4764152iof.55.1596652154979;
 Wed, 05 Aug 2020 11:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkbJ-yB4XGuexzmwfkR8g76HR8iCkXaHsXaLaS6V+Wfy86bvg@mail.gmail.com>
 <CAFpOueQm5MhbrV53=kAcw=ES2LzsZPkmX2SqTVKuYTf0QDt=7w@mail.gmail.com>
 <CAKkbJ-wDsGO+ZHKZFkPfUL113ONc=NNNeShQkLf+ZH82iaBTEQ@mail.gmail.com> <CABsbf=E9D_NvXHZ5z1aLFN4Jcg+s+ADVFZVJi=jkpPOknTN7cA@mail.gmail.com>
In-Reply-To: <CABsbf=E9D_NvXHZ5z1aLFN4Jcg+s+ADVFZVJi=jkpPOknTN7cA@mail.gmail.com>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Wed, 5 Aug 2020 15:29:04 -0300
Message-ID: <CAKkbJ-yHNiF2oqf8dx2RiVUPrMRAsxve-M9pS_62GYje7jx8tw@mail.gmail.com>
Subject: Re: Serial port driver usage and status
To:     Austin Schuh <austin.linux@gmail.com>
Cc:     Itai Handler <itai.handler@gmail.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, Thanks for your answers

I've written two simple codes to write a buffer of characters
into the serial port. I'm reading the characters on another computer
(windows 10, Termite as serial monitor). I did a simple time analysis
to know how much time to write a given number of bytes into the port
for both codes.
In the first code the write function was called in the main function,
in the second I put inside a thread function with sched priority 90.

I did the time analysis using the clock_gettime function with the
CLOCK_REALTIME flag to get time before and after the write call inside
a testing loop. Then I got the time measures, calculated the average
and stored the maximum value.
I got the same results with non-threaded (NT) and threaded (T) code.
But I found something weird for both.

For 1000 testing loops:

buffer size:  1
Average Time: NT=3D 8.044138785 ms  T=3D 8.126175254 ms
Maximum Time: NT=3D 12.069355000 ms T=3D 12.102010000 ms

buffer size:  48
Average Time:  NT=3D 8.021624309 ms  T=3D 8.038524315 ms
Maximum Time:  NT=3D 12.018302000 ms T=3D 12.054890000 ms

buffer size:  49
Average Time: NT=3D 12.010010796 ms T=3D 12.044165909 ms
Maximum Time: NT=3D 16.019277000 ms T=3D 16.038130000 ms

buffer size:  96
Average Time: NT=3D 12.057916205 ms T=3D 12.054206314 ms
Maximum Time: NT=3D 16.101405000 ms T=3D 16.040888000 ms

buffer size:  144
Average Time: NT=3D 16.043416532 ms T=3D 16.020754198 ms
Maximum Time: NT=3D 20.069923000 ms T=3D 20.059298000 ms

buffer size:  145
Average Time: NT=3D 20.039547930 ms T=3D 20.048668453 ms
Maximum Time: NT=3D 24.029462000 ms T=3D 24.038915000 ms

The first weird thing as you can see is that the time taken is the
same for a range as long as it is a multiple of 48 bytes. Also it
doesn't change
between the prioritized threaded version and non-threaded version.

The Second weird thing is that for buffer sizes with some values
multiples of 24 gives the message "stack smashing detected". Some
values are 72 and 120 bytes.

Any Ideas of what it could be?

My settings for serial:
- 115200 bauds. 8 bits, No parity bit, 1 stop bit
- ASYNC_LOW_LATENCY flag is set
- Raw input/output

Also if I consider the settings above, I would have a frame of 10 bits
(given 8N1 setting) per second received/delivered from which 8 bits
are useful data. So it gives 11520 chars (or useful bytes) per second.
For example, to send 96 bytes it would take 96/11520 seconds or
approx. 8.33 ms. I know that there is the overhead to system calls and
other OS complexities, but is there any way to diminish the time taken
from 12 ms to something at least closer to 8.33 ms?

Em qui., 16 de jul. de 2020 =C3=A0s 17:40, Austin Schuh
<austin.linux@gmail.com> escreveu:
>
> On Thu, Jul 16, 2020 at 1:21 PM Michel Macena Oliveira
> <michel@austral-dynamics.com> wrote:
> >
> > Em qui., 16 de jul. de 2020 =C3=A0s 16:26, Itai Handler
> > <itai.handler@gmail.com> escreveu:
> > >
> > > Hi Michel,
> > >
> > > On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wrot=
e:
> > > > Hi, sorry for my newbie question,
> > > > What is the status of the serial port driver?
> > > > I've written some code to use serial ports  for the generic kernel =
linux,
> > > > And now I want to write something similar for the real time kernel,=
 do
> > > > I have to use some specific library, flags or something or is it ju=
st
> > > > the same settings?
> > > >
> > > > I'm asking because now I need to take into account the serial acces=
s
> > > > in the scheduler to ensure a real time behavior .
> > > >
> > > > Any help, advice, hint or tips would be appreciated.
> > > >
> > >
> > > Do you mean that you wrote some code that works with a /dev/tty* seri=
al port?
> > >
> > > In some kernel versions (e.g 4.19) we saw high latencies in the rx
> > > path of serial drivers.
> > > I think that this is due to rx handled in the context of a workqueue
> > > which also handles other system activities.
> > > We found a workaround to this problem. If I remember correctly we
> > > create a dedicated thread for the port and assign it a high priority.
> > >
> > > Itai Handler
> >
> > Thanks for the answer,
> > Yes I wrote a code that works with  /dev/tty* serial using termios.h.
> > I thought exactly what you suggested, to use a dedicated thread, but
> > how to properly implement it?
> > I mean in a simple way, just need to put open and write calls inside
> > the high priority (RT) thread?
> >
> > Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT
>
> Itai is talking about the kernel work to handle the serial data, not
> the userspace work.  We found the same thing, that the work goes
> through a work queue in the kernel, which adds unbounded latency.
>
> https://www.spinics.net/lists/linux-serial/msg07341.html looks
> relevant and matches my memory of what we did to solve this.  There's
> either a flag in userspace or patch to apply to the kernel (and then a
> flag) to skip the work queue.
>
> Austin
