From: Remy Bohmer <linux@bohmer.net>
Subject: Re: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Fri, 11 May 2012 15:42:45 +0200
Message-ID: <CANqCtQ+HbGMUqJuZN-weX1CbK9ecTgfdenV4WgZiDQQ_ZAYSUA@mail.gmail.com>
References: <joemui$6v0$1@dough.gmane.org>
	<joepd0$e4f$1@dough.gmane.org>
	<4FAAEBF3.10907@netacquire.com>
	<joetve$hm5$1@dough.gmane.org>
	<CANqCtQJsr6xV9aU5LbXuOOtYTvcHT6113cy0+6smKBtZAdcRGA@mail.gmail.com>
	<20120510135320.GA9568@grante>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab2EKNmr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 May 2012 09:42:47 -0400
Received: by bkcji2 with SMTP id ji2so2248495bkc.19
        for <linux-rt-users@vger.kernel.org>; Fri, 11 May 2012 06:42:45 -0700 (PDT)
In-Reply-To: <20120510135320.GA9568@grante>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2012/5/10 Grant Edwards <grant.b.edwards@gmail.com>:
>> If the 20usec requirement is hard, you can also look at using an FIQ=
=2E
>
> Does the normal AT91 kernel not use FIQs at all? =A0If so, I might be
> able to dedicate the FIQ to this function and have it happen without
> the Linux kernel knowing about it (or affecting it). =A0Any
> communication between it and a normal user-task would have to be
> handled carefully...

No, the kernel does not use the FIQ at all.
It is free for you to use as you want.
Communication with the FIQ handler can be done using a queue based on
atomic instructions.

Kind regards,

Remy
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
