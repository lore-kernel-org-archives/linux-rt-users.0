From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: Deterministic behavior for TTY serial
Date: Thu, 3 May 2012 17:28:47 +0200
Message-ID: <CAMSQXEEnvpBoq7m5hMTtYObj4FsMAtUbpEaiftZ1CDmF56LZAQ@mail.gmail.com>
References: <CAMSQXEENByqSmK2bSxMngY2WuV86AAcX_LxTbA5JSOjT3ta_FA@mail.gmail.com>
	<20120419001407.GA24710@kroah.com>
	<CAMSQXEEkssPGWYgC4dkpKEhfrB4s8yOoxiNNVdRRX7r+b91EMQ@mail.gmail.com>
	<20120419154609.GA9263@kroah.com>
	<CAMSQXEEN=6M59CR3riNA5-kFFv7QAsn_g3PHi3A8P9mh3SfdeQ@mail.gmail.com>
	<CAMSQXEGb9moJbCQwwXgEq7H-HvaSiuS5JBL55jr0ZhEEeAmqzw@mail.gmail.com>
	<20120501160456.3b0b5e34@pyramind.ukuu.org.uk>
	<CAMSQXEHAyPOF6YghsYmqqyx+N0oMgn5E=znhgFyspMUnaH78ig@mail.gmail.com>
	<CAMSQXEHHOHeNYPJZT0b4s62T3uuNXSt9WucSrGOTfjXOU_guzg@mail.gmail.com>
	<CAMSQXEG+O86t10AF5gN875RoEHkMcGFQE_-G6TdeYVc4NJoBLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
	Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50753 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992Ab2ECP2x (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 11:28:53 -0400
In-Reply-To: <CAMSQXEG+O86t10AF5gN875RoEHkMcGFQE_-G6TdeYVc4NJoBLw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

>
> The PREEMPT_RT uses mutexes for "normal" spin locks that do not
> disable interrupts...
> I'll try to use raw spinlocks in this code section and for the tty flip buffer
> See if that can solve my problem.
>
> If you have other ideas... let me know!
>
> Regards,
> Ivo

I've changed some small things to the tty layer (see my other 3 RFC
patches I've send).
Performance increased with my loopback stress test:
- Old situation: average read call last for 50us, with peaks up to 230 us
- New situation: average read call still 50us, peak up to 60 us
- Write was stable in both situations: average of 90 us, peak up to 100 us

Only the very first read & write took extra time (128 us for read, 143
for write)
I'm still investigating that...

Feedback is very appreciated.

Regards,
Ivo Sieben
