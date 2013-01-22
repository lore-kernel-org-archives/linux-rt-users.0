From: Jacky Lam <lamshuyin@gmail.com>
Subject: Protection of critical section in PREEMPT_RT
Date: Tue, 22 Jan 2013 11:29:44 +0800
Message-ID: <CAHX1yNTSObcxNrvsBnPw8QzUWTb4zzs_faZZ1bbGU1L8xzgpsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:61552 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab3AVD3o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 22:29:44 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so10897536iec.41
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jan 2013 19:29:44 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello all,

It is my first time to use PREEMPT_RT patch. I have a kernel driver
needed to do a indirect register access to a hardware interface. In
past, I use spinlock to protect those code. After turning on
PREEMPT_RT, the driver doesn't work anymore.

I know spinlock is now preemptible, but how can I protect a "really"
critical section in PREEMPT_RT? If it is a bad design, could give me
some tutorial/readings on how to modify my driver?

Thanks very much.

Yours,
Jacky
