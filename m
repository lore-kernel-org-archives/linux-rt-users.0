Return-Path: <SRS0=+khU=62=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E11EC54E4A
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 15:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2341F2054F
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 May 2020 15:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0kBHybR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgELPRD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 May 2020 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgELPRD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 May 2020 11:17:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A3C061A0C
        for <linux-rt-users@vger.kernel.org>; Tue, 12 May 2020 08:17:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z90so11308888qtd.10
        for <linux-rt-users@vger.kernel.org>; Tue, 12 May 2020 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tksKYTKOZjBLZKmDSpmSmKem80Q35JBnOL6SD5YPzdc=;
        b=Z0kBHybR3CaIPXT8r5PaYUNvTTI3k8vT6hbdjHz/VYs9VWODRje1c/ofmTLPhNRrO3
         J2ujCPavXo3//1tVlmXnRyxaajEtUN34XHehW2silzhTZMH9oQzfQjDyRWVJfv5hGMsM
         yuZqRKCvEMV5VY+dCqCd6bZFeBSqh7EgUOAzMFzhrIlXRmJEFBQgPuMolfHUtNkJKdct
         J6zxPmR62g4wWJoSldHjgyaDZBK87P8g5plfCgigUxuiJvV//qKKlziqr4nlFC8p9lK7
         vMMHSE3/6zq1DeDOeli+9Hp2lBq39KKJIBGdNnRRXKK4YqytOrfU6TvACnn9S3+ROw6u
         VAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tksKYTKOZjBLZKmDSpmSmKem80Q35JBnOL6SD5YPzdc=;
        b=O4WSBV13oZ7EYj0CQhjmdj0q2hh74mn1TyAnthhh8yQIDgFqtNbNq2jPDYrxkH60Ov
         F5jMb6SZ/oMA3M5NObwMwWCXk8CLEcP44wFgQxvC2g+yx0dMBDcrNUk+WtJ7PA3S3pOP
         9vlnFAWu3CQmRz7OxvAWB+fFBrF/MSiFdDKUF+Jl5p2IV5L3ctWI7Ou+jzT7c9NvmRp6
         T0DO92wGRhJHsT+NVIaDqkQX/a5TiKsZIlkDXO4qQm6qawmCmglZAmH2e0MevWYIRw1q
         cbJ3alDCSkfg6mi4hI+ee2h8pudgmSSLIPVOzxF1peXkLBKcXACzj9z7SD4RzjPoo8dm
         l7xA==
X-Gm-Message-State: AGi0PuakaGKYZff2/hzc5aAsRFryq6VcxHqz6diIngZAvrwtNf5TsIgF
        +QTr8EBq0FduJV6wXNikZGOpNwcJ
X-Google-Smtp-Source: APiQypI+gBOGOz4OS1bXNoafXM35ruzYIrfGfxMVPL8b8orKADGDOjDtFfbYe9G5pyLJguucfCtcFw==
X-Received: by 2002:ac8:c0d:: with SMTP id k13mr19685785qti.136.1589296621708;
        Tue, 12 May 2020 08:17:01 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j83sm10851360qke.7.2020.05.12.08.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:17:00 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: queuelat: Fix storing unsigned long long in int
Date:   Tue, 12 May 2020 11:16:51 -0400
Message-Id: <20200512151651.4642-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

queuelat can occassionally hang because of overflow mixing
unsigned long long and int

Attaching to process 173912
Reading symbols from /root/rt-tests/queuelat...done.
Reading symbols from /lib64/librt.so.1...Reading symbols from /usr/lib/debug/usr/lib64/librt-2.28.so.debug...done.
done.
Reading symbols from /lib64/libpthread.so.0...Reading symbols from /usr/lib/debug/usr/lib64/libpthread-2.28.so.debug...done.
done.
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
Reading symbols from /lib64/libc.so.6...Reading symbols from /usr/lib/debug/usr/lib64/libc-2.28.so.debug...done.
done.
Reading symbols from /lib64/ld-linux-x86-64.so.2...Reading symbols from /usr/lib/debug/usr/lib64/ld-2.28.so.debug...done.
done.
__memmove_avx_unaligned_erms ()
    at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:254
254		rep movsb
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0x0000000000400c02 in account (val=18446744071562067968)
    at src/queuelat/queuelat.c:93
93		buckets[bucket_nr]++;
(gdb) bt full
    at src/queuelat/queuelat.c:93
        bucket_nr = -193273529
        a = 825932047802952
        b = 825925371232340
        dest = 0xf322b0
        src = 0xf4e3f0
        i = 45749
        delta = -2147483648
        loops = 50000
        time = 6500
        bucket_nr = 65
        n = 115000
        delta = 3500
    at src/queuelat/queuelat.c:671
        tsc_freq_mhz = 2398.5039999999999
        max_queue_len_f = 159.900284
        mvalue = 0x7ffc99d3021c "20000"
        cvalue = 0x7ffc99d30225 "300"
        pvalue = 0x7ffc99d30238 "6.1"
        fvalue = 0x7ffc99d3022c "2398.504"
        tvalue = 0x7ffc99d3023f "30"
        qvalue = 0x0
        index = 0
        c = -1

Fix the above by declaring delta as an unsigned long long

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/queuelat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index 7e5e35768a8b..22b68a84d6ae 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -354,9 +354,9 @@ static void trace_write(char *buf, int len)
 
 static void run_n(int n)
 {
-	u64 a, b;
+	u64 a, b, delta;
 	void *dest, *src;
-	int i, delta, loops = 50000;
+	int i, loops = 50000;
 
 	init_buckets();
 
@@ -445,9 +445,8 @@ static void print_exit_info(void)
 
 void main_loop(void)
 {
-	u64 a, b;
+	u64 a, b, delta;
 	void *dest, *src;
-	int delta;
 	int queue_size = 0;
 
 	trace_open();
@@ -500,7 +499,7 @@ void main_loop(void)
 			continue;
 
 		ret = sprintf(buf, "memmove block queue_size=%d queue_dec=%d"
-			           " queue_inc=%d delta=%d ns\n", queue_size,
+			           " queue_inc=%d delta=%llu ns\n", queue_size,
 				   nr_packets_drain_per_block,
 				   nr_packets_fill, delta);
 		trace_write(buf, ret);
@@ -536,7 +535,7 @@ static void install_signals(void)
 
 int calculate_nr_packets_drain_per_block(void)
 {
-	int maxcount;
+	unsigned long long maxcount;
 	int i, time;
 	int found = 0;
 	int bucket_nr = find_highest_count_bucket();
-- 
2.21.3

