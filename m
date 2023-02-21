Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189AFC61DA3
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 19:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBUT7W (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBUT7R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 14:59:17 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D730E83
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:12 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ff4so6114937qvb.2
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYXobIvVTgGsW9oGJD74hfQDZ0Za6YQQ4h/YjlaBOV4=;
        b=iGm9TnApIbH02EBIeijL1Q4Q89OcTqypdHfMpcmiC4rdcNhRWscUj4p1qIc+/WyJhj
         kwFZHIfetU4ZwYFNeK60gLhROMK40AjpuhtcfBFZ4fJZnfIG2/1uLT1x0sWaVqu75KPr
         MO0fEUp/xIg7Jf7jabNvRxr1fuoC1hIoKFyl5kEn5NpA++x6nontVeGXi+3IHRifusbK
         fxjjWk3iP0i2rGjUzNrNGWQTP0oxQ0lH2uW2Yz70m4z8Ts9GzS8HE8HmwzG4eLyXh1G/
         4aEIxaxhGDEfB3fvRrL1FK22/ljd56EjOVM1h1quQD0aj0L0nC87CvuzeXzE0YHhc2X0
         z4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYXobIvVTgGsW9oGJD74hfQDZ0Za6YQQ4h/YjlaBOV4=;
        b=xrKnmyiXDx75lzZebCIEqAmin6RhnK/0DnU+xnN6iu+E12fr5obmlzCWazGZqgh31A
         ub/jvQJaEt/A86Jgw36XDmvnIU/spAInvNdDfbzgAJQC6GbZ/+pjaN3pCzX8fpdPsFYd
         fVPCEr34TUtBGtiRP8yCQmPBH7giOamUBwDTKL+5W9D2Mbuzvro54Jox4uyDagas8LXu
         mokonRzRPyyW2kU84P/8gFeFMTeJvNp54iF6Q2KqOyOyjVcqRZRAvCDn9KCW8GtKO+N4
         W/91vrY9l13cJ/XQSwz7bpH+0/Jc+uDrj9o/QRCM2vwmS8INzzJ7i/SLlviDmp0XnA7F
         I0rg==
X-Gm-Message-State: AO0yUKUmjWrdI/XA1mLy23Ok3AqtaACMdBf0lNo+RKVOmGFgmnxOdhpF
        9fqgCf9Mmlj9kQLbjxoCYk14kiRzkDg=
X-Google-Smtp-Source: AK7set/ZSo1EaqGDO9U8134cyRDape3hBA6WSQ0Jk1Tg9fe6mMgMOtOVLeiIN8gS1LyA1U9/IL3yqw==
X-Received: by 2002:a05:6214:20aa:b0:53a:bf63:b053 with SMTP id 10-20020a05621420aa00b0053abf63b053mr7888172qvd.45.1677009549743;
        Tue, 21 Feb 2023 11:59:09 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b00742301f1bfbsm758934qke.45.2023.02.21.11.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:59:08 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 14/14] rteval: Update version number to v3.6
Date:   Tue, 21 Feb 2023 14:58:28 -0500
Message-Id: <20230221195828.17919-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221195828.17919-1-jkacur@redhat.com>
References: <20230221195828.17919-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Update version number to v3.6

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval.spec       | 2 +-
 rteval/version.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval.spec b/rteval.spec
index f6cacc878582..d1d9d10a461b 100644
--- a/rteval.spec
+++ b/rteval.spec
@@ -2,7 +2,7 @@
 %{!?python_ver: %define python_ver %(%{__python} -c "import sys ; print sys.version[:3]")}
 
 Name:		rteval
-Version:	3.5
+Version:	3.6
 Release:	1%{?dist}
 Summary:	Utility to evaluate system suitability for RT Linux
 
diff --git a/rteval/version.py b/rteval/version.py
index 3c352e16997b..bedec09c0bdf 100644
--- a/rteval/version.py
+++ b/rteval/version.py
@@ -23,4 +23,4 @@
 #   are deemed to be part of the source code.
 #
 
-RTEVAL_VERSION = '3.5'
+RTEVAL_VERSION = '3.6'
-- 
2.39.1

