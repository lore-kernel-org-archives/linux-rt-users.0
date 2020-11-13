Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4BDC4742C
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBA022255
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Nov 2020 21:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXCgoK/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMVNJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:13:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKMVNJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Nov 2020 16:13:09 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA22A2224D;
        Fri, 13 Nov 2020 21:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605301989;
        bh=0qdxq/6fCC04zul9EHJiDZamo5I8LwvNNhPLyKyFo10=;
        h=Subject:From:To:Cc:Date:From;
        b=QXCgoK/0qDWLYpDIEsazXVCVKl1miwNl3mDx8a3SVyMbLNZfuxhi4T8vW/2GUoI6E
         8PJSYROvPtKKskRHGxfhMmWc51iDpqyuYRlEbxaSFgE/2yyjMNf2PDAaBYcavtUh9v
         huOzBpBYi9SnswoFeGtN6k/K4KxyPdlMVoa9ELhM=
Message-ID: <20e15d1f9c2b1b75faaa84b14109c08aca0b7d69.camel@kernel.org>
Subject: [PATCH] net: Add missing __raw_write_seqcount_end() and
 seqcount_release()
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Fri, 13 Nov 2020 15:13:07 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

This patch fixes a problem [1] I saw when backporting 'net: Properly
annotate the try-lock for the seqlock" from 5.4 to 4.19 which also
looks like it should apply to -devel.

Thanks,

Tom

[1] https://lore.kernel.org/linux-rt-users/20201110153853.463368981@goodmis.org/T/#m0be3a1290486f3493828dedcf7f06d5fbba092a8 

---

The patch ('net: Properly annotate the try-lock for the seqlock") adds
__raw_write_seqcount_begin() in qdisc_run_begin() but omits the
corresponding __raw_write_seqcount_end() and seqcount_release() in
qdisc_run_end().

Add it unconditionally, since qdisc_run_end() is never called unless
qdisc_run_begin() succeeds, and if it succeeds,
__raw_write_seqcount_begin() seqcount_acquire() will have been called.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/net/sch_generic.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 112d2dca8b08..c5ccce4f8f62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -192,7 +192,11 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 static inline void qdisc_run_end(struct Qdisc *qdisc)
 {
 #ifdef CONFIG_PREEMPT_RT
+	seqcount_t *s = &qdisc->running.seqcount;
+
 	write_sequnlock(&qdisc->running);
+	__raw_write_seqcount_end(s);
+	seqcount_release(&s->dep_map, 1, _RET_IP_);
 #else
 	write_seqcount_end(&qdisc->running);
 #endif
-- 
2.17.1


