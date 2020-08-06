Return-Path: <SRS0=7qTo=BQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03377C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Aug 2020 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5422173E
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Aug 2020 19:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAYVjaLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHFT4a (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFT4a (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Aug 2020 15:56:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF5C061574
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Aug 2020 12:56:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g8so9865824wmk.3
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Aug 2020 12:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fuv9H9EjiBtcd8RavITta2hg/T+LAucnmmaNXUhh980=;
        b=LAYVjaLHkWubVHTE10M8u66/Kg3pgojuWnd3QKC8hG3khuYjzprlOp80n7ptjz0m+B
         gUJx5tbg52z5rT+jSZavXuWXwXnethZ0dC+mwLLtcbBDc1tDdFwxeYnavd8DRDzmm7Xj
         sNTxa5pnjKXmkqeVQFbmk57hrbFNVwsHWoX7zHEKTNuIEeBMBQVlz/rGk/SLJsD1XZFZ
         dfXazmw0fjx/5BuZ1IaNLYH5tknhuLz3aPjNaZHjuKI0nuH5j4CQJadYOyk4r4DlV4kP
         Hwg27mzTM6N8LkYOlS6ENtV5PAo+9nEjRWzg6+xlWUIBq4YQSWUb4jzVNrhlhX6EzBbK
         oxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fuv9H9EjiBtcd8RavITta2hg/T+LAucnmmaNXUhh980=;
        b=Z15fn38CH9dOUBDljFKkTu+nFVNs4MrFK+RKnbNIOawzB+Yz5o4gwbg3dyd+YNG4Th
         jhLmMx8v9fFDlCpn+Sb9W4j3UXBIeUnktfHVhao7CKuq6rG1IIQyThyjLXZ3cvwxSM7x
         4kEJmzTVGiSwnJlQeTw9xpodtJ+a5pKF5DG3WkGFDrNjOaLdYNjoXV/Av6K417B68RYn
         9gNMXPBKgxmI+scfxEUxOVjM9NS37X7hj8U8IZmcvao/6H6TDVykx8TJCYJrCp+EpD5v
         LuAUBvWvEBZP7ojK+r7r2KYS+8D33rAmvqw4JlcbPbdzNpnA4TLccApNdE3s7/6yPMiI
         +R0g==
X-Gm-Message-State: AOAM531vV87EaswOm9soxVKr/nYyyh/Cjy8ey+6v42pBOQ3dhySTF2R+
        hD6Qq4YbwREGy3mqBZi+YPGB2jns
X-Google-Smtp-Source: ABdhPJz1g2c2O2wywiidLOtWxLHwbe5dtaH9fNU6N+Xo9Umi5O0XcWNg7WoVscdB7siF6oiHaSqKiQ==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr9216839wmj.122.1596743788181;
        Thu, 06 Aug 2020 12:56:28 -0700 (PDT)
Received: from [192.168.86.212] (89-138-146-165.bb.netvision.net.il. [89.138.146.165])
        by smtp.gmail.com with ESMTPSA id p6sm7248746wru.33.2020.08.06.12.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:56:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Itai Handler <itai.handler@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: Serial port driver usage and status
Date:   Thu, 6 Aug 2020 22:56:26 +0300
Message-Id: <47AD6512-D260-414D-9727-EE8AB3CF7095@gmail.com>
References: <CAKkbJ-wBoJUXzhLxsT4xaOgc3RcG7_U_H=WMKb=y=Ebks2cBcw@mail.gmail.com>
Cc:     linux-rt-users@vger.kernel.org
In-Reply-To: <CAKkbJ-wBoJUXzhLxsT4xaOgc3RcG7_U_H=WMKb=y=Ebks2cBcw@mail.gmail.com>
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Michel,

I think that you should first measure the resolution of your clock.
You can do it by calling clock_gettime repeatedly and saving the results int=
o an array.
Don=E2=80=99t run this test at a real-time priority because your measurement=
s may be affected by RT throttling in that case.

If your clock resolution is good enough, you should proceed to analyze it us=
ing ftrace.
Steven Rostedt gave many talks about ftrace and you should be able to find s=
ome of his videos and slides online.

Itai Handler

> On 5 Aug 2020, at 22:52, Michel Macena Oliveira <michel@austral-dynamics.c=
om> wrote:
>=20
> =EF=BB=BFHi Itai,
> I get  the end time after the tcdrain function. I found that my
> CONFIG_HZ is 250 and know that you said it makes
> sense the 4 ms. To be honest I've searched about this and still I
> didn't understand this frequency and how it is related to time
> functions such as clock_gettime. Is it kind
> of frequency "given" to the user to have as a time base? I'm lost in
> which context it applies, kernel space, user space or any abstraction
> level of the system.
> Could you elaborate or give me some good material as a reference?
>=20
> I searched about the ftrace, and if I understand correctly this and
> the CONFIG_HZ option should be enabled during kernel compiling time.
>=20
>> Em qua., 5 de ago. de 2020 =C3=A0s 16:21, Itai Handler
>> <itai.handler@gmail.com> escreveu:
>>=20
>> Hi Michel,
>>=20
>> If I understand correctly, you=E2=80=99re measuring the duration of the w=
rite function to a serial port.
>> I think that there is no guarantee that this function will return before t=
he port finishes to transmit all data.
>> However that doesn=E2=80=99t explain why you=E2=80=99re observing longer t=
han expected duration.
>> The difference in times of 4ms (from 8 to 12) suggests that the scheduler=
 is involved.
>> I guess you=E2=80=99re working with CONFIG_HZ_250?
>> May I suggest that you use function graph tracing (ftrace) to analyze it?=

>>=20
>> Itai Handler
>>=20
>>=20
>>=20
>>>> On 5 Aug 2020, at 21:29, Michel Macena Oliveira <michel@austral-dynamic=
s.com> wrote:
>>>=20
>>> =EF=BB=BFHi, Thanks for your answers
>>>=20
>>> I've written two simple codes to write a buffer of characters
>>> into the serial port. I'm reading the characters on another computer
>>> (windows 10, Termite as serial monitor). I did a simple time analysis
>>> to know how much time to write a given number of bytes into the port
>>> for both codes.
>>> In the first code the write function was called in the main function,
>>> in the second I put inside a thread function with sched priority 90.
>>>=20
>>> I did the time analysis using the clock_gettime function with the
>>> CLOCK_REALTIME flag to get time before and after the write call inside
>>> a testing loop. Then I got the time measures, calculated the average
>>> and stored the maximum value.
>>> I got the same results with non-threaded (NT) and threaded (T) code.
>>> But I found something weird for both.
>>>=20
>>> For 1000 testing loops:
>>>=20
>>> buffer size:  1
>>> Average Time: NT=3D 8.044138785 ms  T=3D 8.126175254 ms
>>> Maximum Time: NT=3D 12.069355000 ms T=3D 12.102010000 ms
>>>=20
>>> buffer size:  48
>>> Average Time:  NT=3D 8.021624309 ms  T=3D 8.038524315 ms
>>> Maximum Time:  NT=3D 12.018302000 ms T=3D 12.054890000 ms
>>>=20
>>> buffer size:  49
>>> Average Time: NT=3D 12.010010796 ms T=3D 12.044165909 ms
>>> Maximum Time: NT=3D 16.019277000 ms T=3D 16.038130000 ms
>>>=20
>>> buffer size:  96
>>> Average Time: NT=3D 12.057916205 ms T=3D 12.054206314 ms
>>> Maximum Time: NT=3D 16.101405000 ms T=3D 16.040888000 ms
>>>=20
>>> buffer size:  144
>>> Average Time: NT=3D 16.043416532 ms T=3D 16.020754198 ms
>>> Maximum Time: NT=3D 20.069923000 ms T=3D 20.059298000 ms
>>>=20
>>> buffer size:  145
>>> Average Time: NT=3D 20.039547930 ms T=3D 20.048668453 ms
>>> Maximum Time: NT=3D 24.029462000 ms T=3D 24.038915000 ms
>>>=20
>>> The first weird thing as you can see is that the time taken is the
>>> same for a range as long as it is a multiple of 48 bytes. Also it
>>> doesn't change
>>> between the prioritized threaded version and non-threaded version.
>>>=20
>>> The Second weird thing is that for buffer sizes with some values
>>> multiples of 24 gives the message "stack smashing detected". Some
>>> values are 72 and 120 bytes.
>>>=20
>>> Any Ideas of what it could be?
>>>=20
>>> My settings for serial:
>>> - 115200 bauds. 8 bits, No parity bit, 1 stop bit
>>> - ASYNC_LOW_LATENCY flag is set
>>> - Raw input/output
>>>=20
>>> Also if I consider the settings above, I would have a frame of 10 bits
>>> (given 8N1 setting) per second received/delivered from which 8 bits
>>> are useful data. So it gives 11520 chars (or useful bytes) per second.
>>> For example, to send 96 bytes it would take 96/11520 seconds or
>>> approx. 8.33 ms. I know that there is the overhead to system calls and
>>> other OS complexities, but is there any way to diminish the time taken
>>> from 12 ms to something at least closer to 8.33 ms?
>>>=20
>>>> Em qui., 16 de jul. de 2020 =C3=A0s 17:40, Austin Schuh
>>>> <austin.linux@gmail.com> escreveu:
>>>>=20
>>>>> On Thu, Jul 16, 2020 at 1:21 PM Michel Macena Oliveira
>>>>> <michel@austral-dynamics.com> wrote:
>>>>>=20
>>>>> Em qui., 16 de jul. de 2020 =C3=A0s 16:26, Itai Handler
>>>>> <itai.handler@gmail.com> escreveu:
>>>>>>=20
>>>>>> Hi Michel,
>>>>>>=20
>>>>>> On 7/16/20, Michel Macena Oliveira <michel@austral-dynamics.com> wrot=
e:
>>>>>>> Hi, sorry for my newbie question,
>>>>>>> What is the status of the serial port driver?
>>>>>>> I've written some code to use serial ports  for the generic kernel l=
inux,
>>>>>>> And now I want to write something similar for the real time kernel, d=
o
>>>>>>> I have to use some specific library, flags or something or is it jus=
t
>>>>>>> the same settings?
>>>>>>>=20
>>>>>>> I'm asking because now I need to take into account the serial access=

>>>>>>> in the scheduler to ensure a real time behavior .
>>>>>>>=20
>>>>>>> Any help, advice, hint or tips would be appreciated.
>>>>>>>=20
>>>>>>=20
>>>>>> Do you mean that you wrote some code that works with a /dev/tty* seri=
al port?
>>>>>>=20
>>>>>> In some kernel versions (e.g 4.19) we saw high latencies in the rx
>>>>>> path of serial drivers.
>>>>>> I think that this is due to rx handled in the context of a workqueue
>>>>>> which also handles other system activities.
>>>>>> We found a workaround to this problem. If I remember correctly we
>>>>>> create a dedicated thread for the port and assign it a high priority.=

>>>>>>=20
>>>>>> Itai Handler
>>>>>=20
>>>>> Thanks for the answer,
>>>>> Yes I wrote a code that works with  /dev/tty* serial using termios.h.
>>>>> I thought exactly what you suggested, to use a dedicated thread, but
>>>>> how to properly implement it?
>>>>> I mean in a simple way, just need to put open and write calls inside
>>>>> the high priority (RT) thread?
>>>>>=20
>>>>> Current kernel: 4.4.208-rt198 #1 SMP PREEMPT RT
>>>>=20
>>>> Itai is talking about the kernel work to handle the serial data, not
>>>> the userspace work.  We found the same thing, that the work goes
>>>> through a work queue in the kernel, which adds unbounded latency.
>>>>=20
>>>> https://www.spinics.net/lists/linux-serial/msg07341.html looks
>>>> relevant and matches my memory of what we did to solve this.  There's
>>>> either a flag in userspace or patch to apply to the kernel (and then a
>>>> flag) to skip the work queue.
>>>>=20
>>>> Austin
