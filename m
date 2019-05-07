Return-Path: <SRS0=qtLW=TH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1866DC004C9
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 May 2019 15:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB449206BF
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 May 2019 15:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqvgedBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfEGPgU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 May 2019 11:36:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51900 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfEGPgP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 May 2019 11:36:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id o189so10124540wmb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 May 2019 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw1yX7360ZXgG8qpW6fWS0om7/wX9yg5+GQxfNfWlNI=;
        b=IqvgedBgQUsazTSjVUb2BvcvphCrdmL2vIYOU3aQ3zLIBX53Io/e+KHkLQdEoi9ieZ
         GCbSHW56UGi0qsLEi3I6LbhWCQ48tEYIv1UPZMUX/cAplc4WrBgSz9TCZrPTv3DeKxlC
         8bEoWAuUWA+VNNPqJUsS1p1r0bAGJ/txtomZZF6lWtP7IdEyGIKScbmS542IN2Lmkayp
         FQPDv5f+M2SGpJjCcE6NjSlp/zfV7vCl8ArBJVBZYJet8nMgg8gGQbdiqv/zd7huwB8O
         vQi6yFixncmuPql7JxtYD4cJS5YVX70MecN2cEK2xhhAM8W3OpLJbkcM5trdpHvlNXoD
         MMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hw1yX7360ZXgG8qpW6fWS0om7/wX9yg5+GQxfNfWlNI=;
        b=AGl1DEz/ggVFCeHlaYkgeNmx3N3cUwRkG4EZ0O2nq9dhb1M7zmxVlJH0tI/2jL1L5p
         D090wOzfddPKVznzIIscK9MznJ39ciXCLkrgvoYLMZ0Ot52w26BlG9erF5it9m5jYB8n
         QI29pR3dbHV0xMxRV21qHT2bupS8j3uXZ/eAw46vQxx3dxYoBdXmmB44Qbs0uAngC2Fi
         ex3sZOEfmHD/kfubEu+OG4xUNzOfR5psEmMODF84/sZg1NEbE25DuAoTpD2f95NKnVhh
         wxInLr30F9H2WD/HBFGH3qPn7QmNWDH2aSmbL0932C/Pn5I0mv1CPKwW/y/Uq3PJeC9j
         j5uw==
X-Gm-Message-State: APjAAAXm8sBmZznXZoooCcCVGAg8iaKXSQmTMSB8rtkbBbCvtyoWlOqB
        GFNS9ECBCFmRd6xXdVQSRM+Egf9F
X-Google-Smtp-Source: APXvYqwhNS7UcxZc+z+IA6hblis9lNA+rSsRPTI9peQ3SARgmVoxJxHYXGVJ2pPSeZH2qsKleXy04w==
X-Received: by 2002:a05:600c:205a:: with SMTP id p26mr20525643wmg.11.1557243373068;
        Tue, 07 May 2019 08:36:13 -0700 (PDT)
Received: from planxty.redhat.com ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id l19sm19753463wrg.29.2019.05.07.08.36.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 08:36:12 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] queuelat: Assume queuelat and queuelat scripts are in the path
Date:   Tue,  7 May 2019 17:35:58 +0200
Message-Id: <20190507153559.16109-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Assume queuelat and queuelat scripts are in the path. Don't hardcode
their location.

Write the temporary data to /usr/tmp/outfile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/determine_maximum_mpps.sh | 35 +++++++++++++-------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index cf7a8cab9cc4..cd45454720f7 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -8,6 +8,7 @@
 PREAMBLE="taskset -c 2 chrt -f 1"
 MAXLAT="20000"
 CYCLES_PER_PACKET="300"
+OUTFILE=/usr/tmp/outfile
 
 echo "Determining maximum mpps the machine can handle"
 echo "Will take a few minutes to determine mpps value"
@@ -16,10 +17,10 @@ echo "And 10 minutes run to confirm the final mpps value is stable"
 for mpps in `seq 3 3 50`; do
 	echo testing $mpps Mpps
 
-	outfile=`mktemp`
-	$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh ./get_cpuinfo_mhz.sh` -p $mpps -t 30 > $outfile
+	OUTFILE=`mktemp`
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
 
-	exceeded=`grep exceeded $outfile`
+	exceeded=`grep exceeded $OUTFILE`
 	if [ ! -z "$exceeded" ]; then
 		echo mpps failed: $mpps
 		break;
@@ -32,10 +33,10 @@ first_mpps=$(($mpps - 1))
 for mpps in `seq $first_mpps -1 3`; do
 	echo testing $mpps Mpps
 
-	outfile=`mktemp`
-	$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh ./get_cpuinfo_mhz.sh` -p $mpps -t 30 > $outfile
+	OUTFILE=`mktemp`
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
 
-	exceeded=`grep exceeded $outfile`
+	exceeded=`grep exceeded $OUTFILE`
 	if [ -z "$exceeded" ]; then
 		echo mpps success $mpps
 		break;
@@ -49,10 +50,10 @@ echo second loop mpps: $mpps
 for mpps in `seq $second_mpps 0.3 $first_mpps`; do
 	echo testing $mpps Mpps
 
-	outfile=`mktemp`
-	$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh ./get_cpuinfo_mhz.sh` -p $mpps -t 30 > $outfile
+	OUTFILE=`mktemp`
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
 
-	exceeded=`grep exceeded $outfile`
+	exceeded=`grep exceeded $OUTFILE`
 	if [ ! -z "$exceeded" ]; then
 		echo mpps failure $mpps
 		break;
@@ -66,10 +67,10 @@ third_mpps=`echo "$mpps -0.1" | bc`
 for mpps in `seq $third_mpps -0.1 3`; do
 	echo testing $mpps Mpps
 
-	outfile=`mktemp`
-	$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh ./get_cpuinfo_mhz.sh` -p $mpps -t 30 > $outfile
+	OUTFILE=`mktemp`
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
 
-	exceeded=`grep exceeded $outfile`
+	exceeded=`grep exceeded $OUTFILE`
 	if [ -z "$exceeded" ]; then
 		echo mpps success $mpps
 		break;
@@ -86,8 +87,8 @@ while [ $queuelat_failure == 1 ]; do
 	echo "$mpps Mpps"
 
 	for i in `seq 1 10`; do 
-		$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `./get_cpuinfo_mhz.sh` -p $mpps -t 30 > $outfile
-		exceeded=`grep exceeded $outfile`
+		$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p $mpps -t 30 > $OUTFILE
+		exceeded=`grep exceeded $OUTFILE`
 
 		if [ ! -z "$exceeded" ]; then
 			echo "mpps failure (run $i) $mpps"
@@ -108,8 +109,8 @@ while [ $queuelat_failure == 1 ]; do
 	echo -n "Starting 10 minutes run with "
 	echo "$mpps Mpps"
 
-	$PREAMBLE ./queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `./get_cpuinfo_mhz.sh` -p $mpps -t 600 > $outfile
-	exceeded=`grep exceeded $outfile`
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p $mpps -t 600 > $OUTFILE
+	exceeded=`grep exceeded $OUTFILE`
 
 	if [ ! -z "$exceeded" ]; then
 		echo "mpps failure (run $i) $mpps"
@@ -124,5 +125,3 @@ echo Final mpps is: $mpps
 
 unset queuelat_failure
 unset mpps
-
-
-- 
2.20.1

