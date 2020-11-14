Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55E6C5519F
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Nov 2020 20:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6812E223BE
	for <linux-rt-users@archiver.kernel.org>; Sat, 14 Nov 2020 20:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txs01qus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKNUMs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 14 Nov 2020 15:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgKNUMr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 14 Nov 2020 15:12:47 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E5AC0613D1
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Nov 2020 12:12:47 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id p12so9868322qtp.7
        for <linux-rt-users@vger.kernel.org>; Sat, 14 Nov 2020 12:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=tHfX4ZEY+cO2OUefXMdRQ7KaJKW/jIHt2HFTN2P9+WA=;
        b=txs01qus+1QMgWUfvI7UDb6OFwAKOWQq60dHrD5Tebaxghk9ERASpF3c8BNSAnn4iB
         wvNpRhF0kvsTnv556FLsupqqDD9iR+D+P//zo9CUJlye8zzOSw5VR2CXYwdYlZMTRLG2
         P7D6dtiz39Tv9jmpeLVBh/PS8lv7u6sTVUZhmQ+WTbqyngSdhritUgeS4zSJhm2kSbnd
         mfORe+pzqCpYwE82PD6sYJhUw+2+YzYwa7ZZT5xKHsYofNl+9D1Cr3dcWJTQmbKMHrrz
         7l8kIeCQQu5x5UFLJtlYSvlDEvnksXgfCMgTzwxo+HjByDWqxQfBkI2PsaTkWpXRHOh6
         U/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=tHfX4ZEY+cO2OUefXMdRQ7KaJKW/jIHt2HFTN2P9+WA=;
        b=p3xzvfE0u36/j0Oi0Zac2nZL/ErWujoch9HNjqrs2inmQk9+aRh1XUyZ19K+52SDVJ
         SkS13Tf7u9UHj8wwUS1HiVw2aiN6jkDYjqOPyx/diZtOiCkL2jR1Sv2bGFRNdM8Ps7PA
         Qu8rWryd8Rn/YEodLmzU34S/K752+mQt18Cl0Fy0X2UTP+lc/oUc1V5wsO5XiXHIgh4M
         ApPQj3DltUnRsC1KsO0KkGoYge2nLpO1tVkddqlC9aeDM5lcRxKtU3hUa45EV5thCUV9
         hOmZRIq944GS9emNm2kibkkrMVXHXhqClWzreTsvW1ofDHI5/rfqU1E+JkVtLpsn4Qe2
         CG7Q==
X-Gm-Message-State: AOAM530EIPsl+eb5vZc+c6OPWylSzzR9BMcH5dKmI7hHd9REvSxplab3
        6eS30jbsDg12chr+JmpHLoA=
X-Google-Smtp-Source: ABdhPJxMmIkpjTd+4xVZlYC169Jpd69JWEMsueWJMqeiCUSi+Lbr9hV12EKyPig9faLnpJdz8+Oijw==
X-Received: by 2002:ac8:5846:: with SMTP id h6mr3283924qth.25.1605384766796;
        Sat, 14 Nov 2020 12:12:46 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:100:abf0:3897:8012:5b23:2ae7])
        by smtp.googlemail.com with ESMTPSA id f130sm8079704qke.30.2020.11.14.12.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Nov 2020 12:12:46 -0800 (PST)
Message-ID: <edf053cb3e36a3640cff920d74f582415896373d.camel@gmail.com>
Subject: [PATCH RT v2] net: Add missing seqcount_release() to qdisc_run_end()
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>
Date:   Sat, 14 Nov 2020 14:12:45 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian and Steve,

This patch fixes a problem [1] I saw when backporting 'net: Properly
annotate the try-lock for the seqlock" from 5.4 to 4.19 which also
looks like it should apply to -devel.

This was tested on 5.14 but applies cleanly to rt-devel as well.

Thanks,

Tom

[1] https://lore.kernel.org/linux-rt-users/20201110153853.463368981@goodmis.org/T/#m0be3a1290486f3493828dedcf7f06d5fbba092a8 

v2: Mike Galbraith pointed out that write_sequnlock() already contains
__raw_write_seqcount_end().

---
The patch ('net: Properly annotate the try-lock for the seqlock") adds
a seqcount_acquire() in qdisc_run_begin() but omits the corresponding
seqcount_release() in qdisc_run_end().

Add it unconditionally, since qdisc_run_end() is never called unless
qdisc_run_begin() succeeds, and if it succeeds, seqcount_acquire()
will have been called.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/net/sch_generic.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 112d2dca8b08..221470e38031 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -192,7 +192,10 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 static inline void qdisc_run_end(struct Qdisc *qdisc)
 {
 #ifdef CONFIG_PREEMPT_RT
+	seqcount_t *s = &qdisc->running.seqcount;
+
 	write_sequnlock(&qdisc->running);
+	seqcount_release(&s->dep_map, 1, _RET_IP_);
 #else
 	write_seqcount_end(&qdisc->running);
 #endif
-- 
2.17.1


