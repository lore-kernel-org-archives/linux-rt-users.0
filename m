Return-Path: <SRS0=qZJ4=ZR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC8BC432C3
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E1A20748
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Nov 2019 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRgtwADe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfKYOQ7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:16:59 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35192 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfKYOQ6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Nov 2019 09:16:58 -0500
Received: by mail-wr1-f48.google.com with SMTP id s5so18239628wrw.2
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Nov 2019 06:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BE/ixBDz2uefIeZm3eBpGx4ciq3LF4T6nkUrWhM2m6Q=;
        b=bRgtwADeUZi8cLjAb84mOmBCpeOdEtzgG0Arc0krfOZcoOCRh/ndBBxi9wOIRDRfec
         tGKUjo6hZ5bXLV2cwIM+OjNzujG6ejOP5qVRl4tuvZ8HcODQnOdTqSUt3LjENXnhG2dH
         FgU9B9pHrOhXhOIesfUSehL1THBtI0PuEr3bMMvzf4GFXtIRsS98QWDArit7j0Xt/k1e
         eFKmHxSVVVinFiC8vBEMLkfuBkTZA0gSnET4Oxn23jf2+Gy6uJvJEgYQlWu4BriD7mCD
         yFbxL22creU7Dec7BBHRDOhUVepwPyErNE95RgPR2qqbaCm+Gt8+LYhvdV2LHy46U/N2
         uSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=BE/ixBDz2uefIeZm3eBpGx4ciq3LF4T6nkUrWhM2m6Q=;
        b=l8CreNnt/pX9k3wSPnWMSESU5rWmmNhwabvmJwdP5/yqGUEN8Oz3ddoJx1X3vPmp1q
         xzq/XoaP1oo+yenSPZSDbOf0eV4e/X/jU/hUthsZX8LQAKQC2SSBRc6HreZKdS2x5FiL
         hgHhTIBCGToWg4BL3ZJfT6ALiny1XZjrsrm258fYo97I1jPK/8abBvWkI2k7rgVlAf7n
         3UR0XY5JFt7XAGpCvKGT6Nl0avbJMSODcNJYOo/GCSvvfUXP+Pi5UWkarFnx8z90CP88
         wwNT5IqCIXMciyhMMnvoqHIEaCgq8qyz+wu6TU8SH5/pdnznwd404KCYjr014mV6qDq2
         PRkA==
X-Gm-Message-State: APjAAAWP6Ua/cE/iMMpFBwD+uJ/ELABgrcxq8hMgmuyJPTvuD0FXScWF
        F0aX/hFWSqEAaDzSwappaDD2L/PDZss=
X-Google-Smtp-Source: APXvYqyM74OLiILwbvEX+e3nRwI0h0c5u/oN13fCWIph2xmYPA142iCDA9AxDjrYpcekcS2kU9J6Gg==
X-Received: by 2002:adf:da4c:: with SMTP id r12mr31998038wrl.30.1574691416759;
        Mon, 25 Nov 2019 06:16:56 -0800 (PST)
Received: from planxty.redhat.com (ip1f122014.dynamic.kabel-deutschland.de. [31.18.32.20])
        by smtp.gmail.com with ESMTPSA id q5sm8463456wmc.27.2019.11.25.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:16:55 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/8] rt-tests: queuelat: Fix some warnings in determine_maximum_mpps.sh
Date:   Mon, 25 Nov 2019 15:16:39 +0100
Message-Id: <20191125141644.4429-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Coverity advises to quote some values to prevent word splitting and to
export variables separately after declaraing them to avoid masking
errors.

Fix these warnings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/determine_maximum_mpps.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index cd45454720f7..3acd6ba2e362 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -18,7 +18,7 @@ for mpps in `seq 3 3 50`; do
 	echo testing $mpps Mpps
 
 	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
 
 	exceeded=`grep exceeded $OUTFILE`
 	if [ ! -z "$exceeded" ]; then
@@ -34,7 +34,7 @@ for mpps in `seq $first_mpps -1 3`; do
 	echo testing $mpps Mpps
 
 	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
 
 	exceeded=`grep exceeded $OUTFILE`
 	if [ -z "$exceeded" ]; then
@@ -51,7 +51,7 @@ for mpps in `seq $second_mpps 0.3 $first_mpps`; do
 	echo testing $mpps Mpps
 
 	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
 
 	exceeded=`grep exceeded $OUTFILE`
 	if [ ! -z "$exceeded" ]; then
@@ -68,7 +68,7 @@ for mpps in `seq $third_mpps -0.1 3`; do
 	echo testing $mpps Mpps
 
 	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
 
 	exceeded=`grep exceeded $OUTFILE`
 	if [ -z "$exceeded" ]; then
@@ -87,13 +87,14 @@ while [ $queuelat_failure == 1 ]; do
 	echo "$mpps Mpps"
 
 	for i in `seq 1 10`; do 
-		$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
+		$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
 		exceeded=`grep exceeded $OUTFILE`
 
 		if [ ! -z "$exceeded" ]; then
 			echo "mpps failure (run $i) $mpps"
 			export queuelat_failure=1
-			export mpps=`echo $mpps - 0.1 | bc`
+			mpps=`echo $mpps - 0.1 | bc`
+			export mpps
 			break
 		fi
 		echo "run $i success"
@@ -109,7 +110,7 @@ while [ $queuelat_failure == 1 ]; do
 	echo -n "Starting 10 minutes run with "
 	echo "$mpps Mpps"
 
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p $mpps -t 600 > $OUTFILE
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p "$mpps" -t 600 > $OUTFILE
 	exceeded=`grep exceeded $OUTFILE`
 
 	if [ ! -z "$exceeded" ]; then
-- 
2.20.1

