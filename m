From: Maksym Parkachov <lazy.gopher@gmail.com>
Subject: Re: beagleboard RT problem
Date: Tue, 15 Jun 2010 09:34:29 +0200
Message-ID: <AANLkTimWSQfXQGedfHHLAbabPrRnUaWlPCMUEC3I9_G0@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	<alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
	<1276514850.26993.4.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46596 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab0FOHeb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Jun 2010 03:34:31 -0400
Received: by bwz7 with SMTP id 7so2489273bwz.19
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Jun 2010 00:34:29 -0700 (PDT)
In-Reply-To: <1276514850.26993.4.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi folks,

thanks for all suggestions.
I'll try with lock validation and see if I could come with more details=
=2E

Thanks,
Maksym.

On 14 June 2010 13:27, Sven-Thorsten Dietrich
<thebigcorporation@gmail.com> wrote:
> On Mon, 2010-06-14 at 13:05 +0200, John Kacur wrote:
>>
>> On Mon, 14 Jun 2010, Sujit K M wrote:
>>
>> > > CONFIG_PREEMPT_RCU=3Dy
> %<
>> His problem is not with the config.
>> --
>
> Nope - the config is just fine.
>
> Turn on the lock validator and
> recompile the Kernel.
>
> Then repeat the test that produced the latency spike.
>
> If that doesn't produce any locking issues,
> turn on latency tracing and repeat.
>
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
