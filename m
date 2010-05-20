From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after
	console_init
Date: Thu, 20 May 2010 15:02:10 +0530
Message-ID: <AANLkTil18TnOR9D-dSFsSFA74Q4UFnldrGLhG1H4jwhf@mail.gmail.com>
References: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com>
	 <AANLkTinClrTDoXH4NPP2-SgSYH24ZTnqsop88aocdg4R@mail.gmail.com>
	 <alpine.LFD.2.00.1005182143100.3368@localhost.localdomain>
	 <201005201233.56877@zigzag.lvk.cs.msu.su>
	 <AANLkTilEbFndi-rPczi6OBxeU8p87gOz4yfveEsyHqcE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f171.google.com ([209.85.221.171]:34126 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943Ab0ETJcM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 May 2010 05:32:12 -0400
In-Reply-To: <AANLkTilEbFndi-rPczi6OBxeU8p87gOz4yfveEsyHqcE@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry does not help as it is very old and does not seem to provide
information regarding
Real Time Linux. But the section  for

setserial -g /dev/ttyS[01]

and

/etc/inittab modifications are pointer to the changes required for
Real Timliness.

The problem is that baud rate of the COM/TTY port may require some modi=
fication.
I Think you will need to have an Critical Section for the Driver to
timeout in sync with
the baud rate.

Hope what I have said makes sense.


On Thu, May 20, 2010 at 2:55 PM, Sujit K M <sjt.kar@gmail.com> wrote:
> http://www.vanemery.com/Linux/Serial/serial-console.html
>
> Could this be of help.
>
> On Thu, May 20, 2010 at 2:03 PM, Nikita V. Youshchenko <yoush@cs.msu.=
su> wrote:
>>> > I could not get dmesg output to console/serial and
>>> > klogd(/var/log/messages) anymore with 2.6.33-rt17 _after_ the ker=
nel
>>> > boot is done(on non-RT kernel it works fine). I made below change=
s it
>>> > starts to work again, however I'm unsure how safe the change is.
>>> > Please advise.
>>>
>>> Well, obviously it's unsafe if you remove safety checks. And if you
>>> care to look at the changelog of kernel/printk.c you'll find out wh=
y.
>>
>> Hmm... did a quick look and could not find anything related there.
>> Could you please give a pointer?
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> -- Sujit K M
>
> blog(http://kmsujit.blogspot.com/)
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
