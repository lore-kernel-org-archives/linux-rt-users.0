From: jordan <triplesquarednine@gmail.com>
Subject: Re: Linux-rt fails to boot [any release past 3.12.5-rt7] on all of my machines
Date: Tue, 11 Feb 2014 10:49:43 -0500
Message-ID: <CAOcfFMxCEQSR-sBGA98ac66sUM4peZfGP8vHrqgrM4FUTKHcBQ@mail.gmail.com>
References: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com>
	<20140207152250.GC2382@linutronix.de>
	<CAOcfFMzcymuyoi+Ox6pQ=U7KBbmbwFOYwHZHKBQPQpmjBLkQJQ@mail.gmail.com>
	<52FA43C8.5000102@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:42645 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaBKPtn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Feb 2014 10:49:43 -0500
Received: by mail-ve0-f177.google.com with SMTP id jz11so6171720veb.36
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Feb 2014 07:49:43 -0800 (PST)
In-Reply-To: <52FA43C8.5000102@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Feb 11, 2014 at 10:37 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 02/11/2014 04:16 PM, jordan wrote:
>> Hi,
>
> Hi Jordan,

Hey Sebastian

> Okay. v3.12.5-rt7 is something I released with -RT changes. v3.12.6-rt8
> has zero -RT changes, only stable increment. That means, the -RT patch
> should be exactly the same (except for localversion).
> So whatever breaks booting v3.12.6-rt8 is something that came via
> stable queue.

Okay, so now I have a place to start looking. :) So, while
mainline/vanilla 3.12.6+ (including 3.12.10) boots just fine - there
appears to be some change on mainline post 3.12.6 that is causing a
boot failure [but only triggered] on -rt. [?]

I'll have a look and see if any obvious commits stands out, but i
guess i will likely have to do git-bisect to find the bad commit... I
don't know if i will have time tonight, but i should be able to find
some time over the next few days.

thanks

> Sebastian

Jordan
