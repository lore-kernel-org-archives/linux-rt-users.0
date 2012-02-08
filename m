From: Sankara Muthukrishnan <sankara.m@gmail.com>
Subject: Suggesting to include timerfd patch
Date: Tue, 7 Feb 2012 22:56:41 -0600
Message-ID: <CAFQPvXf7JS98_FH_nwHsEa0WX7H6QT8vBAJwo2Yt-r--aO6mcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33692 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab2BHE4m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Feb 2012 23:56:42 -0500
Received: by daed14 with SMTP id d14so166064dae.19
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Feb 2012 20:56:41 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steven,

Could you please include the patch that Thomas suggested for the
timerfd hangs in the email thread (link below), if Thomas is fine with
the patch? I did verify that that patch fixed the hangs that I saw on
a panda board (ARM Cortex A9 dual core).

http://marc.info/?l=linux-rt-users&m=132753755612168&w=2

Thanks,
Sankara
