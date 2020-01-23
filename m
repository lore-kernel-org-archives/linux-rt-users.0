Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E963C33CAF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2001E20704
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn7312Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWUus (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:48 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:42519 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAWUuq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:46 -0500
Received: by mail-qk1-f180.google.com with SMTP id q15so4890249qke.9
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mivVD0DzAEBKCAL0rrY4RlgH4oPOxnZhwxutwKKKZlk=;
        b=hn7312ZyCFufVo8MUgmt3gudG+//uaaCTbPdWwfIdrWecA9jM7lChuxMGAv99jpaLA
         K5ha0vuRXOrN0NbE34PkW+q68JXdl2OJpPmmdYZf2vOHRWJ45AI+LWQ91brHKMcNunFd
         8C80mJfePunyTAW4qUn0mf1yOHzOVayeBKgx0vHaKpEkL67rGOiRv2H1zDnzWGBlgPbr
         o8rYzu2kQsmi6VK7Tg7gzHE7c/UGcnd3Orsib2qV67il9X64HUYmPNXSZUXCk/HTh3TN
         seVaSuK1iCDF/4zVu6GtIg7wMJRKeYRP9PmFkroOXIYdkp7iGddm9D5y7pITeb/J6vDq
         mf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mivVD0DzAEBKCAL0rrY4RlgH4oPOxnZhwxutwKKKZlk=;
        b=iHH50rEq3OsB4+QJ3pYLmViYZ+K+uf66yBrgOuJMKJLx5diIItkZW6GqVc3BsZkq2N
         M1z/6WRlcrPChDrjfXGdV34oJedb60TN15ALdiOxcL04vUMX/TZ9nwEtz2J7miR1hsN9
         kSlGPRWautPgrzfWUYujU9lnuCoXBoE9mCWUTwSTK0uD3qe9atpC884XoVokzvKx+IBu
         kc2smaViPloF8K2zelB+vDnImLq1nTu1YC3TwVrO5QpTnIDfEbBTrg97cBrgnQ3L9qAQ
         ywjrDYIVDK4JNA+J6IL2zfxsiXWFryav7kLhbs6rS68hfKMtPdPIEbwh9T2BupSIOCAY
         SQmA==
X-Gm-Message-State: APjAAAV2GuB9YpCl0ZKYF3mmicR3zGFYA64TvRopRAKXo2oN+7QZqEk2
        4yo1H9u38OCKnA+wFjA0LHpLF26RNNY=
X-Google-Smtp-Source: APXvYqyHm0Bu61VZ4kfyxNfpivhRpMYMxD6CbddIIyERpHsoMNm8OPAch/pif0Rd7hBx48ZaGEpbXA==
X-Received: by 2002:a37:e317:: with SMTP id y23mr18189137qki.431.1579812645537;
        Thu, 23 Jan 2020 12:50:45 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:45 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/9] rt-tests: queuelat: get_cpuinfo_mhz.sh highest value
Date:   Thu, 23 Jan 2020 21:50:25 +0100
Message-Id: <20200123205029.20176-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

get_cpuinfo_mhz.sh greps for the Mhz from the /proc/cpuinfo file
It assumes that for multiple cpus the value will be the same, and
intends to return one value using uniq as a filter.

Typically the reported Mhz values can all be slightly different though
It would probably be good enough to simply take the first match as a
heuristic, but to be safe, take the highest number.

Also replace the legacy backticks with the modern $(...) construct, and
quote the $mhz variable.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/get_cpuinfo_mhz.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/queuelat/get_cpuinfo_mhz.sh b/src/queuelat/get_cpuinfo_mhz.sh
index eafdd9577424..14a2c12c478f 100755
--- a/src/queuelat/get_cpuinfo_mhz.sh
+++ b/src/queuelat/get_cpuinfo_mhz.sh
@@ -3,6 +3,5 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2018 Marcelo Tosatti <mtosatti@redhat.com>
 
-mhz=`cat /proc/cpuinfo  | grep "cpu MHz" | uniq | cut -f 3 -d " "`
-echo $mhz
-
+mhz=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
+echo "$mhz"
-- 
2.20.1

