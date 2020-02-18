Return-Path: <SRS0=BQEv=4G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503A1C34031
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 07:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2160E207FD
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Feb 2020 07:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="JRXqcRmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgBRHU0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:20:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45056 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgBRHU0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Feb 2020 02:20:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id e18so21625776ljn.12
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Feb 2020 23:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o+KZABjZJjgu18KfQjw9IUql1rKdHn9m7cDl4rUcp5g=;
        b=JRXqcRmNN7Kv5zCOJDvHC0iv/DJzlkfrslkkJjplrwo2Brtuj+3o/hRiUJXR53XQFt
         ipzGGK6GK7qEpH6OVgjq78eLmC8RCmJtSx28JZ4oEdByMkK0CV0UR1x5JXq2ZlsuB7jK
         9hzmDf9khzM5clN+vbFOqMYuUloUGC+3eyC4kDbP/cIGqTIFsmDQpOE9ZhSkxw0Mumqf
         a1YpYELr+R1rKnpS5DogBzFLghPgI9RwX0a9JFVkZgRVDGqcFOsDFdC60suO6rZNnEAM
         F+UV8cCdnxjZ8ieRpP2WtRIbw7JFyIMerumKsBu7SFCt6B7Q23ScItPNjfFT6pxjV+vv
         LCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o+KZABjZJjgu18KfQjw9IUql1rKdHn9m7cDl4rUcp5g=;
        b=m5HTPy8m+415zetqJSp36HK+Ni5/zfPRD+XTuFls1IJcokUtDhcPM++Efy6jQWEpwg
         jX19lAFHNnh/7oCTCpbrpvO4dXNV2CTX3mMlKftpRXBwuFK+kHjlEbo+txcpFZwqfz7b
         53xprZ8Wx74C8djoaeVKGCE3nhfe5f0+QgoBBtTOIYINkfhArrfDLmxJixA84TfHP1g5
         GiHNoTUF9reW6IWAf9C+bMrmAaQzFaMB7yohqG8Ek8RoXHaCJGg6MwfNcAV6zOi0BOvF
         hlOYlhdR1xee2SFVmR16IWXGDKNExlXE5LzLEB7Ww1JBk7a8mUNyGd6lFdCcq3fw39xa
         02yg==
X-Gm-Message-State: APjAAAVrQM5QNdd3EKDLp6rSK/3sbLclPkXnkD3CpwnY7F/j7PmOmVhY
        bVmFtMkVsAo5C1D6Jn5QJb8di1UJVNo=
X-Google-Smtp-Source: APXvYqyAsGYV7w/AabqCzWluGLy5pB7jG1IgzIjFsLxbNOdx+09AECCtc5BUELqSjstT+li0kXB+jQ==
X-Received: by 2002:a2e:9157:: with SMTP id q23mr12052398ljg.196.1582010424027;
        Mon, 17 Feb 2020 23:20:24 -0800 (PST)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.googlemail.com with ESMTPSA id u24sm1771079ljo.77.2020.02.17.23.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 23:20:23 -0800 (PST)
From:   John Mathew <john.mathew@unikie.com>
To:     bigeasy@linutronix.de
Cc:     john.mathew@unikie.com, linux-rt-users@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] swait: Increase number of waiters for warning
Date:   Tue, 18 Feb 2020 09:18:57 +0200
Message-Id: <20200218071857.14805-1-john.mathew@unikie.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213083121.vqbbbufja4uilblo@linutronix.de>
References: <20200213083121.vqbbbufja4uilblo@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When stress testing the kernel using the syzkaller the following
warning occurs frequently:

[ 553.403826] 001: complete_all() with 4 waiters
[ 553.404205] 001: WARNING: CPU: 1 PID: 10418 at swake_up_all_locked+0x146/0x1e0
[ 553.404806] 001: Modules linked in:
[ 553.405101] 001:
[ 553.405269] 001: CPU: 1 PID: 10418 Comm: cryptomgr_probe Tainted: G

Investigation shows that this warning is caused due to the mode
of working of the crypto module using completions. The increased number
was found through experimentaion using syzkaller.

Signed-off-by: John Mathew <john.mathew@unikie.com>
---
 kernel/sched/swait.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index c58068d2ee06..111f9bc98e4d 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -47,7 +47,7 @@ void swake_up_all_locked(struct swait_queue_head *q)
 	}
 	if (pm_in_action)
 		return;
-	WARN(wakes > 2, "complete_all() with %d waiters\n", wakes);
+	WARN(wakes > 10, "complete_all() with %d waiters\n", wakes);
 }
 EXPORT_SYMBOL(swake_up_all_locked);
 
-- 
2.17.1

