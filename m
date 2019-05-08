Return-Path: <SRS0=Jzjp=TI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C3BC04A6B
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 May 2019 20:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B982175B
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 May 2019 20:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOjgzImF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfEHU2I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 May 2019 16:28:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42686 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfEHU2I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 May 2019 16:28:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id k9so138984oig.9
        for <linux-rt-users@vger.kernel.org>; Wed, 08 May 2019 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Dh2MDgTWxLL+qxBu1xrW/CPw9MRIRx12jl+cV4Ss3LI=;
        b=lOjgzImFaBveo96UpTXz4m/ONpWBVYUKBsKpp/OFiu1+tK8g0tem/KGiTgRLqeDHui
         hNria9hkYSacophUlmyITtRdl5c8RG/h9ncMPasI4Qpqp8Ey/oItUvS9B9j8CgEQvtz/
         6/vMlxHF8/Uza0PXAI79VTmd7n6ccNcc2OBEUqQYYA9Rx4w+uDUkw3Yg+lLuu1FzW5i2
         TGNsSRNr410jCOPrZxJ4ChTUO7NgZexT6nDMXN4J8SDhi7yBlKSfPYKav5DoCES8JnwI
         KUTeNQRoohtcWc0dDrg71DM+Remqs+y0HT5LUFN+iJIM+cL2Azr3WgrhwkBNV9LeiUuj
         xRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Dh2MDgTWxLL+qxBu1xrW/CPw9MRIRx12jl+cV4Ss3LI=;
        b=bvi/g1YAmU6ydiIyumn2OJF/EWsnHwUFhEyO9njoVA3BwMQHbT23htdWRykTfhRXZ5
         0VbLBLbrstng6pJeH/63qSmF3u0DYE5ASpO3kLJszF2L2rfXWrdg0pzLyeb+dYaUZAki
         vOzqtlA+VbdCcyelBPvZhPGEhvZfqIWa4bGKNca56ilfudInD6d48Ln6aeZ7/jLYZHHM
         CtLnvv24wV0UcMXoRvya6uYsRwUA0wEsJ8EFTFEVRN7032MWNrNbTmY5ftvjKKKhpCTZ
         tf8RD0xioCah0zBuKECCgAMHYQISq7hor9OnxoDZB8cYy3RyirALtJUcq2veGRJKR3ii
         AqLA==
X-Gm-Message-State: APjAAAXtbh+t4MqJRd5i5kL+2+DcKApvru6SaLsSv+cCZX3MVGg2WMin
        OYFcqLgydQeqIDtCeWKMfZk8BhGSgA==
X-Google-Smtp-Source: APXvYqzzx3R8/wp6ZAOUWbj+4+B/tlh0JIcVnhKn+FigPDRX5dqm5c4wOkFj5e4MdumNH4IXrwnWKw==
X-Received: by 2002:aca:4942:: with SMTP id w63mr3557423oia.33.1557347287450;
        Wed, 08 May 2019 13:28:07 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 34sm4707120otd.4.2019.05.08.13.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 13:28:06 -0700 (PDT)
Received: from t430.minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPA id 6507518191B;
        Wed,  8 May 2019 20:28:06 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id BFF1B3026DE; Wed,  8 May 2019 15:28:05 -0500 (CDT)
From:   minyard@acm.org
To:     linux-rt-users@vger.kernel.org
Cc:     minyard@acm.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] Fix a lockup in wait_for_completion() and friends
Date:   Wed,  8 May 2019 15:27:59 -0500
Message-Id: <20190508202759.13842-1-minyard@acm.org>
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
is woken up with swake_up_locked(), that function will delete the
entry from the wait queue.  If that happens and another thread sneaks
in and decrements the done count in the completion to zero, the
loop will go around again, but the thread will no longer be in the
wait queue, so there is no way to wake it up.

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
customer reports of failures.

The feature and test are in a public tree if someone wants to try to
reproduce this.  But hopefully this is pretty obvious with the explaination.

Also, you could put the DECLARE_SWAITQUEUE() outside the loop, I think,
but maybe it's cleaner or safer to declare it in the loop?  If someone
cares I can test it that way.

-corey

 kernel/sched/completion.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 755a58084978..4cde33cf8b28 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -70,10 +70,10 @@ do_wait_for_common(struct completion *x,
 		   long (*action)(long), long timeout, int state)
 {
 	if (!x->done) {
-		DECLARE_SWAITQUEUE(wait);
-
-		__prepare_to_swait(&x->wait, &wait);
 		do {
+			DECLARE_SWAITQUEUE(wait);
+
+			__prepare_to_swait(&x->wait, &wait);
 			if (signal_pending_state(state, current)) {
 				timeout = -ERESTARTSYS;
 				break;
@@ -82,8 +82,8 @@ do_wait_for_common(struct completion *x,
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

