From: Friedrich Schick <Friedrich.Schick@web.de>
Subject: General question, sem_post does not result in preempt?
Date: Sat, 12 Feb 2011 13:42:32 +0100
Message-ID: <AANLkTi=wk7kWShHWRrmgZb2SugwEsp4rxCPk7WBNOtgE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63104 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab1BLMmd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Feb 2011 07:42:33 -0500
Received: by qyj19 with SMTP id 19so328048qyj.19
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Feb 2011 04:42:32 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

does sem_post wake up another thread and preempt the current thread if
the other thread has a higher priority than the current one?

thread A : prio 10
thread B : prio 20

thread B : wait (sem)
thread A : running
thread A : post (sem)
thread B : now running?

I have written an example and it seems, that thread B will not preempt thread A.

Best regards

Friedrich Schick
