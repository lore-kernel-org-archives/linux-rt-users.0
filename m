Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB853C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FBD60E97
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 19:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhGWSgB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSgB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 14:36:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F16AC061575
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 12:16:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t68so2376637qkf.8
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksSUnKHBcEOj6p+ZaWU9Ju9dGBYY2A2wJ6o6PuO/EmM=;
        b=F9Y5VwkKhDz+oOTX3QmJBnexnFXFqt/RA2HFwjseLLj1QAkQDm71vzhAFrl7uOF0S0
         4iwW7Dh9PVknxruBmdcJvT7I48J1jXocWcXqL2eDjGbSAlhCbbZ1j59gFlapXIpgJBbq
         IQh4zYSZDmKc01ApB2d1diYLHbXQu2k9K8pZzcvLrQM2ss0Zupk5n1cFaDXAaQTaxGlw
         1C/RtJ/LwrmEbJb5JME28pQZA+LiGP+BTX3Pfm90DKRSZR7HxsAXckhQ8TFlxP9naapG
         kogYO90Ck3i7vqsn1UrOS2sh0zFOXoXPSPGzUxSfskj+gH+3xP7p71KHl7OHas1hGfZt
         YOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ksSUnKHBcEOj6p+ZaWU9Ju9dGBYY2A2wJ6o6PuO/EmM=;
        b=o1zGu/1j9P9sqzENzYJUds1F9GbL5xjNaLFW1QxQNhOu4Td06nbe6UWbk3xJhbSx1s
         3q6mzg8uyGySNu+QKEmamSCcVyksP9cHQPmJJ/qBR1Z1DbKZCFXI9EMRhajP7HZ5kTze
         rxCM650Sk4eXtnN8nJFrPyfRBukh6V7gwLkvDiu7LbyxONdb8hV7JAf4XNK/iRQjIH06
         nEg5fWYjVzbJb3wziFNJbJI+sVoB6d6YRVSZK77QZ3/3n5qu0OA0xaqytaziJjzoDMk7
         QGxI5QDTnzrej1HIc3UvV598yDbE2PulZ7jm4YP5Oz0tW2iuvfYQJqN21j4uGT79a14K
         bNFw==
X-Gm-Message-State: AOAM531O9uBojog5U3q1ApcaOa7yP8d3d+QvyWPZkSxg8URgkj6YmZhb
        DEFtaV/Tg4IVd4+Iok0x7DrTChpgz/uNJg==
X-Google-Smtp-Source: ABdhPJzLTtni0LfQe6Ofu8x+DabhT65CXYADY3Y1ffLym8UOM63WXQtgBvZ4GzqfN4znXj+7AoZm2w==
X-Received: by 2002:a05:620a:4543:: with SMTP id u3mr6113873qkp.326.1627067793255;
        Fri, 23 Jul 2021 12:16:33 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id a3sm7379274qtx.56.2021.07.23.12.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:16:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Daniel Bristot de Oliveria <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/2] sched_deadline: HRTICK for newer kernels
Date:   Fri, 23 Jul 2021 15:16:07 -0400
Message-Id: <20210723191609.14072-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Newer kernels have HRTICK_DL which is a HRTICK for the deadline
scheduler only.

In addion newer kernels rename
/sys/kernel/debug/sched_features
to
/sys/kernel/debug/sched/features

These changes use HRTICK_DL if available and make use of the
new file name in a backwards compatible manner.

These changes are based on changes in util.c in the stalld program.
The stalld program itself was based on code in the sched_deadline
programs in this suite.

John Kacur (2):
  sched_deadline: Accommodate new location of HRTICK file in kernel
  sched_deadline: Use HRTICK_DL for sched_deadline tests

 src/sched_deadline/cyclicdeadline.c | 92 +++++++++++++++++++++++------
 src/sched_deadline/deadline_test.c  | 89 ++++++++++++++++++++++------
 2 files changed, 145 insertions(+), 36 deletions(-)

-- 
2.31.1

