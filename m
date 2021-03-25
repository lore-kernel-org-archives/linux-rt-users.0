Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A72C433C1
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA9161A3D
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 20:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCYUSq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhCYUSl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 16:18:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D19C06174A
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 13:18:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jy13so5035786ejc.2
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaHBsmSjc0LhjW14QjxAma7W51tMV92cZlIPC32xDFg=;
        b=hrJWia4GuHJ5koVjUOi+wx1d6MVXEPPWfNJw7zfI9XOmZN97fPIQCONGOUcKfMgQIk
         96yO7m+naNnLiPgO9kmRzkf7C8ZSy4nuyqN8KGyWxymHelSz+xBZ8Ul35sJBspqfbvhL
         WUNyH8KLyJJICOKBYcJ1KDim9NJozQ4gv7fUQ52g/WI+mnoOZvtUml/G6ZYZsutT0dHd
         MHLaJgwGaUAwJdTUd1BfqviNFsiB0OrwiHlLs+wEuic7A4WR5xqVncKECd7cs0/+cIg3
         nA/6xtozKOTJ3WGOZINVqgUk/U3tAsupEF10Uz1FHIjl2jKdqsz3Kr1PHpWYz8lQrFDd
         w0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaHBsmSjc0LhjW14QjxAma7W51tMV92cZlIPC32xDFg=;
        b=pKxMfbizCa4St5FKRg4CgD9bYnxTcnUS+qF29PQ+OAjF1d/tnm0P5NwYkk8xizpTJ/
         vGJ6eAenA4SYZEaoArwJNVUOc0Wjhoia8bWwH+ediCFUhKaL4f8obLN2Ks6LxPT/JTt7
         azOb8bBiGnrK1o0ct614yyvFFiKA3XUiGUpSEwYVIOYlcK3ux1aTS+1vsRqR/Q/yhmls
         rHP0mQimbxKzF2h20lcsU7GLfcKhHHoEGtfjPTMsRYfqi0AcbHR27MNUe2XJXj7FgpYX
         8EZKT9AJw/T03nQcz/TrDxjBeUCx0IwpfrcIgRXIAkHAgz7hbuc9Cnd8txzBAkMs4WVr
         22fQ==
X-Gm-Message-State: AOAM530MLS4r23uqD7UApROAL5FqwZpJ0pBUxvG+gpgluV0YyJbf7IdN
        0zfG8fdh+LIKQ65SUrmLzxeSJBG8Fe71+Q==
X-Google-Smtp-Source: ABdhPJzjOGtDggA4boSwr1FgAe5pS61sNwq/GxinPJo4yTo23iZseJaUlnBiJpxlIUW3rSgQde/r3w==
X-Received: by 2002:a17:906:4cd9:: with SMTP id q25mr11390938ejt.187.1616703519772;
        Thu, 25 Mar 2021 13:18:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c47-0000-17ef-d1e1-78a0-d19c.c23.pool.telefonica.de. [2a01:c23:6c47:0:17ef:d1e1:78a0:d19c])
        by smtp.gmail.com with ESMTPSA id a22sm3135406edu.14.2021.03.25.13.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 13:18:39 -0700 (PDT)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v3 0/2] rt-tests: cyclictest: Add option to specify main pid affinity
Date:   Thu, 25 Mar 2021 21:18:35 +0100
Message-Id: <cover.1616702706.git.schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

Changes in v3:
Rebased onto latest commit 95066b1a1a0a ("cyclicdeadline.c: Fix printf format specifier")
in unstable/devel/latest.


This patch adds the option --mainaffinity to specify the affinity of
the main pid.
This is mainly useful if you want to bind the main thread to a
different (e.g. housekeeping ) CPU than the measurement threads.

Some numbers on potential latency benefits are linked in the
v1 thread at https://lore.kernel.org/linux-rt-users/dd40b81d-7099-7740-c2ad-64b49e582234@gmail.com/

Regards

Jonathan


Jonathan Schwender (2):
  cyclictest: Move main pid setaffinity handling into a function
  cyclictest: Add --mainaffinity=[CPUSET] option.

 src/cyclictest/cyclictest.c | 28 +++++++++++++++++++---------
 src/include/rt-numa.h       |  2 ++
 src/lib/rt-numa.c           | 11 +++++++++++
 3 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.30.2

