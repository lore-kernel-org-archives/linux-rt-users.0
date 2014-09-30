From: Armin Steinhoff <armin@steinhoff.de>
Subject: Operation not permitted / pthread_setschedparam
Date: Tue, 30 Sep 2014 12:40:40 +0200
Message-ID: <542A88A8.7060800@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58960 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbaI3Kkm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Sep 2014 06:40:42 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi,

a "pthread_setschedparam" call of the code below terminates with an
errno == 1  ... means "Operation not permitted"

    instance_l.fStopThread = FALSE;
    if (pthread_create(&instance_l.threadId, NULL, eventThread,
(void*)&instance_l) != 0)
        goto Exit;

    schedParam.__sched_priority = KERNEL_EVENT_THREAD_PRIORITY;
    if (pthread_setschedparam(instance_l.threadId, SCHED_FIFO,
&schedParam) != 0)
    {
        DEBUG_LVL_ERROR_TRACE("%s(): couldn't set thread scheduling
parameters! %d\n", __func__, errno);
    }

I'm using a PREEMPT_RT kernel 3.4.0-rc7-rt7-2.16  for SuSE 12.2
Milestone 2 (3.4.11-2.16).

KERNEL_EVENT_THREAD_PRIORITY is 55!

How to solve that problem ?

Best Regards

--Armin



