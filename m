Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE66C04AB1
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12ED2173C
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 19:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxvvo8O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEITdc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 15:33:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46657 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEITdb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 15:33:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id v17so3352541otp.13;
        Thu, 09 May 2019 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=V8Sbu+nF/y2l4Be322vESGiIAHuI7U+n53RdchBNOMc=;
        b=jxvvo8O1D37pcBNcnmIwAgX5PxsMLZ3bfVmhhTNVXb7jw4iY0VVt2JdGWD/XQT7qgl
         bFL1z8hbSryiztooY0XTvvbvOfbiTkwdJ74FWiiyIWWBoxKnSLzphl2nOKK8EhTe4DkV
         4X3Rn6WKRQ+ZBGQw0tn0TYRHlNOXyTwy/mvnugG1EaYg9cgsKjOuRsXtWRsxJQYzXV6R
         vyqgtziAyNqH84LyobQLNsgr1rVMCjUigJUvLTF4U377qZHMzsE5+jh4IJjzLX7GyBWS
         RjRjXBQQs9D6IVKCP4Z1yZKSviCZvR1L1yiFmODzWwV4LNlqQak9vO7kiNtXxWybc4Oy
         waOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=V8Sbu+nF/y2l4Be322vESGiIAHuI7U+n53RdchBNOMc=;
        b=l1v5vMVluVGsYQ07HO1RNKz3HIcN0at6XLzhY2xWlGqKJqXzc7vLyHt8IhZixba0wZ
         KQYybo/rMmuH3d1CokhCM0cPNTZdC7MyxodjppmH57mpPCVoIoPskxR63CMNC7uqov8P
         kvbpPUmUNjRfW5EXU1nLj7yrGXgk0tR/dorcYe5dhDMDmrKQiAg/0g0JQHeioOe18wHW
         C2H2Izb3GdUmWHhbxQaal+WzcnXwg4A6Xh0U/JWjBNDzz6DFR3I71PkA8aGOJhOZfCBX
         O8xqqu7ZsSJVR26oShqA5JLNjNmar5M5y0aK+49FpeH6lul7GIagwZjexEVb2LjX+DSP
         gINQ==
X-Gm-Message-State: APjAAAWfbikXqqn86keNBYJXID71f6kLZEggsmOQNQeGzRQVAyMIM/LX
        COpVNDgWhPOHjkJ2Lwh4pg==
X-Google-Smtp-Source: APXvYqxIH8KO3OYJTFXo7+q5gnhUmFxYPRIOnN6qOpzXNLGA82xQ9joj4mnIWntbnEL9u+YIAy+7Dw==
X-Received: by 2002:a9d:7dd8:: with SMTP id k24mr658569otn.170.1557430410914;
        Thu, 09 May 2019 12:33:30 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id r65sm1216184oif.47.2019.05.09.12.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 12:33:30 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id CED7318190F;
        Thu,  9 May 2019 19:33:29 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 40D39300158; Thu,  9 May 2019 14:33:29 -0500 (CDT)
From:   minyard@acm.org
To:     linux-rt-users@vger.kernel.org
Cc:     minyard@acm.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Date:   Thu,  9 May 2019 14:33:20 -0500
Message-Id: <20190509193320.21105-1-minyard@acm.org>
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

Fix it by adding the thread to the wait queue inside the do loop.
The design of swait detects if it is already in the list and doesn't
do the list add again.

Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
Changes since v1:
* Only move __prepare_to_swait() into the loop.  __prepare_to_swait()
  handles if called when already in the list, and of course
  __finish_swait() handles if the item is not queued on the
  list.

 kernel/sched/completion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 755a58084978..49c14137988e 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -72,12 +72,12 @@ do_wait_for_common(struct completion *x,
 	if (!x->done) {
 		DECLARE_SWAITQUEUE(wait);
 
-		__prepare_to_swait(&x->wait, &wait);
 		do {
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
 			}
+			__prepare_to_swait(&x->wait, &wait);
 			__set_current_state(state);
 			raw_spin_unlock_irq(&x->wait.lock);
 			timeout = action(timeout);
-- 
2.17.1

