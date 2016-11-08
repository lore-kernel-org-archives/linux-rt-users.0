From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: Re: kernel panic in virt-manager
Date: Tue, 8 Nov 2016 06:02:08 +0100
Message-ID: <CA+Owze47v9rvNcmDbzC32kyTw8c=p0RPXEKWgY38jD_0gUOF_g@mail.gmail.com>
References: <CA+Owze4tsj82yyj=sZ03A5QN1d3HgA08anADhaXgUrgE0j9PZA@mail.gmail.com>
 <20161102103546.7xefntxl2i5gutf7@linutronix.de>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36262 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbcKHFDC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Nov 2016 00:03:02 -0500
Received: by mail-yw0-f179.google.com with SMTP id l124so162277768ywb.3
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Nov 2016 21:02:09 -0800 (PST)
In-Reply-To: <20161102103546.7xefntxl2i5gutf7@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

This happend as virtualization support was disabled by BIOS. And
occured multiple times, as
enabling hardware virtualization support there were no more problems.

Bests,
Jo=C3=ABl


On Wed, Nov 2, 2016 at 11:35 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2016-11-01 21:59:49 [+0100], Jo=C3=ABl Kr=C3=A4hemann wrote:
>> Hi
> Hi,
>
>> There is a screenshot of a kernel panic in the attachment.
>> The last thing I did was:
>>
>> apt-get install gdb valgrind make gcc automake autoconf on TTY2
>
> I see. So there is no backtrace and IP points to "doublefault". If you
> can reproduce it then you could redirect ttyS0 somewhere and log
> kernel's output there.
>
>> Bests,
>> Jo=C3=ABl
>
> Sebastian
