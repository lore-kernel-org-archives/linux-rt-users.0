Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D0C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BBD64EB3
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhBRTsd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231175AbhBRT3E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 14:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613676454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7m7fE0A04lDm8hG+wKQGsreg0kjDuUIuUrJeFc0LF/8=;
        b=CeoroP1Z5ClKsnfoAR7+pcugn2Fj6dPAX9nnkwswW5jwmUP6Z3g897zWsnV4nJb/8j8Ro1
        mAG4ZekJUn/mc52j3LkYJuBbsP755MRSBAY7bFBQ7kZQGUzLEmzqnw5frr0tE+CS3tP5Di
        9rc/dSf43Avq0NjY60WkbQh0VpMMUUk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-NMke3FJsMXG86sFfiszf_w-1; Thu, 18 Feb 2021 14:27:33 -0500
X-MC-Unique: NMke3FJsMXG86sFfiszf_w-1
Received: by mail-qv1-f69.google.com with SMTP id e9so1743699qvf.21
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Feb 2021 11:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7m7fE0A04lDm8hG+wKQGsreg0kjDuUIuUrJeFc0LF/8=;
        b=H/tLsjwYoERQjyQV8MQguvhb982JdBmss7Ur4g5gQ2SkVUlnkKr55G9TfBRc/q+4nt
         Dbd5VPTWguYYATkY4LkYfCyt1VYuUhH5Iyeduko8lDXIC2tSCZDAN1eMbIQ168d5pEFZ
         zimgBdHB5C0A5LCsyzoJQ2YbTqXnC+PWp2qRbJiNEnr5yKpk4GLxocO7l7apvDzn1CG4
         y81MTMss3oT4lR9tmh45g9vl5tOdT4p+RErAexaQf5NSLb+qXlboroaBMMqOtEGIA21g
         51f9fltWvcurYoZREf7xZgcaPav5lzxqL4Lz6JQacZ7WNO0BES0rqpoumfdZWGvkHJrh
         qI5g==
X-Gm-Message-State: AOAM532sY9twEDTxu6J9RN5wbE9F2f35LWhLUz9riIEJBqx8zf7b+MZl
        lpi6mEWy2PKFjgZ4Gnhi7k5bcvkbIVE+OTWSCwRqmyeesQ7YCehPp+QYFT25LQQiJhETfUWYaqI
        hN/DIS9InZfROGoXemZ7Gik1HYFV9ejcZ1Hxow+/IWOZaigUz5Tu7Y14o4gtFrLTUqgJgOdYjgA
        VG
X-Received: by 2002:a0c:80e9:: with SMTP id 96mr5604697qvb.53.1613676452501;
        Thu, 18 Feb 2021 11:27:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRA9NWN33TXWmkG203jC03rGqVdu38HCXqGTvkmzmSkohY9UrFfFBm65mgLuNWYW15oRamvQ==
X-Received: by 2002:a0c:80e9:: with SMTP id 96mr5604657qvb.53.1613676452103;
        Thu, 18 Feb 2021 11:27:32 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 136sm4621825qko.12.2021.02.18.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 11:27:31 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Clark Williams <williams@redhat.com>, peterx@redhat.com,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: [PATCH] oslat: Fix --cpu-list won't allow to schedule on all possible cores
Date:   Thu, 18 Feb 2021 14:27:29 -0500
Message-Id: <20210218192729.116427-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

parse_cpumask() is too strict for oslat, in that use_current_cpuset() will
filter out all the cores that are not allowed for current process to run.  This
seems to be unnecessary at least for oslat.  For example, the bash process that
runs the oslat program may have a sched affinity of 0-2, however it's still
legal to have it start a oslat thread running on the cores outside 0-2 as long
as the follow up sched_setaffinity() will succeed.

numa_parse_cpustring_all() suites exactly for this case, which should already
have considered sysconf(_SC_NPROCESSORS_ONLN) limit.  Use that instead.

Since at it, also remove initialization of cpu_set variable otherwise it's
leaked in previous parse_cpumask too: numa_parse_cpustring_all() will return a
newly allocated buffer already.  Quotting from manual:

    numa_parse_nodestring() parses a character string list of nodes into a bit
    mask.  The bit mask is allocated by numa_allocate_nodemask().

    numa_parse_nodestring_all() is similar to numa_parse_nodestring, but can
    parse all possible nodes, not only current nodeset.

Cc: John Kacur <jkacur@redhat.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Clark Williams <williams@redhat.com>
Reported-by: Pradipta Kumar Sahoo <psahoo@redhat.com>
Reported-by: Mike Stowell <mstowell@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 src/oslat/oslat.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index b2c5373..465a694 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -785,7 +785,6 @@ int main(int argc, char *argv[])
 	struct thread *threads;
 	int i, n_cores;
 	struct bitmask *cpu_set = NULL;
-	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
 #ifdef FRC_MISSING
 	printf("This architecture is not yet supported. "
@@ -797,10 +796,6 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	cpu_set = numa_allocate_cpumask();
-	if (!cpu_set)
-		fatal("oslat: Could not allocate cpumask\n");
-
 	g.app_name = argv[0];
 	g.rtprio = 0;
 	g.bucket_size = BUCKET_SIZE;
@@ -817,7 +812,8 @@ int main(int argc, char *argv[])
 	if (!g.cpu_list)
 		g.cpu_list = strdup("all");
 
-	if (parse_cpumask(g.cpu_list, max_cpus, &cpu_set) != 0)
+	cpu_set = numa_parse_cpustring_all(g.cpu_list);
+	if (!cpu_set)
 		fatal("oslat: parse_cpumask failed.\n");
 	n_cores = numa_bitmask_weight(cpu_set);
 
-- 
2.26.2

