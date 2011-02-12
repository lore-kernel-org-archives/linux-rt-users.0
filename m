From: Friedrich Schick <Friedrich.Schick@web.de>
Subject: Re: General question, sem_post does not result in preempt?
Date: Sat, 12 Feb 2011 13:52:02 +0100
Message-ID: <AANLkTi=jJZPDtz4bVNE3eTUOPJ0KdS0QnMrfG5WaA9h5@mail.gmail.com>
References: <AANLkTi=wk7kWShHWRrmgZb2SugwEsp4rxCPk7WBNOtgE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46620 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1BLMwC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Feb 2011 07:52:02 -0500
Received: by qwa26 with SMTP id 26so2160945qwa.19
        for <linux-rt-users@vger.kernel.org>; Sat, 12 Feb 2011 04:52:02 -0800 (PST)
In-Reply-To: <AANLkTi=wk7kWShHWRrmgZb2SugwEsp4rxCPk7WBNOtgE@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello again,

I missed a call to "pthread_attr_setinheritsched(&attr,
PTHREAD_EXPLICIT_SCHED)".

Best regards,

Friedrich Schick

> Hello,
>
> does sem_post wake up another thread and preempt the current thread if
> the other thread has a higher priority than the current one?
>
> thread A : prio 10
> thread B : prio 20
>
> thread B : wait (sem)
> thread A : running
> thread A : post (sem)
> thread B : now running?
>
> I have written an example and it seems, that thread B will not preempt thread A.
>
> Best regards
>
> Friedrich Schick
>
