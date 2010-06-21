From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: beagleboard RT problem
Date: Mon, 21 Jun 2010 16:04:20 +0530
Message-ID: <AANLkTilakntJf43kOkuT0EVu6v3s17VNJR6S60lB2ls3@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	<alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
	<1276514850.26993.4.camel@sven.thebigcorporation.com>
	<AANLkTimWSQfXQGedfHHLAbabPrRnUaWlPCMUEC3I9_G0@mail.gmail.com>
	<AANLkTikP0Z8NbhiCd9yJeNJrnJqJkoXkSSErR_9B6dYC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Maksym Parkachov <lazy.gopher@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56813 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594Ab0FUKeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jun 2010 06:34:21 -0400
Received: by vws3 with SMTP id 3so845139vws.19
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jun 2010 03:34:20 -0700 (PDT)
In-Reply-To: <AANLkTikP0Z8NbhiCd9yJeNJrnJqJkoXkSSErR_9B6dYC@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Searching for "kernel tuning in linux" I found some relevant but not
upto date articles.

http://www.linux.com/archive/feature/146599
http://www.linuxforums.org/articles/linux-performance-tuning_107.html

By the way I found something funny with your "lock_stat" gzip file. It
had the following warning.

"lock_stat version 0.3
*WARNING* lock debugging disabled!! - possibly due to a lockdep warning=
"

Also I think you could run dmesg to see the actvity for some clarity.

On Sun, Jun 20, 2010 at 9:13 PM, Maksym Parkachov <lazy.gopher@gmail.co=
m> wrote:
> Folks,
>
> it's me again with beagleboard RT problem.
>
> I recompiled the kernel and got some statistics on locks, but I'm not
> sure how to interpret it. =A0Searching on google didn't help, probabl=
y,
> not asking right question.
>
> Here are stats from /proc after running cyclictest.
>
> If you could take a look at it, it would be great.
>
> Thanks,
> Maksym.
>
> On 15 June 2010 09:34, Maksym Parkachov <lazy.gopher@gmail.com> wrote=
:
>> Hi folks,
>>
>> thanks for all suggestions.
>> I'll try with lock validation and see if I could come with more deta=
ils.
>>
>> Thanks,
>> Maksym.
>>
>> On 14 June 2010 13:27, Sven-Thorsten Dietrich
>> <thebigcorporation@gmail.com> wrote:
>>> On Mon, 2010-06-14 at 13:05 +0200, John Kacur wrote:
>>>>
>>>> On Mon, 14 Jun 2010, Sujit K M wrote:
>>>>
>>>> > > CONFIG_PREEMPT_RCU=3Dy
>>> %<
>>>> His problem is not with the config.
>>>> --
>>>
>>> Nope - the config is just fine.
>>>
>>> Turn on the lock validator and
>>> recompile the Kernel.
>>>
>>> Then repeat the test that produced the latency spike.
>>>
>>> If that doesn't produce any locking issues,
>>> turn on latency tracing and repeat.
>>>
>>>> To unsubscribe from this list: send the line "unsubscribe linux-rt=
-users" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>
>>>
>>>
>>
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
