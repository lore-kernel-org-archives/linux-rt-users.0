Return-Path: <SRS0=J9x3=4T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2689C3F2D1
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A8622B48
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd9ko9Tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCBVom (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36151 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBVom (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Mar 2020 16:44:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so1268626qto.3
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2020 13:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D/9DxqGXZ5agSwYMOlMxRcskc3+np0HwKGryWEGPDIk=;
        b=hd9ko9TnUNf2YfUDLTN8fmwnjfTUx1QdS1c9bwaxFQSxfHYyBYrIbL4O2M99epksso
         zakHHZMC216lHpxayMahZGr32f06nwFAi9cIK0x1MV8syksxU6A4+LR/RQVL+jWeGiRv
         FO1H3Vn6j13PvjoO2SwUSfAGTSIbQJt+wiBJkx7dQb+yYwTcaf6z7c7HXT+Tqbo3fT9D
         X79dwHjrD8VAKjoprAsT4Rhm62rDn1DKrbryMqz33Y4jVAz6zFo/VaCcGQdZJizEdsYv
         K+ECAs/erHubNOBt4d4JpkaatOSHJje6s9U8POqEbBtxM/AX+Somc/RlatLVe62KzkZv
         NKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=D/9DxqGXZ5agSwYMOlMxRcskc3+np0HwKGryWEGPDIk=;
        b=pMou1UQ3znQr59FjAQRvko/4QfAWXADv8uNJjGEHTUxhhqj/erdDrzxPmbT9AvNj2F
         WkfMT1qfHbi/X4Mk5ov4R5ZF9kLBVDzu8k5kb8V031xIypu/NwPZTHkbQ6dxGzrCvpfi
         pO/pEA2y8i3ZXuZzsilCjHfEp640hB4g4153KCrN5SfcTAkJVWmei4XWo4NCC8mT6yG1
         NclXtJX8yXNO960Y8lL4ycl3mN22e7teRGa/t/Mz1nKfIBV03XEfN1etp0NA2cQVMIZ/
         61TjDkQGyYXhTf3RSuwg3qQjl21a/yf+zjyuz3wM9KSKPsrZIic4oBMjJRo6eEDYCsUR
         nxaQ==
X-Gm-Message-State: ANhLgQ16DzVdfS57D7+73B2/bl2Ks8ATP/YH1XyE/KQZ8bs1dJ05iQGS
        Y6XAcdts8ZYoY8kkJErmQWWx/8DmbKo=
X-Google-Smtp-Source: ADFU+vs+VDrcVMDM4gzUeiOTqbZMkl/gBTxyzkPBrtJ0fkyQ+1gZx4vYGn3oWkhzI1VqK3PCQYngXA==
X-Received: by 2002:ac8:59:: with SMTP id i25mr1700905qtg.110.1583185481122;
        Mon, 02 Mar 2020 13:44:41 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id n8sm10858796qkn.49.2020.03.02.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:44:40 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/6] Affinity devel and fixes
Date:   Mon,  2 Mar 2020 16:44:24 -0500
Message-Id: <20200302214430.15825-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

These are changes to improve affinity on cyclictest

There are some fixes to the parsing of -a CPUSET that occurred in a few
exceptional instances.

Also, cyclictest was written as if it owned the whole machine. So before
these changes we would run on all cpus or on the CPUSET that the user
passed with the command line option even if those cpus were not in the
CPUSET from the affinity in the runtime environment. These changes here
fix that. For example,

Before the changes
taskset 4-7 cyclictest -t -a 1-6
the taskset 4-7 would only apply to the main cyclictest thread, and then
the 1-6 would only apply to every newly created thread.

After the changes
taskset 4-7 cyclictest -t -a 1-6
Now, 4-7 still applies to the main thread, but all newly created threads
run on the interesection of the cpus 4-7 and 1-6, in other words on 4,5
and 6

In addition if the user doesn't pass and affinity with the command line
option, the runtime environment is respected.

For example

Before
taskset 0-4 cyclictest -t
Only the main cyclictest thread would run on cpus 0-4 and the other
threads could run on any cpu

After
taskset 0-4 cyclictest -t
All cyclictest threads run on 0-4


John Kacur (6):
  rt-tests: cyclictest: Set errno to 0 before call to mlock
  rt-tests: cyclictest: Report all errors from pthread_setaffinity_np
  rt-tests: cyclictest: Fix parsing affinity with a space and a leading
    zero
  rt-tests: cyclictest: Fix parsing affinity with leading exclamation
    mark
  rt-tests: cyclictest: Only run on available cpus according to the
    affinity
  rt-tests: cyclictest: Only run on runtime affinity and user supplied
    affinity

 src/cyclictest/cyclictest.c | 78 +++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 7 deletions(-)

-- 
2.20.1

