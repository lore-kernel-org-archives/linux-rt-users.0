From: Warter <warter@gmail.com>
Subject: Re: Full RT kernel problem on arm
Date: Wed, 27 May 2015 09:33:20 +0200
Message-ID: <CAOn_9a7_Dkq10nTcA6_GguzU-xt=XGztFBd1+=87GO7FCXqV_Q@mail.gmail.com>
References: <CAOn_9a4vX9ixCJ-ZyhbjTAsghrH4UYW-UzWug3kKaUZvw5WUDA@mail.gmail.com>
	<55656DEA.4040006@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33148 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbE0HdV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 03:33:21 -0400
Received: by wicmx19 with SMTP id mx19so84929708wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2015 00:33:20 -0700 (PDT)
In-Reply-To: <55656DEA.4040006@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

> Without any logs it is pretty hard to help here. Do yoi happen to have
> an serial port for logging? In this case redirect the console output.

I dont have serial port on Hummingboard. Unfortunately I am not
familiar with debugging, but I can provide anything what you need.

Thanks,
Szilard


On 27 May 2015 at 09:10, Daniel Wagner <wagi@monom.org> wrote:
> Hi,
>
> On 05/22/2015 02:36 PM, Warter wrote:
>> Hello to all,
>>
>> I tried to use RT kernel for my streaming server (Music Player Daemon)
>> on my Hummingboard (Debian Jessie). If I send some commands
>> (stop-start-next track) in row the mpd starts to eat up the resources.
>> It freezes and I cannot kill it or reboot/shutdown the board. I have
>> to reset the board, no other solution. It works fine if I use Basic
>> RT. I tried with several kernel versions (3.14, 3.18, 4.0, 4.1).
>>
>> Thanks for any comment regarding issue or better way for bug-report,
>
> Without any logs it is pretty hard to help here. Do yoi happen to have
> an serial port for logging? In this case redirect the console output.
>
> HTH,
> Daniel
