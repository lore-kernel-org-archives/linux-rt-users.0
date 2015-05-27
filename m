From: Daniel Wagner <wagi@monom.org>
Subject: Re: Full RT kernel problem on arm
Date: Wed, 27 May 2015 13:18:44 +0200
Message-ID: <5565A814.1090208@monom.org>
References: <CAOn_9a4vX9ixCJ-ZyhbjTAsghrH4UYW-UzWug3kKaUZvw5WUDA@mail.gmail.com>	<55656DEA.4040006@monom.org> <CAOn_9a7_Dkq10nTcA6_GguzU-xt=XGztFBd1+=87GO7FCXqV_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Warter <warter@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33639 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbE0LSs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 07:18:48 -0400
Received: by wgez8 with SMTP id z8so6504500wge.0
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2015 04:18:47 -0700 (PDT)
In-Reply-To: <CAOn_9a7_Dkq10nTcA6_GguzU-xt=XGztFBd1+=87GO7FCXqV_Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/27/2015 09:33 AM, Warter wrote:
>> Without any logs it is pretty hard to help here. Do yoi happen to have
>> an serial port for logging? In this case redirect the console output.
> 
> I dont have serial port on Hummingboard. Unfortunately I am not
> familiar with debugging, but I can provide anything what you need.

I am not familiar with the Humminboard board, though it looks like the
UART is available via the GPIO pins. Getting a debugging setup running
is not simple task, though it might help in future :)

Another way to debug this is trying to reduce the problem. From your
description the mpd itself could just have a severe memory leak and that
is not handled correctly. As starting point you could try to get some
mpd logs out before it freezes?
