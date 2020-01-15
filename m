Return-Path: <SRS0=0v2v=3E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7198AC32771
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jan 2020 18:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4945720728
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jan 2020 18:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOPYVJ9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgAOSo7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:44:59 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37424 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgAOSo6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jan 2020 13:44:58 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so7847135qvi.4
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jan 2020 10:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LKb2DXVR1+teONG3z8uAnn0lkXcnF2rl5GVZJwUQgA=;
        b=dOPYVJ9yyIZb+YucwyvwahQ2u6CSOe17yB++DH5YYXtYIIbqKPyis7qNbRwRR3LK/Z
         OhSkQBGYxh4Gyf7FNXyyX7Qw35En3qHV3LArHNmH3j154G0w1TlBfYExJeeiSyPiLn/W
         f4Sf83J68qTAsWh0Fc8uVYiZUv7UGIdMDT8fqiTlJ1QX8U6TZ3YjWiugXCc7twP6yJZ+
         PWPXr/icOtTFWXVSXyu4wZbgxJy5J+Q2N3CZVeoIxw8XG+7ICpijTFb280101heuWNZC
         6XBOdJVN/GAlNgLhp3Vngc3oWyqb6ZbYfXxmgDtk7pjmRqfHTYRtxAFJejuFStdUjRTn
         eRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1LKb2DXVR1+teONG3z8uAnn0lkXcnF2rl5GVZJwUQgA=;
        b=kwbE4zs8Oz/IyQWie3tSzTisgLCwwKmO4NEpKuR6y6EFizYr7tXfTAWS8hy84UpMrq
         DFSfzd8R+QVsxcGS9ImRL8dVihVNLm32nvr+o+4EbZj54FFLNkIkmEMIKAoPA7lZqWxj
         BOJBVA4k1AyR7RMGIBag6rmdD72m3HhdoY2AEFC5vmbI7QfUnK1nvDnbjBpXSC560dJt
         Y3QtkT8VDWy+paCIOtagyT5PeSgqV1vn3YghyXwd9wHMs8jCKvN3oMeYSJRS1aSJa6SR
         zsQdjoc/x5mRH4FURgOAL0QyBB87Xum6uR161bx4JC/k6D4pWX1HRgk3K8HviDyzQyiD
         9pMg==
X-Gm-Message-State: APjAAAWf8MIZt+mz3I+UwqfJZ56FHR7/EUb/N8baiftmSDuaUBiRbF0d
        P2eIzgaGOA3E6w52aoZU7+vGhlS61zQ=
X-Google-Smtp-Source: APXvYqx22Pw7G3oFJSPlSLKq0++u7jdBDeD5FaXmmT2E6wdDX0Swx33GAz2tgs+PCbfXfqYNhpbnAw==
X-Received: by 2002:a0c:e790:: with SMTP id x16mr27072856qvn.18.1579113897724;
        Wed, 15 Jan 2020 10:44:57 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id o9sm8948502qko.16.2020.01.15.10.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:44:57 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: queuelat: Assume queuelat is in the path
Date:   Wed, 15 Jan 2020 19:44:48 +0100
Message-Id: <20200115184448.13062-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
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

