Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67841C33CB6
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3367B21734
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+p2vlwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAWUum (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38966 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAWUum (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so4907896qko.6
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LKb2DXVR1+teONG3z8uAnn0lkXcnF2rl5GVZJwUQgA=;
        b=W+p2vlwd/KXoat0BaT/VmspQP2svFzQz4T0YIRJlhXiXvt5k0viVeHky5tAQxoSe4b
         A3lwCbII6jEj2dABgGkD/wxnpARoMAMeIeWzPv/NYqZmss5a1+6VGmpKKCLiZp3jX1tn
         7prS60KIqB3+0MVY3bCZgOE52bnLRWJ32CjqotIyLd/9klBwv2V/KYYNC7Fz0sGkll4t
         UkwIPIQqTzrcIrhs/XWYf5+fMsl99yCbCqabuTxi4HtdbIf/t26Z2rAiFtNxHtqR5ovN
         qwK1ddS68CQAet0OA3E+2BL2GbzUZBhBAXXkF1r55ly35mG7qxA+GDBe+25YNAfs9/7c
         thKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1LKb2DXVR1+teONG3z8uAnn0lkXcnF2rl5GVZJwUQgA=;
        b=L66Q2ySSI4YmJs2EPPJGkyLO61Yl6ZDYSuf1iJkkrKJd7IvxdfkXL0DLmI/6fWEjZ0
         9/ScObACXqmW2hwVQSGUVJlI0kPrKah0pcT2oqYl8A2PsuFweoo8QbXhRyxVguMY54FC
         wawKTY+/RHlMdmbDMVj6vCJBohSCwq6C12Q2+QIxlp9XTqJouqX/T5wd6xyqSURgJuYW
         HB+fhAFCqTti6n0VtROc8pn+oEv1O4YRaqKCcE+fspS/kVbXaFaExAiFmPdhDpU+0aCo
         ooCLPhDpnyOsoxOMpsUcNXXmGQOgwp4fG3ZWgLsMLglJZKNff+Ly1RqHZrqSQ+HiDhI7
         0hbQ==
X-Gm-Message-State: APjAAAWl+QxHNE9W46FnbaiKENK8Weql91lGMSSd3YrXHLxZS3Gj+V+E
        1Tm66CqIilAAJ8Xo2Z62sKvRUT6dcGg=
X-Google-Smtp-Source: APXvYqwYltyVk63BQLgM1uw+7bp1VgpBiZDePJ/9QWAF5nvY2QKHKHcBoLNKBk0YLyVC6YdBAWRoNg==
X-Received: by 2002:a37:7b43:: with SMTP id w64mr2901qkc.203.1579812641130;
        Thu, 23 Jan 2020 12:50:41 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:40 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/9] rt-tests: queuelat: Assume queuelat is in the path
Date:   Thu, 23 Jan 2020 21:50:21 +0100
Message-Id: <20200123205029.20176-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The script determine_maximum_mpps.sh in queuelat hard codes the path to
queuelat. Assume that it is in the path.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/determine_maximum_mpps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index 52d54c0f9065..f6cf1dea27cf 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -90,7 +90,7 @@ while [ $queuelat_failure == 1 ]; do
 	echo "$mpps Mpps"
 
 	for i in `seq 1 10`; do 
-		$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
+		$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
 		exceeded=`grep exceeded $OUTFILE`
 
 		if [ ! -z "$exceeded" ]; then
-- 
2.20.1

