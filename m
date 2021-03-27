Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18E6C433C1
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AE761A0A
	for <linux-rt-users@archiver.kernel.org>; Sat, 27 Mar 2021 10:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhC0KOT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 27 Mar 2021 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhC0KOS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 Mar 2021 06:14:18 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58AC0613B1;
        Sat, 27 Mar 2021 03:14:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c4so7844898qkg.3;
        Sat, 27 Mar 2021 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiMm0QWfMi21rH/2ymiXZtZhTYWphD7xBhYNKRl9+a8=;
        b=eqPvl6OiUp1WHrnW1k/QJTEnq2l6wBKvfdAfbCRIELrnK3UvM8UEmtIwTxf5onUJtE
         +Qtj6WRHQUusGC36bDdn2Dv6qabHxCZnaQ3o+B+mO05XQD9JmCWupxxbnWhUkcXjKI3G
         pQx9Oiu/mE0qXKyNPEWw6nfePV2WcAPsoLaIJ8Z9Cm1N7U+v/QCxzXu2zbowqkuxYv+A
         gZLClOLK1Aa5lKh0LbxLZnQzpoqWoXxAfYoSDKa1SMEpTlr38CDnqRHql7hQpMqJIS6P
         sD/TygFTGIEqP1BV+3lbuxbjRYFlqB/stXbPp76nW8L8X0mwk8Yw0lfEYZWZzXuT0uci
         jung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiMm0QWfMi21rH/2ymiXZtZhTYWphD7xBhYNKRl9+a8=;
        b=dsXxpseXVMDwb6C8Fq9V8sM9pQkwrPPw+m1OcsPB4ZezZzhuUQLVf1KAqdBJYsDXY5
         4btP8YmOWfemUEj03MFJJw9X4VLPRWBJ+LAdH7iYVnwHaTizdC4OTkx3fXbmzoFrS0Pa
         8XR4GXqKWJDrxv6+FWlyQ4gIwNlfs1s+jCs++vCWHVGmL1q3AEagOl3GiCucTKYga0wX
         NHueGF2Jovgh1fzB+c6HFXTXLzrtOe8NIho47NeM0xPlgaowb1Yr/h60gmngyXudIDRN
         4mpZTJHjXKjovQrbhlAceXOI2i0U6HGHczz7vPutMKBtq5JhhadbXkSK7YYS+PY78TSM
         w/IA==
X-Gm-Message-State: AOAM532gMDg7vxPW/Hkz0tAGP3qHqS/u7F7bVaAeMPB8JjK/7aKCoE/s
        1cIOm959g2Y7VZQyJeminFQ=
X-Google-Smtp-Source: ABdhPJwaSCYe7dFPNVzaYghfJ1MWJap/oSbA7ourAobrmEVzVRXeBbF6VrEQAzeloDRVyFKoMge2iw==
X-Received: by 2002:a37:a5c2:: with SMTP id o185mr17763928qke.428.1616840056963;
        Sat, 27 Mar 2021 03:14:16 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id d14sm7404053qtr.55.2021.03.27.03.14.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Mar 2021 03:14:16 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 5/6] sched, rt: support sched_stat_runtime tracepoint for RT sched class
Date:   Sat, 27 Mar 2021 18:12:52 +0800
Message-Id: <20210327101254.56872-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210327101254.56872-1-laoar.shao@gmail.com>
References: <20210327101254.56872-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The runtime of a RT task has already been there, so we only need to
add a tracepoint.

One difference between fair task and RT task is that there is no vruntime
in RT task. To reuse the sched_stat_runtime tracepoint, '0' is passed as
vruntime for RT task.

The output of this tracepoint for RT task as follows,
          stress-9748    [039] d.h.   113.519352: sched_stat_runtime: comm=stress pid=9748 runtime=997573 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.520352: sched_stat_runtime: comm=stress pid=9748 runtime=997627 [ns] vruntime=0 [ns]
          stress-9748    [039] d.h.   113.521352: sched_stat_runtime: comm=stress pid=9748 runtime=998203 [ns] vruntime=0 [ns]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/rt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 34ad07fb924e..ae5282484710 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1012,6 +1012,8 @@ static void update_curr_rt(struct rq *rq)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
+	trace_sched_stat_runtime(curr, delta_exec, 0);
+
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
 
-- 
2.18.2

