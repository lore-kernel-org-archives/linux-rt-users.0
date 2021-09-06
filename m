Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D807C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Sep 2021 16:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D1F60FED
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Sep 2021 16:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbhIFQUY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:20:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhIFQUX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Sep 2021 12:20:23 -0400
Date:   Mon, 6 Sep 2021 18:19:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630945157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCPmx4XgMnc0zqf24h9hsiXdPiG67mztW/w8T/Es+cI=;
        b=Kd/Vm75SAcYjyQoplnlBqz2V3lDApOrrQMFmEsPpj3kR32c8XJEEXwJNBdihPPhrYJMZsN
        Wgy8n2LqGu8i0j0RD8AtIpQcwXW754osnGc+Dq9ENQ79uPdAxXlpx8yck9wBmG0pE/jzga
        iMtdGTbxo1X+fYNdosJOY9PyS9L+JtpAczas4rlSMuwJ/66TSOCbqJ+atp+7E3Uai6SEzR
        ym47jV3Ws4VhYI9oECAHfxhYOEuBkDk8UYj2v8ORBfjfEaraNfs342yBl5VxY0Mq9NqFzC
        9i/LrlngQYxYOK6zchwzKc+ErRWCkbGD4xrnjXMgARhljWfGJVEetqk/DKVbUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630945157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCPmx4XgMnc0zqf24h9hsiXdPiG67mztW/w8T/Es+cI=;
        b=PhoIqlb5tlMIBJLUAMo3w9BG15+G0HV6JsG4Axn5jMy3BpSJTh4jINTry4LxpNddfUjgvj
        crPdXnj2obBTq+CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RT] locking: Drop might_resched() from
 might_sleep_no_state_check()
Message-ID: <20210906161916.yvxhkjkwxgtiwk5g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

might_sleep_no_state_check() serves the same purpose as might_sleep()
except it is used before sleeping locks are acquired and therefore does
not check task_struct::state because the state is preserved.

That state is preserved in the locking slow path so we must not schedule
at the begin of the locking function because the state will be lost and
not preserved at that time.

Remove might_resched() from might_sleep_no_state_check() to avoid losing the
state before it is preserved.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

After the locking rework, ___might_sleep() is used directly in
rt_spin_lock(), =E2=80=A6 so there is no might_sleep_no_state_check() macro
anymore.
This applies to all RT trees.

 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2cff7554395d1..6eb0ab994f4c5 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -222,7 +222,7 @@ extern void __cant_migrate(const char *file, int line);
 	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
=20
 # define might_sleep_no_state_check() \
-	do { ___might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { ___might_sleep(__FILE__, __LINE__, 0); } while (0)
=20
 /**
  * cant_sleep - annotation for functions that cannot sleep
--=20
2.33.0

