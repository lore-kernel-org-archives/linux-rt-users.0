From: =?ISO-8859-15?Q?Martin_D=E4umler?= <mdae@cs.tu-chemnitz.de>
Subject: Re: Priority Inheritance per se?
Date: Tue, 14 Sep 2010 13:12:13 +0200
Message-ID: <4C8F588D.2080308@cs.tu-chemnitz.de>
References: <4C89D4DF.9060109@cs.tu-chemnitz.de> <4C8F46B1.1010804@disco.unimib.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:48472 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab0INLMP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 07:12:15 -0400
Received: from adelaide.informatik.tu-chemnitz.de ([134.109.192.66])
	by jack.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <mdae@informatik.tu-chemnitz.de>)
	id 1OvTQs-0007kx-39
	for linux-rt-users@vger.kernel.org; Tue, 14 Sep 2010 13:12:14 +0200
In-Reply-To: <4C8F46B1.1010804@disco.unimib.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sergio Ruocco wrote:

> before really deciding for the use of PI, you may want to read what
> Victor Yodaiken had to say:
>
> http://www.yodaiken.com/papers-and-talks/
> Against priority inheritance, Victor Yodaiken. September 23, 2004
> http://www.yodaiken.com/papers/inherit.pdf
>
> Here is a general Linux RT workshop report, with some comments on PI:
> http://lwn.net/Articles/354690/


Hi Sergio,

thanks for that reading. I (hope to) know which drawbacks and
shortcomings priority inheritance has. Before I can make a
decision about using an RT_PREEMPT patched Linux, I want to
know if the RT_PREEMPT-patch introduces priority inheritance
automatically, that is, without using any locks?

=46or example (from my opening post):

Imagine a hypothetical case: a high RT-priority (60) task
triggers a blocking system call which triggers a device driver
whose ISR is a kernel thread with RT-priority 49. So, a medium
RT-priority (55) task is able block the high RT-priority task,
isn't it?


With kind regards,
Martin D=E4umler
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
