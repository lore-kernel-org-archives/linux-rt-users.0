Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B2EC433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 May 2021 08:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7DB2610A1
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 May 2021 08:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbhERIie (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 May 2021 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhERIid (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 May 2021 04:38:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254DAC061573
        for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2021 01:37:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so9250853wrr.2
        for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2021 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9rfUKf1MHX2KQGi42xXlTrXLQUJLnWvMK04DoNkBo4=;
        b=hjivsR3PeIgYnERWDWz4eYmjms5OB45+oWvKk6uz4xf3jsGE8dWk6K6MC4jxexNrvR
         R20p31pNotJ0YD3z9mj/RLvd9z0QZnL11eyjMHK/v4JfyJvMgXaFuFgqa7e92QtANnk8
         5d+iV2ll6sKQZ2AQ0KuwkEEBQoYbM6xAW1lboiBCw4Y6xSbBnzaQf2TGmKwPWgxgSmuf
         cXecPmhL58Vn2sx4kEUMCvlt7bXP7ceS1UEAwstwLym8vlQNRup488QlGdA6feeepduf
         rjezFaLHN/Q0bNhkAUmxnFc/UQTNB3OCzkCTk5GNMRiqye8u2NSupIZ8EQbTA6uRbMPA
         MVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9rfUKf1MHX2KQGi42xXlTrXLQUJLnWvMK04DoNkBo4=;
        b=Eq5CnN9pE5Emilc7ZHgPD2bq72X4Rw+9m5AuhQgDnFrx2RUpKlEMzJEafdM9f4vF+B
         9c7chGx2lCWRj3YksDrvGnhXRaNo3XTkHdTTH0rSGJfR0TVob6/x8MZUTy9XGZNYLk+i
         zP+ToK+QVroahmP/ySMOBUCGrQx1tuZ906uq1sWF/3IrXh/vBNupaJtL7XWdUaakoGkN
         Qwsd6kYt4WcjM92/D/8VSCWEpFuhUWkhLmr8YW6nl1HBPVZGK7FCxo3A/NyMMqw5xAI5
         LuMIIcJ4BhxJRldlqUjV3EmFDSEDiOg76TekxxIFkpoju2cyNe+CS+NWJILJoXrlGOWv
         L3pA==
X-Gm-Message-State: AOAM530FOyQHSUWbOijbyWNzK0ZpctknJ5fxIOZH1CYVe0RGOkNCCsIl
        6078Eoq28vwc4xlpmoVt35WZTR7KATfgmQ==
X-Google-Smtp-Source: ABdhPJz1ODEKXiUQEqUsmqE74heQwr0ffZCq8UpiGp0TFtxyrItAKKXYw8GsdG2JscuEtmZ+OUC+gg==
X-Received: by 2002:a5d:5249:: with SMTP id k9mr1602525wrc.301.1621327034824;
        Tue, 18 May 2021 01:37:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c56-8d00-e863-f49d-2f62-8043.c23.pool.telefonica.de. [2a01:c23:6c56:8d00:e863:f49d:2f62:8043])
        by smtp.gmail.com with ESMTPSA id c14sm20439407wrt.77.2021.05.18.01.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 01:37:13 -0700 (PDT)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v4 0/2] rt-tests: cyclictest: Add option to specify main pid affinity
Date:   Tue, 18 May 2021 10:37:10 +0200
Message-Id: <20210518083712.8237-1-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

Changes in v4:
- Rolled back the error wrapper changes around numa_sched_setaffinity.
  I still extracted the error handling code into a function, but since it's
  only used locally it looks a lot nicer.
- Rebased onto latest commit c9051a36 ("ssdd: Add JSON output feature")
  in unstable/devel/latest.


This patch adds the option --mainaffinity to specify the affinity of
the main pid.
This is mainly useful if you want to bind the main thread to a
different (e.g. housekeeping ) CPU than the measurement threads.
Some of the potential benefits of using this option are presented in
a previous email: https://lore.kernel.org/linux-rt-users/dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com/

Jonathan Schwender (2):
  cyclictest: Move main pid setaffinity handling into a function
  cyclictest: Add --mainaffinity=[CPUSET] option.

 src/cyclictest/cyclictest.c | 39 ++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

-- 
2.31.1

