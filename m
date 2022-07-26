Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756ACC00140
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 18:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbiGZSFK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbiGZSFI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 14:05:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55753AA
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 11:05:07 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o21-20020a17090a9f9500b001f0574225faso10309869pjp.6
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b0s8tjcd4Q8b78XuBsyGosbDovXKyy+xy+cv6AoPTNE=;
        b=SjSpCjhCoZ4ioVc+zP+VFxih0fgmqB8+1MxLODyS4UOOp8874pBU1mIhvrEcU1B96V
         M/a6aCkq1KN3Dy8HxnTfBsgK1nQehVHMNF4HPuHGc4uGg+diTaOrM8G9anz9Ci2f+7MC
         DdVhuD6omAF4yia6p/ou3RM+IV90tJk1nuYJ20Hzmw8ak8LVlQNND3LGurjxjNVW0OHj
         jMV2O7eWZbaDzkzntQY/9t13TCUNyEwpaMXm5GEsuArKVJduo0l7YSu03FNJkZg1DKMi
         XHx7xHnjritF3aYct5WLcBJbwKGAolGivFa77XnTjByl0qDqM2tGw1pVBVJkvMnfWCn4
         cMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b0s8tjcd4Q8b78XuBsyGosbDovXKyy+xy+cv6AoPTNE=;
        b=Lyyo03e8xobOhBthXVqUVj7ZWRiZWSaisG1bf2UxSBOmpE11cd7VOJSEdturRYl5Mv
         EgV3kYfv30FHdZlQQc7XF2HOAVhTD/detUFeKmqQBuXds/jslAMj6Ls6YFTy/yqivhTT
         wDMXlrUrtdzfPCC5FGdXLkmdT27heZehWEYdImb6YF4wAfIMbNip9DKHLS3FFgVx/hyW
         jnGO9VDgqcXl+GIyeJgUFuzLWoZxUdKe0aAaFBDQoAbH1a6SJq7IjVmOPDwCCMzoW1fR
         Kjjyie1sdaNDU7NXLPB7B8rAazq2isQB0gdi3FTy/NEgGnk3hfVxzgCgA81ucXaP3pak
         dc4g==
X-Gm-Message-State: AJIora9OxInU7AaPtfKXr7wW2+iS+cBbAj4jMdnxZJ9CaRVvq21EuQn8
        p/nYwtp0hERkymbjKsjOkNgq/Xb53nMx0QkLpHjapjLAy4bkmuNcHFJ56ftOD7Pbo8yUG44wzXv
        ssZpzfourYMPKFSQUrUDrzimYDkq6AOeFFa8qkMhkHdL84IRGEXM7NPsFUEoogcPc3R9dmi0RhQ
        ==
X-Google-Smtp-Source: AGRyM1vMBH2UvBC94/klEPuXnXtbOLAh20wkJ0HaHJlJ/J7nDo5bEcanfgw2L9hlMzXJUX0xul36J0D+u2PE
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:998:b0:52a:db4c:541b with SMTP id
 u24-20020a056a00099800b0052adb4c541bmr18292236pfg.35.1658858707230; Tue, 26
 Jul 2022 11:05:07 -0700 (PDT)
Date:   Tue, 26 Jul 2022 18:05:02 +0000
Message-Id: <20220726180502.2932619-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] cyclictest: Fix threads being affined even when -a isn't set
From:   John Stultz <jstultz@google.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>, John Kacur <jkacur@redhat.com>,
        "Connor O'Brien" <connoro@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Using cyclictest without specifying affinity via -a, I was
noticing a strange issue where the rt threads where not
migrating when being blocked.

After lots of debugging in the kernel, I found its actually an
issue with cyclictest.

When using -t there is no behavioral difference between specifying
-a or not specifying -a.

This can be confirmed by adding printf messages around the
pthread_setaffinity_np() call in the threadtest function.

Currently:

root@localhost:~/rt-tests# ./cyclictest -t -a -q -D1
Affining thread 0 to cpu: 0
Affining thread 1 to cpu: 1
Affining thread 2 to cpu: 2
Affining thread 3 to cpu: 3
Affining thread 4 to cpu: 4
Affining thread 5 to cpu: 5
Affining thread 7 to cpu: 7
Affining thread 6 to cpu: 6
T: 0 (15034) P: 0 I:1000 C:   1000 Min:     82 Act:  184 Avg:  180 Max: 705
...

root@localhost:~/rt-tests# ./cyclictest -t -q -D1
Affining thread 0 to cpu: 0
Affining thread 1 to cpu: 1
Affining thread 2 to cpu: 2
Affining thread 3 to cpu: 3
Affining thread 4 to cpu: 4
Affining thread 5 to cpu: 5
Affining thread 6 to cpu: 6
Affining thread 7 to cpu: 7
T: 0 (15044) P: 0 I:1000 C:   1000 Min:     74 Act:  144 Avg:  162 Max: 860
..

This issue seems to come from the logic in process_options():
	/* if smp wasn't requested, test for numa automatically */
	if (!smp) {
		numa = numa_initialize();
		if (setaffinity == AFFINITY_UNSPECIFIED)
			setaffinity = AFFINITY_USEALL;
        }

Here, by setting setaffinity = AFFINITY_USEALL, we effectively
pin each thread to its respective cpu, same as the "-a" option.

This was most recently introduced in commit bdb8350f1b0b
("Revert "cyclictest: Use affinity_mask for steering
thread placement"").

This seems erronious to me, so I wanted to share this patch
which removes the overriding AFFINITY_UNSPECIFIED with
AFFINITY_USEALL by default.

With this patch, we no longer call pthread_setaffinity_np() in the
"./cyclictest -t -q -D1"  case.

Cc: John Kacur <jkacur@redhat.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 src/cyclictest/cyclictest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index decea78..02f32f6 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1270,8 +1270,6 @@ static void process_options(int argc, char *argv[], int max_cpus)
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
 		numa = numa_initialize();
-		if (setaffinity == AFFINITY_UNSPECIFIED)
-			setaffinity = AFFINITY_USEALL;
 	}
 
 	if (option_affinity) {
-- 
2.37.1.359.gd136c6c3e2-goog

