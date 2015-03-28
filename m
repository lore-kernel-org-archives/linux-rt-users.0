From: Daniel Kasak <d.j.kasak.dk@gmail.com>
Subject: Re: btrfs and linux-rt
Date: Sun, 29 Mar 2015 10:55:09 +1100
Message-ID: <CAF73Y=SQvfHGvNJ_yhQ4Tbkyiq5ZSTUhOTMLTe-6_Js2orjwPw@mail.gmail.com>
References: <CAF73Y=Qfsw=Yre6d_kP7Vmn+Ln1L4viBVRPksdomdGKVzDu+6Q@mail.gmail.com>
	<20150313113832.GE5592@linutronix.de>
	<20150313211409.GA29519@linutronix.de>
	<CAF73Y=RDjYCZK_YbLy9KCvNz_x9dtjZV=Q0uo-V9SWZ27TQBCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35614 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbC1XzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Mar 2015 19:55:10 -0400
Received: by lbdc10 with SMTP id c10so31492004lbd.2
        for <linux-rt-users@vger.kernel.org>; Sat, 28 Mar 2015 16:55:09 -0700 (PDT)
In-Reply-To: <CAF73Y=RDjYCZK_YbLy9KCvNz_x9dtjZV=Q0uo-V9SWZ27TQBCA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've tested with 3.18.9-rt5, and I'm happy to report that this kernel
works fine for me :)

Dan

On Sat, Mar 14, 2015 at 5:51 PM, Daniel Kasak <d.j.kasak.dk@gmail.com> =
wrote:
> Interesting.
>
> Nah I wasn't doing anything special with btrfs. I'll try again with a=
 3.18
> kernel and see if it's magically resolved :)
>
> Dan
>
> On Sat, Mar 14, 2015 at 8:14 AM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> * Sebastian Andrzej Siewior | 2015-03-13 12:38:32 [+0100]:
>>
>> >I remember some people complained about btrfs. I then bootet a kvm
>> >machine with btrfs as rootfs and it worked fine=E2=80=A6 Are you us=
ing some
>> >"special" btrfs features or is this just a plain install?
>>
>> Okay. Among other things I manged to install fc21 on btrfs and it
>> booted (well systemd complain about missing things and did not want =
to
>> continue but I got a shell and could login which means btrfs got
>> mounted).
>>
>> >>Thanks :)
>> >>
>> >>Dan
>>
>> Sebastian
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
