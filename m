From: "Braud Caroline" <Caroline.Braud@univ-lille1.fr>
Subject: Re: problem ethernet board
Date: Tue, 17 Feb 2015 16:46:24 +0100
Message-ID: <7e1c-54e36280-57-5912f900@117110735>
References: <20150217141210.GQ26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp02.univ-lille1.fr ([193.49.225.20]:45458 "EHLO
	smtp02.univ-lille1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbbBQP6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 10:58:35 -0500
in-reply-to: <20150217141210.GQ26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

> 
> >Hello,
> Hi,
> 
> >I have installed RT kernel from:
> > http://pengutronix.de/software/linux-rt/debian_en.html
> >
> >But I have the same problem as this guy (ethernet controller is not working): 
> >http://www.spinics.net/lists/linux-rt-users/msg07478.html
> >
> >except that I'm not using an amd architecture but an Intel one ...
> >
> >Any idea on how and/or where to get the good headers ?
> Are the hints in the thread helping? I would guess the kernel is old and
> does not support the network card yet.

No. I will try to install ubuntu-14.04-desktop-i386.iso with linux-3.14.25.tar.gz
and the patch: patch-3.14.25-rt22.patch.xz

And let you know ...

Thanks,
CB
