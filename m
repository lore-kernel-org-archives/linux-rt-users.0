Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5FCC433E9
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Feb 2021 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE2764EAD
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Feb 2021 09:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBAJe6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Feb 2021 04:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBAJe5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Feb 2021 04:34:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885BC061574;
        Mon,  1 Feb 2021 01:34:16 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a9so4890486ejr.2;
        Mon, 01 Feb 2021 01:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JOA8AslWAgQu8HB4vwPy5Cg6rMlCtjVYzJN65+0PgE=;
        b=rsm6IQFHIQGKmVra2pvBfSkAYm1yOL0zeWeik3rVdFh1BNn/PQmSuuFwjjs/NoI/7P
         MejnkXy2tmHHj6McXgQoq6jSngWt98XDVe+CxGpmxyNqjKVGw7BlZc1vAXh4lgcysdoI
         +Qtz2/qFMdqeV12+DN56vutVI9RcFT1yY+Txufr1HUn7kTcfR3Lw4paCW4YE7LW6xQju
         3ptgPAyKOPJHVeh4QVhRJ2mOjGwEWEVH0vbj2U7+vxRum/Pi/9d7fGp4twA90Rxbil6e
         RnDUzFirg1U4QF3vZqKitnlqYgyDUMn63WiOdvgO+zuBVn4sl6gZuOqhO+0xAEebIYiw
         eRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JOA8AslWAgQu8HB4vwPy5Cg6rMlCtjVYzJN65+0PgE=;
        b=swkLzfupjaJQpeZpKO6yxdRA8MPOoDV/0fmfY8wo1vWMRAzVXvSW52Ziwx6JjD8+sb
         6ck9ptXjTFUN5uurcqokgcLMR0pidkez17bL0yQ+d52xy37IuBLS6hAlqEcrOJaYJ8h7
         +6GWzz8FpupFfWpJp/UgS5LoeVRug7q63gSZIuAsYXxwcs7a/bs8Q2gZeCOzHi86KGPE
         C4JYoL7vuTikx3Foi02L5LwlBd8F3abCWqI3s4KIM+d/wqteBLYJ231jx8nyr6VhkVI+
         1xXTKfI7v6up/2qdgOP+Ca+S3P3bO+X7BN6Do/Ve96RvNWb6wMsOP/jHpVY5JmOPTKXV
         gkHw==
X-Gm-Message-State: AOAM533/dN7tW+R5QvLJZHM/ihY2F52n1ZU61SC23Pu6vhvhYmfURNmE
        vA+oyBMzkCYc9HOOJq2BsMo=
X-Google-Smtp-Source: ABdhPJwj7iCW8hbeLzsJL+g6iX+VKZt2w1fLfzIcESYFDANyvnCj5HA0eG6DM1Wu2wQj004GtLwc3g==
X-Received: by 2002:a17:906:805:: with SMTP id e5mr3936460ejd.104.1612172055177;
        Mon, 01 Feb 2021 01:34:15 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-bc7f-2f00-63cb-2442-68a6-e817.c22.pool.telefonica.de. [2a01:c22:bc7f:2f00:63cb:2442:68a6:e817])
        by smtp.gmail.com with ESMTPSA id v1sm3290931ejd.3.2021.02.01.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 01:34:14 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [RFC] sched/rt: Fix RT (group) throttling with nohz_full
Date:   Mon,  1 Feb 2021 10:34:12 +0100
Message-Id: <20210201093412.4900-1-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If nohz_full is enabled (more precisely HK_FLAG_TIMER is set), then
do_sched_rt_period_timer may be called on a housekeeping CPU,
which would not service the isolated CPU for a non-root cgroup
(requires a kernel with RT_GROUP_SCHEDULING).
This causes RT tasks in a non-root cgroup to get throttled 
indefinitely (unless throttling is disabled) once the timer has 
been moved to a housekeeping CPU.
To fix this, housekeeping CPUs now service all online CPUs 
if HK_FLAG_TIMER (nohz_full) is set.

I'm not really sure how this relates to  Mike Galbraith previous
commit e221d028bb08 ("sched,rt: fix isolated CPUs leaving root_task_group
indefinitely throttled"), (which is dated before the housekeeping changes,)
so I'm posting this as an RFC.


Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 kernel/sched/rt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096a8aa1..3185e00b828a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -865,9 +865,16 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	 * isolation is really required, the user will turn the throttle
 	 * off to kill the perturbations it causes anyway.  Meanwhile,
 	 * this maintains functionality for boot and/or troubleshooting.
+	 * If nohz_full is active and the timer was offloaded to a
+	 * housekeeping CPU, sched_rt_period_mask() will not contain
+	 * the isolated CPU. To prevent indefinite throttling of tasks
+	 * on isolated CPUs, housekeeping CPUs service all online CPUs.
 	 */
-	if (rt_b == &root_task_group.rt_bandwidth)
+	if (rt_b == &root_task_group.rt_bandwidth
+		|| (housekeeping_enabled(HK_FLAG_TIMER)
+			&& housekeeping_cpu(this_rq()->cpu, HK_FLAG_TIMER))) {
 		span = cpu_online_mask;
+	}
 #endif
 	for_each_cpu(i, span) {
 		int enqueue = 0;
-- 
2.29.2

