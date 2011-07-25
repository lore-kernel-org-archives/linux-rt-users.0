From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [ANNOUNCE] 3.0-rt2
Date: Mon, 25 Jul 2011 09:57:29 +0800
Message-ID: <CAM2zO=BChj0-zKgQTC7wia8Ou8wCVYR9U+yuF3DC4SvvQJtqkQ@mail.gmail.com>
References: <alpine.LFD.2.02.1107231706380.2702@ionos>
	<20110724010932.GA2133@zhy>
	<alpine.LFD.2.02.1107241204300.2702@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51120 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab1GYB5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 24 Jul 2011 21:57:30 -0400
In-Reply-To: <alpine.LFD.2.02.1107241204300.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jul 24, 2011 at 6:05 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> On Sun, 24 Jul 2011, Yong Zhang wrote:
>> [ 1244.912621] =C2=A0[<c15d151c>] rt_spin_lock+0x1c/0x40
>> [ 1244.912626] =C2=A0[<c111f763>] mem_cgroup_split_huge_fixup+0x43/0=
xd0
>
> Can you please disable CONFIG_TRANSPARENT_HUGEPAGE for now? That's no=
t
> easy to fix, but I put it on the todo list.

That's ok.
Will try 3.0-rt3 :)

Thanks,
Yong



--=20
Only stand for myself
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
