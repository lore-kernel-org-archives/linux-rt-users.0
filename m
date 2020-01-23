Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A37C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF6620684
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z++FPZTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAWUut (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46541 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgAWUus (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so3488779qke.13
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYambi9+6gRZ6zd64W8SKJQfnPAUVoiXAO2XPjEnfVU=;
        b=Z++FPZTqyGAxlN2OEn2BpnvAvFHrA92YLTvs6Cpi19hpi8FSFKhqfeZnLM8vJl+mg/
         2kGjiFLiqknXEvSp2QCxLtbn0SCztc0n0bmcSeEi9GuM/ZZ4xdcWb5l4Izb+lmump1Ko
         1APGKVMXcUdr0KbOZeNGExlLZCO+GL3OdcxdxJw8LSYKuEMDI5h07wXRIK/ilCh75eUY
         +8GXTDRvRA8cfjbkAYzm82Q0/SRjIb+ebOFKoVLPBbboTs3UD3lSDsbJBfPdNoZFO+lw
         H8kpkTEReYiMCE6PhK2+sTRQ6YAm5HV1PxGQ4RRwFJjSPg937/s/MmvjIxqSnZqhCIxc
         MWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oYambi9+6gRZ6zd64W8SKJQfnPAUVoiXAO2XPjEnfVU=;
        b=mPvpAXjyGNghQfq6ZpDpWecPQi4YOfPOSIsn/iWmm2XrN1PzunbnK7WmAYXPsp6Xq7
         13v+pIjYBNTkdedfZ72VYfms0fW8udLWQslFHdx1ekrF4buF5KL7TXxM6ltzSazxBaNb
         wp2Lryl7iNARKyVlrMZgoEWwU/qPbOeGxa+43AKgN6jo3Vnrph9m10KnSXuQMumfQM87
         CTmTUIrKixsdI7zj3XydJQI6FsYzbSQq2O7CwQEcPyqaOmv5DNOqkeSDO1iO3nBfuuVN
         gPuF71GkNpY/jhg/ytnOHL1va9JFYhavR0amAqowMQo31YdYb1KEyOm2yaNlTJSIl3x5
         1FDg==
X-Gm-Message-State: APjAAAUokXe/FdAhSzNeOcdXQqJKbxgdD/sDSg7XSQqNIdfCUuP/+aEZ
        EsDcMDqS/oDwM+6fbg4WsQX5TNgDv/c=
X-Google-Smtp-Source: APXvYqysdGzcoVdgsJ7OxjNlME5R6eIR+fwBLip27a3Fjsk5QCZLPATexFVWEU4VB5Laxyl+0GexgQ==
X-Received: by 2002:ae9:e910:: with SMTP id x16mr74155qkf.90.1579812647128;
        Thu, 23 Jan 2020 12:50:47 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:46 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/9] rt-tests: determine_maximum_mpps.sh: Fix quoting and other shell issue
Date:   Thu, 23 Jan 2020 21:50:26 +0100
Message-Id: <20200123205029.20176-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix a number of issues in the script determine_maximum_mpps.sh such as
1. Convert legacy backticks to $(...) notation
2. Double quote where necessary to prevent globbing
3. Double quote where necessary to prevent word splitting.

Note: these fixes are more than just cosmetic, they are needed for the
script to work correctly.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/determine_maximum_mpps.sh | 75 +++++++++++++-------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index f6cf1dea27cf..f785147f1bbd 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -17,65 +17,65 @@ echo "Determining maximum mpps the machine can handle"
 echo "Will take a few minutes to determine mpps value"
 echo "And 10 minutes run to confirm the final mpps value is stable"
 
-for mpps in `seq 3 3 50`; do
-	echo testing $mpps Mpps
+for mpps in $(seq 3 3 50); do
+	echo testing "$mpps" Mpps
 
-	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
+	OUTFILE=$(mktemp)
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
 
-	exceeded=`grep exceeded $OUTFILE`
+	exceeded=$(grep exceeded "$OUTFILE")
 	if [ ! -z "$exceeded" ]; then
-		echo mpps failed: $mpps
+		echo mpps failed: "$mpps"
 		break;
 	fi
 	echo success
 done
-echo first loop mpps: $mpps
+echo first loop mpps: "$mpps"
 
 first_mpps=$(($mpps - 1))
-for mpps in `seq $first_mpps -1 3`; do
-	echo testing $mpps Mpps
+for mpps in $(seq $first_mpps -1 3); do
+	echo testing "$mpps" Mpps
 
-	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
+	OUTFILE=$(mktemp)
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
 
-	exceeded=`grep exceeded $OUTFILE`
+	exceeded=$(grep exceeded "$OUTFILE")
 	if [ -z "$exceeded" ]; then
-		echo mpps success $mpps
+		echo mpps success "$mpps"
 		break;
 	fi
 	echo failure
 done
 
-second_mpps=`echo "$mpps + 0.3" | bc`
-echo second loop mpps: $mpps
+second_mpps=$(echo "$mpps + 0.3" | bc)
+echo second loop mpps: "$mpps"
 
-for mpps in `seq $second_mpps 0.3 $first_mpps`; do
-	echo testing $mpps Mpps
+for mpps in $(seq "$second_mpps" 0.3 $first_mpps); do
+	echo testing "$mpps" Mpps
 
-	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
+	OUTFILE=$(mktemp)
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
 
-	exceeded=`grep exceeded $OUTFILE`
+	exceeded=$(grep exceeded "$OUTFILE")
 	if [ ! -z "$exceeded" ]; then
-		echo mpps failure $mpps
+		echo mpps failure "$mpps"
 		break;
 	fi
 	echo success
 done
 
-echo third loop mpps: $mpps
-third_mpps=`echo "$mpps -0.1" | bc`
+echo third loop mpps: "$mpps"
+third_mpps=$(echo "$mpps -0.1" | bc)
 
-for mpps in `seq $third_mpps -0.1 3`; do
-	echo testing $mpps Mpps
+for mpps in $(seq "$third_mpps" -0.1 3); do
+	echo testing "$mpps" Mpps
 
-	OUTFILE=`mktemp`
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `sh get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
+	OUTFILE=$(mktemp)
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
 
-	exceeded=`grep exceeded $OUTFILE`
+	exceeded=$(grep exceeded "$OUTFILE")
 	if [ -z "$exceeded" ]; then
-		echo mpps success $mpps
+		echo mpps success "$mpps"
 		break;
 	fi
 	echo failure
@@ -89,14 +89,14 @@ while [ $queuelat_failure == 1 ]; do
 	echo -n "Starting 10 runs of 30 seconds with "
 	echo "$mpps Mpps"
 
-	for i in `seq 1 10`; do 
-		$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p "$mpps" -t 30 > $OUTFILE
-		exceeded=`grep exceeded $OUTFILE`
+	for i in $(seq 1 10); do
+		$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
+		exceeded=$(grep exceeded "$OUTFILE")
 
 		if [ ! -z "$exceeded" ]; then
 			echo "mpps failure (run $i) $mpps"
 			export queuelat_failure=1
-			mpps=`echo $mpps - 0.1 | bc`
+			mpps=$(echo "$mpps" - 0.1 | bc)
 			export mpps
 			break
 		fi
@@ -113,19 +113,20 @@ while [ $queuelat_failure == 1 ]; do
 	echo -n "Starting 10 minutes run with "
 	echo "$mpps Mpps"
 
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f `get_cpuinfo_mhz.sh` -p "$mpps" -t 600 > $OUTFILE
-	exceeded=`grep exceeded $OUTFILE`
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz.sh)" -p "$mpps" -t 600 > "$OUTFILE"
+	exceeded=$(grep exceeded "$OUTFILE")
 
 	if [ ! -z "$exceeded" ]; then
 		echo "mpps failure (run $i) $mpps"
 		export queuelat_failure=1
-		export mpps=`echo $mpps - 0.1 | bc`
+		mpps=$(echo "$mpps" - 0.1 | bc)
+		export mpps
 		continue
 	fi
 	echo "run $i success"
 done
 
-echo Final mpps is: $mpps
+echo Final mpps is: "$mpps"
 
 unset queuelat_failure
 unset mpps
-- 
2.20.1

