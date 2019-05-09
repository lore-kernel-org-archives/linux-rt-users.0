Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC24C04AB2
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C33E2177B
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 18:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spnNZ30h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEISC0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 14:02:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46267 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISCZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 14:02:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id v17so3092116otp.13;
        Thu, 09 May 2019 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=9Kix0hRwqeGvHkSMR0p3zhMGn8QRE0CDFVhyJ6yQh/4=;
        b=spnNZ30hG0eWa8gfeA/dtxgaPaoTkUW6GHMcpbg1dMuGFAkagEfbkKtuhcdHNI0GNM
         HdBhoqo1enNfyYN0oU09MriJzmBnyqpsGtCnWn7EEU2aM43mxkaNIoIwUMwzP77IZ2kV
         nVu9BvJLh5XjGlXPGcILXxUqInvDDuPnisIvWPGAxkUxzcVUO11nNno8B8KPeZAUfW7z
         oJ17XojYVX5rnsLs6sLVGsxrAOe+eXGqZVsnEBBpw58oV5V5FUutt9nziniDWVS+YSHS
         spUjjYhI2ZtwB34y4IFjeFYGBM5we7gZaSu+M0ChWvkJQeE7/BE1IemP/xnEpgF58HVD
         jwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=9Kix0hRwqeGvHkSMR0p3zhMGn8QRE0CDFVhyJ6yQh/4=;
        b=Kp8l6AOAYRyV535IuMgyCyXVewtBrqScv79dc1UXJeCPgRefBv1CSt5u/urd2Gg3ie
         2XkJf4CurpS0vUHF/f1fobWpxEVKU2b6Qkf5z3YMxUrqMi0vv9aQoBWAj4mnST6MjrPl
         W2hrZtBWq6PjnGQdfYH3dWG4fuAa3ffF+wcZpfSAKWau4qMZwmPLWM1yd2bLAxvVRtAM
         hhYYO3rBb8eq5T5xiDIbVmHOiDElw7s1rDGm1IqjUGNl+uMi7Ztv6fzIIVbjsdrkJvzr
         lc2kkMiZ5LOnA37k4UtzDFk7lVMzYtvlXn/efextIMQ8E5MqRdJZUiRnITOx28AUTflV
         fUnw==
X-Gm-Message-State: APjAAAXWNVdM2V3/7/286TYEhP36OPZ8q5NkDGqeH7f2/yZ0bfTuG/jq
        LMx2Tx58tzro1ElCDuW7iw==
X-Google-Smtp-Source: APXvYqxA8xFqga/Mq4WQpY6+ycMiSTPqm0BpXBfDG5VvsQFurYbfGJHwizWJ2fUYZGei3fAEDIE/AA==
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr3508745otk.47.1557424944331;
        Thu, 09 May 2019 11:02:24 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id e6sm1152544oih.51.2019.05.09.11.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 11:02:23 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 084B518190F;
        Thu,  9 May 2019 18:02:23 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 921B2300158; Thu,  9 May 2019 13:02:22 -0500 (CDT)
From:   minyard@acm.org
To:     linux-rt-users@vger.kernel.org
Cc:     minyard@acm.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH RT] Fix a lockup in wait_for_completion() and friends
Date:   Thu,  9 May 2019 13:02:11 -0500
Message-Id: <20190509180211.14893-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

The function call do_wait_for_common() has a race condition that
can result in lockups waiting for completions.  Adding the thread
to (and removing the thread from) the wait queue for the completion
is done outside the do loop in that function.  However, if the thread
is woken up, the swake_up_locked() function will delete the entry
from the wait queue.  If that happens and another thread sneaks
in and decrements the done count in the completion to zero, the
loop will go around again, but the thread will no longer be in the
wait queue, so there is no way to wake it up.

Visually, here's a diagram from Sebastian Andrzej Siewior:
  T0                    T1                       T2
  wait_for_completion()
   do_wait_for_common()
    __prepare_to_swait()
     schedule()
                        complete()
                         x->done++ (0 -> 1)
                         raw_spin_lock_irqsave()
                         swake_up_locked()       wait_for_completion()
                          wake_up_process(T0)
                          list_del_init()
                         raw_spin_unlock_irqrestore()
                                                  raw_spin_lock_irq(&x->wait.lock)
  raw_spin_lock_irq(&x->wait.lock)                x->done != UINT_MAX, 1 -> 0
                                                  raw_spin_unlock_irq(&x->wait.lock)
                                                  return 1
   while (!x->done && timeout),
   continue loop, not enqueued
   on &x->wait

Basically, the problem is that the original wait queues used in
completions did not remove the item from the queue in the wakeup
function, but swake_up_locked() does.

Fix it by adding/removing the thread to/from the wait queue inside
the do loop.

Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
This looks like a fairly serious bug, I guess, but I've never seen a
report on it before.

I found it because I have an out-of-tree feature (hopefully in tree some
day) that takes a core dump of a running process without killing it.  It
makes extensive use of completions, and the test code is fairly brutal.
It didn't lock up on stock 4.19, but failed with the RT patches applied.

The funny thing is, I've never seen this test code fail before on earlier
releases, but it locks up pretty reliably on 4.19-rt.  It looks like this
bug goes back to at least the 4.4-rt kernel.  But we haven't received any
customer reports of failures.  I'm guessing that almost all completion
users have a single waiter, so you would never see this.

The feature and test are in a public tree if someone wants to try to
reproduce this.  But hopefully this is pretty obvious with the explaination.

Also, you could put the DECLARE_SWAITQUEUE() outside the loop, I think,
but maybe it's cleaner or safer to declare it in the loop?  If someone
cares I can test it that way.

-corey

 kernel/sched/completion.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 755a58084978..4f9b4cc0c95a 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -70,20 +70,20 @@ do_wait_for_common(struct completion *x,
 		   long (*action)(long), long timeout, int state)
 {
 	if (!x->done) {
-		DECLARE_SWAITQUEUE(wait);
-
-		__prepare_to_swait(&x->wait, &wait);
 		do {
+			DECLARE_SWAITQUEUE(wait);
+
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
 			raw_spin_lock_irq(&x->wait.lock);
+			__finish_swait(&x->wait, &wait);
 		} while (!x->done && timeout);
-		__finish_swait(&x->wait, &wait);
 		if (!x->done)
 			return timeout;
 	}
-- 
2.17.1

