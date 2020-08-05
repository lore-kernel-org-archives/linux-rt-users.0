Return-Path: <SRS0=2Kn/=BP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF0C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27612075D
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Aug 2020 19:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQozlNLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgHETVr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgHETVY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Aug 2020 15:21:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE01C061575
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Aug 2020 12:21:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so38180004wrm.12
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Aug 2020 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=/FxjIM4cEfQxv+nAa7hHtGuXLw6EHKhnODOkp2eQxeM=;
        b=pQozlNLPFDAAEzBubETLvrLXntWAOK/tQhF/nGAAsRh6TLxqOCCYe2k36qthgTe6o/
         SzZccYX+cnzqzaocBfn8w/MTSMDc2i54uly0VOtLWANT7RUMHuXg7KLurPcanBXgJ9z/
         ABT2eyuJFdFT/QWDKO0bc26amGVgPPl1cg2Ce1bSifCttilvYVRIKafCDAPQIVe0bceW
         m8v5Mt3W2ydw/Lq+5kG2gIED37Hn+5//26NaWykZ+e0M7TvwLRt2FAJGffw1X+raMnxl
         RwzRdp3aGQXDu5YH3qg8qrHtWkcbs9LwL0/1zLXeHIn04yU8pAaugNhsSs53fqRkPF3U
         bPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=/FxjIM4cEfQxv+nAa7hHtGuXLw6EHKhnODOkp2eQxeM=;
        b=Tq1SZJvUn8Hv6ViLaSit3EPc3Lx5YFHUe3sgeFUdshKcBcp7PtbC/bFskMafrPLHmY
         WQ8swkU/qjIIh+z6uXF9f6evffYV5fnS9QO1zHA17dizbpwqdgKbSJVcv19FEmkk5XHw
         pgU1YJsOjcxYwIIYgTeRuNVaKHkLF/2ZrwG9oWRMlS0Hv0f3qwmrpbfyYl9k0Muw9mxU
         So0QQNo2+SdVyO6fjZkiVSyNKaTF3wrxNWahh8e+SaxHXbYhPGSQ2/3v+qQlWX5NkK98
         Y9eJNMbxA9BfPDX/SJTCh+Bj26zpfaWMq4hCFgO0DcaH7Vdr1osS8tqygd/MyfPx+Jav
         clfA==
X-Gm-Message-State: AOAM530FK5se6LP/E//4ARbZ+lgrVKwbQs2RAEF34X+RsNINn7BxNIrJ
        qOzFpRjhzOy4G6J9uy89auA=
X-Google-Smtp-Source: ABdhPJz508nhPb6T0C5giM4/su4+z6GOqPwJQawqMNt7cG8AnEhKVKVzycoOSa0iW0lko2VacqqNgw==
X-Received: by 2002:adf:91a1:: with SMTP id 30mr4352841wri.29.1596655282523;
        Wed, 05 Aug 2020 12:21:22 -0700 (PDT)
Received: from [192.168.86.212] (89-138-146-165.bb.netvision.net.il. [89.138.146.165])
        by smtp.gmail.com with ESMTPSA id 3sm3722757wms.36.2020.08.05.12.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:21:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Itai Handler <itai.handler@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Serial port driver usage and status
Date:   Wed, 5 Aug 2020 22:21:20 +0300
Message-Id: <7071403B-CF64-4B4A-80F4-BCE7B593F555@gmail.com>
References: <CAKkbJ-yHNiF2oqf8dx2RiVUPrMRAsxve-M9pS_62GYje7jx8tw@mail.gmail.com>
Cc:     Austin Schuh <austin.linux@gmail.com>,
        linux-rt-users@vger.kernel.org
In-Reply-To: <CAKkbJ-yHNiF2oqf8dx2RiVUPrMRAsxve-M9pS_62GYje7jx8tw@mail.gmail.com>
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Michel,

If I understand correctly, you=E2=80=99re measuring the duration of the writ=
e function to a serial port.
I think that there is no guarantee that this function will return before the=
 port finishes to transmit all data.
However that doesn=E2=80=99t explain why you=E2=80=99re observing longer tha=
n expected duration.
The difference in times of 4ms (from 8 to 12) suggests that the scheduler is=
 involved.
I guess you=E2=80=99re working with CONFIG_HZ_250?
May I suggest that you use function graph tracing (ftrace) to analyze it?

Itai Handler



> On 5 Aug 2020, at 21:29, Michel Macena Oliveira <michel@austral-dynamics.c=
om> wrote:
>=20
> =EF=BB=BFHi, Thanks for your answers
>=20
> I've written two simple codes to write a buffer of characters
> into the serial port. I'm reading the characters on another computer
> (windows 10, Termite as serial monitor). I did a simple time analysis
> to know how much time to write a given number of bytes into the port
> for both codes.
> In the first code the write function was called in the main function,
> in the second I put inside a thread function with sched priority 90.
>=20
> I did the time analysis using the clock_gettime function with the
> CLOCK_REALTIME flag to get time before and after the write call inside
> a testing loop. Then I got the time measures, calculated the average
> and stored the maximum value.
> I got the same results with non-threaded (NT) and threaded (T) code.
> But I found something weird for both.
>=20
> For 1000 testing loops:
>=20
> buffer size:  1
> Average Time: NT=3D 8.044138785 ms  T=3D 8.126175254 ms
> Maximum Time: NT=3D 12.069355000 ms T=3D 12.102010000 ms
>=20
> buffer size:  48
> Average Time:  NT=3D 8.021624309 ms  T=3D 8.038524315 ms
> Maximum Time:  NT=3D 12.018302000 ms T=3D 12.054890000 ms
>=20
> buffer size:  49
> Average Time: NT=3D 12.010010796 ms T=3D 12.044165909 ms
> Maximum Time: NT=3D 16.019277000 ms T=3D 16.038130000 ms
>=20
> buffer size:  96
> Average Time: NT=3D 12.057916205 ms T=3D 12.054206314 ms
> Maximum Time: NT=3D 16.101405000 ms T=3D 16.040888000 ms
>=20
> buffer size:  144
> Average Time: NT=3D 16.043416532 ms T=3D 16.020754198 ms
> Maximum Time: NT=3D 20.069923000 ms T=3D 20.059298000 ms
>=20
> buffer size:  145
> Average Time: NT=3D 20.039547930 ms T=3D 20.048668453 ms
> Maximum Time: NT=3D 24.029462000 ms T=3D 24.038915000 ms
>=20
> The first weird thing as you can see is that the time taken is the
> same for a range as long as it is a multiple of 48 bytes. Also it
> doesn't change
> between the prioritized threaded version and non-threaded version.
>=20
> The Second weird thing is that for buffer sizes with some values
> multiples of 24 gives the message "stack smashing detected". Some
> values are 72 and 120 bytes.
>=20
> Any Ideas of what it could be?
>=20
> My settings for serial:
> - 115200 bauds. 8 bits, No parity bit, 1 stop bit
> - ASYNC_LOW_LATENCY flag is set
> - Raw input/output
>=20
> Also if I consider the settings above, I would have a frame of 10 bits
> (given 8N1 setting) per second received/delivered from which 8 bits
> are useful data. So it gives 11520 chars (or useful bytes) per second.
> For example, to send 96 bytes it would take 96/11520 seconds or
> approx. 8.33 ms. I know that there is the overhead to system calls and
> other OS complexities, but is there any way to diminish the time taken
> from 12 ms to something at least closer to 8.33 ms?
>=20
>> Em qui., 16 de jul. de 2020 =C3=A0s 17:40, Austin Schuh
>> <austin.linux@gmail.com> escreveu:
>>=20
>>> On Thu, Jul 16, 2020 at 1:21 PM Michel Macena Oliveira
>>> <michel@austral-dynamics.com> wrote:
>>>=20
>>> Em qui., 16 de jul. de 2020 =C3=A0s 16:26, Itai Handler
>>> <itai.handler@gmail.com> escreveu:
>>>>=20
>>>> Hi Michel,
>>>>=20
>>>> On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wrote:=

>>>>> Hi, sorry for my newbie question,
>>>>> What is the status of the serial port driver?
>>>>> I've written some code to use serial ports  for the generic kernel lin=
ux,
>>>>> And now I want to write something similar for the real time kernel, do=

>>>>> I have to use some specific library, flags or something or is it just
>>>>> the same settings?
>>>>>=20
>>>>> I'm asking because now I need to take into account the serial access
>>>>> in the scheduler to ensure a real time behavior .
>>>>>=20
>>>>> Any help, advice, hint or tips would be appreciated.
>>>>>=20
>>>>=20
>>>> Do you mean that you wrote some code that works with a /dev/tty* serial=
 port?
>>>>=20
>>>> In some kernel versions (e.g 4.19) we saw high latencies in the rx
>>>> path of serial drivers.
>>>> I think that this is due to rx handled in the context of a workqueue
>>>> which also handles other system activities.
>>>> We found a workaround to this problem. If I remember correctly we
>>>> create a dedicated thread for the port and assign it a high priority.
>>>>=20
>>>> Itai Handler
>>>=20
>>> Thanks for the answer,
>>> Yes I wrote a code that works with  /dev/tty* serial using termios.h.
>>> I thought exactly what you suggested, to use a dedicated thread, but
>>> how to properly implement it?
>>> I mean in a simple way, just need to put open and write calls inside
>>> the high priority (RT) thread?
>>>=20
>>> Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT
>>=20
>> Itai is talking about the kernel work to handle the serial data, not
>> the userspace work.  We found the same thing, that the work goes
>> through a work queue in the kernel, which adds unbounded latency.
>>=20
>> https://www.spinics.net/lists/linux-serial/msg07341.html looks
>> relevant and matches my memory of what we did to solve this.  There's
>> either a flag in userspace or patch to apply to the kernel (and then a
>> flag) to skip the work queue.
>>=20
>> Austin
