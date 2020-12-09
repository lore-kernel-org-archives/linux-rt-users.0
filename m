Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91DCC4361B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 18:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A36A23C91
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 18:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgLISbw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 13:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgLISbv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 13:31:51 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A4C0613CF
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Dec 2020 10:31:11 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h19so1645041qtq.13
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Dec 2020 10:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vDbguaFaiW+mRHHyHfvUoAWMBWrywSCQI06YBL7kA8=;
        b=sr6kKfrQFnwQSsH0ZNhfgX3bbtFTWCAvLWtTqVFrquSKDHlLLcV/WfdKnG8hsKiVmN
         LBQj5qPb92ToGNTfTqF1rz0YbOne0AltUQQ3TnrWl/UNcBerYL83v8xkJu34L+iYKbiO
         k1GSclHWMOx7UPNDRgxmFX/tAncLb+fGMRO51YyyKtL1U9oICsF9BWvFcZllg5oWHcg8
         bF5DJmyjp0Xt360lXci8+UX6Y9625pbUOGDGn0oQ4yxy/2ARc8GCryUgD6VGb//Ry6Vh
         O3o0BfB42HlH7lEXJXKfYuMnPb2Zj+ZbkV+7GAEdAg+7Y2tpzH605gK4q/LG+ssrsr6c
         onPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9vDbguaFaiW+mRHHyHfvUoAWMBWrywSCQI06YBL7kA8=;
        b=fAbyeFGZLrv3CS2wUb6Awn5a+c8umDJ/gOhBlToCbwwY75YI63cRJGi7qiHf5UNBpu
         jyK233SFRz+wfIDjGZaf80vU+QxRzGwTxG312j2TDdIogahlsyJ0DCkb4eNVMzJQe2Jk
         T4NcLNu6plbzcxI48HwVpvc0mqHKk871sJrZGmxlp1LW0OPYQ/tNa4sxz16pb8Tp/nL0
         cFtCnqP565whOIU/wejEiviCcXm6eqQw4D53hTN5TAbDFIuvKVAZEEKD2kOIegicxyqd
         xYO/4knIjXjb+EYRKM+b99IZB+oKKHeOpR7zkpj9Ree3q+uoBegY2XFkCqvPUek7671x
         9tSQ==
X-Gm-Message-State: AOAM530jk968VTTwkBK9C533+flT+dwAmwQ3XIFaFvHdtLX8Wpi6buvV
        J7rTD2O6w8+zhBcMbZ4qLppaeGtOMNASNw==
X-Google-Smtp-Source: ABdhPJwl85ZRFOMniq9lOPpugiDaeFrzdUFTQuCvcvzI+KUOm6ikGODXBrKWn6q5dW0yZ3UO4CBhnQ==
X-Received: by 2002:ac8:c02:: with SMTP id k2mr4484967qti.210.1607538669775;
        Wed, 09 Dec 2020 10:31:09 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id k41sm1674840qtc.23.2020.12.09.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:31:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] rt-tests: determine_maximum_mpps.sh: Add a menu to get user settings.
Date:   Wed,  9 Dec 2020 13:30:58 -0500
Message-Id: <20201209183100.16836-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Incorporate the functionality of the get_cpuinfo_mhz.sh script into
determine_maximum_mpps.sh so that get_cpuinfo_mhz.sh can be removed.

Currently determine_maximum_mpps.sh (part of queuelat) asks the user
to edit the PREAMBLE in the script to set the environment.

Get rid of this by creating a menu that allows the user the set these
variables from a menu when running the script.

Here is the output from running the script with the -h option

./src/queuelat/determine_maximum_mpps.sh -h
Usage:
determine_maximum_mpps.sh [OPTIONS]

-c cpulist
	List of processors to run on. The default is processor 0
	Numbers are separated by commas and may include ranges. Eg. 0,3,7-11
-m maxlat
	maximum latency in nanoseconds. The default is 20000
	if the maximum is exceeded, that run of queuelat quits
-n cycles
	Estimated number of cycles it takes to process one packet
	The default is 300
-f
	Set the scheduling policy to SCHED_FIFO.
	This is the default if not specified
-r
	Set the scheduling policy to SCHED_RR.
-p priority
	default priority = 1. Valid numbers are from 1 to 99
-h
	help
	print this help message and exit

Signed-off-by: John Kacur <jkacur@redhat.com>

diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index f785147f1bbd..fdede472728c 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -6,12 +6,84 @@
 #  A script to determine the maximum mpps. Logic:
 #  Increase mpps in 0.5 units 
 # 
-# NOTE: please set "PREAMBLE" to the command line you use for 
-# 
-PREAMBLE="taskset -c 2 chrt -f 1"
 MAXLAT="20000"
 CYCLES_PER_PACKET="300"
 OUTFILE=/usr/tmp/outfile
+PRIO=1
+CPULIST=0
+SCHED=""
+
+usage()
+{
+	echo "Usage:"
+	echo "$(basename $0) [OPTIONS]"
+	echo
+	echo "-c cpulist"
+	echo "	List of processors to run on. The default is processor 0"
+	echo "	Numbers are separated by commas and may include ranges. Eg. 0,3,7-11"
+	echo "-m maxlat"
+	echo "	maximum latency in nanoseconds. The default is 20000"
+	echo "	if the maximum is exceeded, that run of queuelat quits"
+	echo "-n cycles"
+	echo "	Estimated number of cycles it takes to process one packet"
+	echo "	The default is 300"
+	echo "-f"
+	echo "	Set the scheduling policy to SCHED_FIFO."
+	echo "	This is the default if not specified"
+	echo "-r"
+	echo "	Set the scheduling policy to SCHED_RR".
+	echo "-p priority"
+	echo "	default priority = 1. Valid numbers are from 1 to 99"
+	echo "-h"
+	echo "	help"
+	echo "	print this help message and exit"
+	exit
+}
+
+get_cpuinfo_mhz()
+{
+	grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1
+}
+
+# Check that the scheduling policy hasn't already been set
+# Exit with an error message if it has
+check_sched()
+{
+	if [ "${SCHED}" != "" ]; then
+		echo "Specify -f or -r, but not both"
+		usage
+	fi
+}
+
+# Process command line options
+while getopts ":c:frp:m:n:h" opt; do
+	case ${opt} in
+		c ) CPULIST="${OPTARG}" ;;
+		m ) MAXLAT="${OPTARG}" ;;
+		n ) CYCLES_PER_PACKET="${OPTARG}" ;;
+		f ) check_sched; SCHED="-f" ;;
+		r ) check_sched; SCHED="-r" ;;
+		p ) PRIO="${OPTARG}" ;;
+		h ) usage ;;
+		* ) echo "no such option"; usage ;;
+	esac
+done
+
+shift $((OPTIND -1 ))
+
+# If the user hasn't specified a scheduling policy
+# then set it to the default SCHED_FIFO
+if [ "${SCHED}" == "" ]; then
+	SCHED="-f"
+fi
+
+# Error checking that the user entered a priority between 1 and 99
+if [[ "${PRIO}" -lt "1" ]] || [[ "${PRIO}" -gt "99" ]]; then
+	echo "PRIO must be a number between 1 and 99"
+	usage
+fi
+
+PREAMBLE="taskset -c ${CPULIST} chrt ${SCHED} ${PRIO}"
 
 echo "Determining maximum mpps the machine can handle"
 echo "Will take a few minutes to determine mpps value"
@@ -21,7 +93,7 @@ for mpps in $(seq 3 3 50); do
 	echo testing "$mpps" Mpps
 
 	OUTFILE=$(mktemp)
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz)" -p "$mpps" -t 30 > "$OUTFILE"
 
 	exceeded=$(grep exceeded "$OUTFILE")
 	if [ ! -z "$exceeded" ]; then
@@ -37,7 +109,7 @@ for mpps in $(seq $first_mpps -1 3); do
 	echo testing "$mpps" Mpps
 
 	OUTFILE=$(mktemp)
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz)" -p "$mpps" -t 30 > "$OUTFILE"
 
 	exceeded=$(grep exceeded "$OUTFILE")
 	if [ -z "$exceeded" ]; then
@@ -54,7 +126,7 @@ for mpps in $(seq "$second_mpps" 0.3 $first_mpps); do
 	echo testing "$mpps" Mpps
 
 	OUTFILE=$(mktemp)
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz)" -p "$mpps" -t 30 > "$OUTFILE"
 
 	exceeded=$(grep exceeded "$OUTFILE")
 	if [ ! -z "$exceeded" ]; then
@@ -71,7 +143,7 @@ for mpps in $(seq "$third_mpps" -0.1 3); do
 	echo testing "$mpps" Mpps
 
 	OUTFILE=$(mktemp)
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(sh get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz)" -p "$mpps" -t 30 > "$OUTFILE"
 
 	exceeded=$(grep exceeded "$OUTFILE")
 	if [ -z "$exceeded" ]; then
@@ -90,7 +162,7 @@ while [ $queuelat_failure == 1 ]; do
 	echo "$mpps Mpps"
 
 	for i in $(seq 1 10); do
-		$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz.sh)" -p "$mpps" -t 30 > "$OUTFILE"
+		$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz)" -p "$mpps" -t 30 > "$OUTFILE"
 		exceeded=$(grep exceeded "$OUTFILE")
 
 		if [ ! -z "$exceeded" ]; then
@@ -113,7 +185,7 @@ while [ $queuelat_failure == 1 ]; do
 	echo -n "Starting 10 minutes run with "
 	echo "$mpps Mpps"
 
-	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz.sh)" -p "$mpps" -t 600 > "$OUTFILE"
+	$PREAMBLE queuelat -m $MAXLAT -c $CYCLES_PER_PACKET -f "$(get_cpuinfo_mhz)" -p "$mpps" -t 600 > "$OUTFILE"
 	exceeded=$(grep exceeded "$OUTFILE")
 
 	if [ ! -z "$exceeded" ]; then
-- 
2.26.2

