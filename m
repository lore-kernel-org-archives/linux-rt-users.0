From: Daniel Kasak <d.j.kasak.dk@gmail.com>
Subject: Re: btrfs and linux-rt
Date: Sat, 14 Mar 2015 17:52:55 +1100
Message-ID: <CAF73Y=ROMtF_4F-Gfq=jgTv6u=+NzTo+Nw5gU=B_w=z4iKra6Q@mail.gmail.com>
References: <CAF73Y=Qfsw=Yre6d_kP7Vmn+Ln1L4viBVRPksdomdGKVzDu+6Q@mail.gmail.com>
	<20150313113832.GE5592@linutronix.de>
	<20150313211409.GA29519@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36638 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbCNGw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Mar 2015 02:52:56 -0400
Received: by lamx15 with SMTP id x15so5299794lam.3
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Mar 2015 23:52:55 -0700 (PDT)
In-Reply-To: <20150313211409.GA29519@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Interesting.

Nah I wasn't doing anything special with btrfs. I'll try again with a
3.18 kernel and see if it's magically resolved :)

Dan

On Sat, Mar 14, 2015 at 8:14 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Sebastian Andrzej Siewior | 2015-03-13 12:38:32 [+0100]:
>
>>I remember some people complained about btrfs. I then bootet a kvm
>>machine with btrfs as rootfs and it worked fine=E2=80=A6 Are you usin=
g some
>>"special" btrfs features or is this just a plain install?
>
> Okay. Among other things I manged to install fc21 on btrfs and it
> booted (well systemd complain about missing things and did not want t=
o
> continue but I got a shell and could login which means btrfs got
> mounted).
>
>>>Thanks :)
>>>
>>>Dan
>
> Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
