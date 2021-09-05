Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D025EC433F5
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B993C60F3A
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Sep 2021 14:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhIEOhp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbhIEOhh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Sep 2021 10:37:37 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24EC061757;
        Sun,  5 Sep 2021 07:36:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 7so3513643pfl.10;
        Sun, 05 Sep 2021 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OVSykNEDsr3De09JjN4H8vteFEdeG7PRUERLsHEcls=;
        b=p0jJYPqB0C3XBLFbqKxZAc6H/gTRGF+sJXxxXG39ECHX5c957d9WWQqQIbEKqE0kMK
         qOqcj9oCr+2jf0+3LeT1tbLW62HN46V0mu6mg5+ERk6Bu/oO8mNcezJQY6OjZ4QYaVPk
         XJKHHpGWQfhZWumWVcYCGAslIwapQrg8RT7meSWOQvpazKe1kQ2CdyhOQfjccrAwGizz
         H+MOyFu4fzqycbrcaqHfshJkZaxTDXCcr3CzNEINzvDxdhyIUXLcZH6k0x6UcQruInXc
         zBCiIquXu9bWj1xaYcepBFkyQbNmZ0hKLm1buBMIrkGl23cZ8lbXu1VPW5Zc1e3fY5qv
         yMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OVSykNEDsr3De09JjN4H8vteFEdeG7PRUERLsHEcls=;
        b=MWAPlFweB93M0R7MVuZA0cfToNIzrTcxLP+38hwMxEMLe8G4K/qOTXI6bTSb1UJ8Yk
         W7SdbCL1cQmJc7RTk75fJr4ImlySCdoSwfNFiWZZFIk88GdXu7tLsxHuHT4RJ1vZe0Qj
         jARQJNGp+5Tz4baq36IjvXjoHxqqYvudiu0PTYRAdKwu3Er639QOdkZmEL6Q2AkWr7NV
         znUo9REnlrvVlYXRX4nMlr1vnRdau4oAqopzoSFm+f237NuxGZDEA2+k3POQIdrb392J
         +pvLCSsEuUzSv34rDXp3mKkBf9Gl+/haAYY50dVwjR5+4acDtPnU5vk03Xns/zGTQwcr
         dTqQ==
X-Gm-Message-State: AOAM530cmbv6YnR+B5yE6Ww5Z9DtrwjbPfH7mGfJWW096/nGlTPTDUUZ
        3hcIiDSp0yYWUxkJlsnKx44=
X-Google-Smtp-Source: ABdhPJwg6qZHHmLsz1kJhudhMGEQgM6lez60oTX1WQeVV5qs4RHue5pn1xNQoop6M+3/EcvzI/kLtg==
X-Received: by 2002:a63:5663:: with SMTP id g35mr7884843pgm.368.1630852593705;
        Sun, 05 Sep 2021 07:36:33 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.246])
        by smtp.gmail.com with ESMTPSA id n185sm5186883pfn.171.2021.09.05.07.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 07:36:33 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 7/8] sched, dl: support sched_stat_runtime tracepoint for deadline sched class
Date:   Sun,  5 Sep 2021 14:35:46 +0000
Message-Id: <20210905143547.4668-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The runtime of a DL task has already been there, so we only need to
add a tracepoint.

One difference between fair task and DL task is that there is no vruntime
in dl task. To reuse the sched_stat_runtime tracepoint, '0' is passed as
vruntime for DL task.

The output of this tracepoint for DL task as follows,
             top-36462   [047] d.h.  6083.452103: sched_stat_runtime: comm=top pid=36462 runtime=409898 [ns] vruntime=0 [ns]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Alison Chaiken <achaiken@aurora.tech>
---
 kernel/sched/deadline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 51dd30990042..73fb33e1868f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1268,6 +1268,8 @@ static void update_curr_dl(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
+	trace_sched_stat_runtime(curr, delta_exec, 0);
+
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-- 
2.18.2

