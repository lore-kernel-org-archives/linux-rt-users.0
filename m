From: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: Hard real time in user space with preempt_rt patch
Date: Mon, 30 Apr 2012 15:18:26 +0200
Message-ID: <CA+gSDyShhShO=tVx=QwssFMUQ1gZK++P=X5L+iBt=fbxhqPeOA@mail.gmail.com>
References: <CAM1yFZ_MLVNK8xPGg5Ad3suQh_AR18k6coyDqX9EurCkh9j9pg@mail.gmail.com>
	<4F966AFC.7070803@cfl.rr.com>
	<CAF-VNaq3bkC=LCB-Emsx20xTm-Vm1v3kduC5MpyXQA_GS6SOhg@mail.gmail.com>
	<4F967574.8030104@cfl.rr.com>
	<BA425197-1889-4161-8726-860E30EC943A@thebigcorporation.com>
	<4F96E220.6010506@compro.net>
	<CAF-VNapqGkH62v6xh_KUcjQkpiaGu79-D10=1Ah5pbhuO+COuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markh@compro.net, linux-rt-users@vger.kernel.org
To: Lars Segerlund <lars.segerlund@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45232 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab2D3NS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Apr 2012 09:18:27 -0400
Received: by yhmm54 with SMTP id m54so1335064yhm.19
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Apr 2012 06:18:26 -0700 (PDT)
In-Reply-To: <CAF-VNapqGkH62v6xh_KUcjQkpiaGu79-D10=1Ah5pbhuO+COuw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 24, 2012 at 9:20 PM, Lars Segerlund
<lars.segerlund@gmail.com> wrote:
> =A0Hi , I'm the nasty person that pointed out that the rt-preempt
> patches DOES provide and strive to provide deterministic HARD realtim=
e
> for the linux kernel.
>
> =A0Hard realtime is as you pointed out bounded by being deterministic=
,
> so all talk about microseconds and relative latencies are not really
> relevant per your own definition.
>
> <a lot of other stuff cut>

I have seen these discussions before:
One camp equal hard real time with highly safety critical,
deterministic systems. The Linux kernel can of course never be that.
But Linux with preempt realtime is "hard realtime" in the sense
meeting deadlines are deterministic and testable. I.e. you can use it
as a platform for a system where not meeting a deadline is "bug" of
equal severity as say a segmentation fault: You can be as sure to meet
your deadlines if you have tested it in the lab as you can be sure not
to have any other kind of bug. And no, it is not mathematically
proven, and the kernel and your applications might have bugs still to
be discovered.

>
> =A0/ regards, Lars Segerlund.
>

Esben
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
