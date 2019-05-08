Return-Path: <SRS0=Jzjp=TI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E5DC04A6B
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 May 2019 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355ED216C4
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 May 2019 20:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB6GCoug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfEHU5j (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 May 2019 16:57:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43087 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEHU5j (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 May 2019 16:57:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id j9so200040oie.10
        for <linux-rt-users@vger.kernel.org>; Wed, 08 May 2019 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fTGPNEcm5ptHTZ+ikXsx8CaEzTqmMSubfbQEKuYbUFc=;
        b=kB6GCougR1rXshfQnbquWjp+TAxJPRzKLhAec/v+eIZ5+OF9eH0UiUkQytxXMnyibi
         PBWLCkDXPiFvAXDrLcNbkjYHK6suTsLnJ2Y3Tv2pT2cpGdECYHI7fAjvs9Wnzh7F8cZi
         7tgF05FlOhfPIbKprjSpf0u9o0Sx9M7TDJKIvdZO1PPbCetRJRedYSOtRV00N6Jl0Vot
         +trOCd5Y7fD8iGzud08W3jcDYbcDHa88uy6rjhEC8KLnfdV6w0STlECXiXSipMmTZ+T8
         YJmmu7as+TSjRMJmQWuHzHXwVXhP/3FJuz7TiREt1nVtZl8uSm+UV9fSeERWXwVU1wGL
         1N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fTGPNEcm5ptHTZ+ikXsx8CaEzTqmMSubfbQEKuYbUFc=;
        b=PgB5GiDqWmIuTXDl7X5r1iCJC1DBeqbUUPhPTlBDe4rJGZcupab35asBkv4OLr6R4m
         TjK/XPozmmekZSQYT6N4GpOX+5MMtzOhamJrPv+zu5K/APEh2W4H2ObH90mphQauRS1G
         162uX4uMgIyZ794nEp/OtnBb7G8a4RzVGG7n7Txlx3mRznGrT0uqSpjj2eyGjfjIxrA1
         kW3iX2uVZeewAiw7tu1IN2GuKbG8URnQ7/3oxYYRgxuAV5INfTpSsuEh3beW/USw0Gst
         IX/dtodGEps8HLXr8uj34PG/T9qhA7osvPUU36o16wnAXFAO5wf1LsLGvQSQnad7EclZ
         F1Vg==
X-Gm-Message-State: APjAAAVSX0xLUbpiVPiGQhhpRsagnWK1mYuXPgfLrBb6Oga4AwhZqv32
        iywAWMutJwyRV2pj8F5mXQ==
X-Google-Smtp-Source: APXvYqytsHfpq9P/6VVcHPGhJ/X25+6It3tHJMjmWaekaa7PhjpXCD/XJUXudt8G6ospF0eUmdu1Ug==
X-Received: by 2002:a05:6808:1d3:: with SMTP id x19mr3803416oic.9.1557349058591;
        Wed, 08 May 2019 13:57:38 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id p4sm4950236oti.70.2019.05.08.13.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 13:57:37 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 008A718191B;
        Wed,  8 May 2019 20:57:36 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 752763026DE; Wed,  8 May 2019 15:57:36 -0500 (CDT)
From:   minyard@acm.org
To:     linux-rt-users@vger.kernel.org
Cc:     minyard@acm.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2] Fix a lockup in wait_for_completion() and friends
Date:   Wed,  8 May 2019 15:57:28 -0500
Message-Id: <20190508205728.25557-1-minyard@acm.org>
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

Fix it by adding/removing the thread to/from the wait queue inside
the do loop.

Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I sent the wrong version of this, I had spotted this before but didn't
fix it here.  Adding the thread to the wait queue needs to come after
the signal check.  Sorry about the noise.

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

