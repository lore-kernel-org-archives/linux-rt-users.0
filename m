From: =?ISO-8859-15?Q?Martin_D=E4umler?= <mdae@cs.tu-chemnitz.de>
Subject: Priority Inheritance per se?
Date: Fri, 10 Sep 2010 08:49:03 +0200
Message-ID: <4C89D4DF.9060109@cs.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:37367 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab0IJH30 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Sep 2010 03:29:26 -0400
Received: from adelaide.informatik.tu-chemnitz.de ([134.109.192.66])
	by jack.hrz.tu-chemnitz.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <mdae@informatik.tu-chemnitz.de>)
	id 1OtxPz-0006To-Ao
	for linux-rt-users@vger.kernel.org; Fri, 10 Sep 2010 08:49:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Hello,

our team develops a Linux-based embedded system to
realise a programmable logic controller. So we investigate
several possibilities to augment Linux real-time capabilities.
Naturally, the PREEMPT_RT-patch is interesting. I searched
the wiki, the mailing list archive, listened to Mr. Assmann's
talk at the Chemnitz Linux Days 2010 and read the corresponding
chapter in "Building Embedded Linux Systems" by Karim Yaghmour.
Nevertheless, I have a question to makes thinks clear once and
for all:

Does the priority inheritance mechanism work without using
special (Pthread-) mutexes in userspace? (As far as I understood,
it does not.)

Imagine a hypothetical case: a high RT-priority (60) task triggers
a synchronous/blocking system call which triggers a device driver
whose ISR is a kernel thread with RT-priority 49. So, a medium
RT-priority (55) task may block the high RT-priority task, doesn't
it?


With kind regards,
Martin Daeumler
