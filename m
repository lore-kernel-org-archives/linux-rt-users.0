From: Hartmut Behrens <hartmut.behrens@gmail.com>
Subject: Re: cyclictest: Unable to set scheduling policy / join real-time
 group or run as root
Date: Mon, 25 Feb 2013 23:24:05 +0200
Message-ID: <CA+69FtAWbTm-9vJYXnV3xOFNRKd4iKvh0Uo83ct_qqm9S2b9Cw@mail.gmail.com>
References: <CA+69FtA6iP5Zer6ENWSgp8uyUc9OQv00JEV6ihz=SihRyEExJw@mail.gmail.com>
	<457E1107-480D-493F-9073-4AE455BA3BD2@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:55036 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758538Ab3BYVYG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Feb 2013 16:24:06 -0500
Received: by mail-ve0-f172.google.com with SMTP id cz11so2662550veb.31
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Feb 2013 13:24:06 -0800 (PST)
In-Reply-To: <457E1107-480D-493F-9073-4AE455BA3BD2@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

No, neither of these work (realtime groupnames that were tried:
realtime  / rtprio)

This might be related:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=619938 but I have yet
to dig into the details.

Are there perhaps any other suggestions?

Best Regards,

Hartmut

On Mon, Feb 25, 2013 at 10:55 PM, Sven-Thorsten Dietrich
<sven@thebigcorporation.com> wrote:
>
> On Feb 25, 2013, at 12:03 PM, Hartmut Behrens <hartmut.behrens@gmail.com> wrote:
>
>> Dear RT Folks,
>>
>> After successfully patching a 3.2 kernel (gumstix platform) with
>> patch-3.2-rt10, I obtained the rt-tests suite from
>> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
>>
>> I enabled CONFIG_PREEMPT_RT in menuconfig and disabled "CPU frequency scaling".
>>
>> Compilation of rt-tests ("make all") on the platform is also successful.
>>
>> When trying to execute cyclictest, the program reports: "Unable to
>> change scheduling policy! either run as root or join realtime group"
>>
>> Looking in rt-utils.c, it appears that set_scheduler is unable to
>> select SCHED_FIFO scheduling policy.
>>
>> Do you have any hints on how to fix this problem, or at least narrow
>> it down further? Could it
>>
>
> Does "either run as root or join realtime group" fix the problem?
>
> Sven
>
>> Best Regards,
>> Hartmut Behrens
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
