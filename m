Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61F306B3F
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Sep 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144967; cv=none; b=czr41ldlj0uB5e2nuZuEDG9FE7BI4xzMrm/hCKx5iZ20SWE/DpwlBhKndwqQDwK29sXDNSCiydNVPEuHBQcmRb8dLcNtwpuCflYRyJUCAhDXIZYxLBns9Hdn1uheS+kbNI4yiuucFLM9BP4l+ZzmCAZfpL5Tc7FVDEGD1/wdV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144967; c=relaxed/simple;
	bh=q8H9H1kfxrsYke3od9cxkG4YSqjhgRsQ5a9oEPjTYxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0LTD+MDNz0omp0x+OZXcWUoUox6NiDgpqkWYECv0k64laISQ01UHLBknptghqQtl5uKWC0gpFAXYp9VDyDqj/XXAlmrjQHSK8aMLLrzuFPxyoAQoch0qOzm0PChKXJaV3zW42aJZ1cYf5KXkGkK5KtZ/qvk4X7CVCcmUuEiy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzvzOQQG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzvzOQQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758144963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oFzMYvN1U25yNiAfLtKOsud/hnRtyR0cTFu4ZqQZG6I=;
	b=EzvzOQQGb6P6ybeQ8le7qNFZXfgQIK4upqS53y7YuIot+IJ2nLJUDPxJLJuZbfBCvfhbmi
	mcw/VaW47iBm3LPRHuJdkos7wVFSR8DdBnQ/ydHlvSY00n54EDE3SST1Udp4tn2afVFyRm
	b5bVQL8i0UXQXdg1P8/lkydHmq9PZNo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Zfn_BjFsMGaUZMPInrfReg-1; Wed, 17 Sep 2025 17:36:02 -0400
X-MC-Unique: Zfn_BjFsMGaUZMPInrfReg-1
X-Mimecast-MFC-AGG-ID: Zfn_BjFsMGaUZMPInrfReg_1758144961
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8163f552e5aso120457385a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Sep 2025 14:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144961; x=1758749761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFzMYvN1U25yNiAfLtKOsud/hnRtyR0cTFu4ZqQZG6I=;
        b=v4QWeVpdLh0uBJPbJXJGJ09v33zM/TICPWyajLU3kpb+yEcg4flmp9E34n+GK33gz3
         LfgnTbSR3R0it+6Euj3JFsZGASjX4zLJRHEZ27e2sdOFjxjOfhYDHVl0dnCAgwinFNqF
         HUHN2Bcg/1WidhTuohEngB+KfbMW+e2peaCrFBN5CVSyAmw2HWg0Jvz8CVSmne0W/pF9
         giZhUY8goI3kkw9WeV/ilufQ/jAtB5ZUYXmx+9r7ylGZHYhA5uNDgjyN5e5gGRvy44at
         sDZ0kbKTpMaxxhimOeLx6mPiL8wiKMLd+Unmc5TN7V7e8RdzSTnRd/64wqHc48nhdJ+C
         VdYg==
X-Forwarded-Encrypted: i=1; AJvYcCU3eHWpNHjTQ0bR6HBhVl0268N3n082BkwbFJQbMGEqqRJCKbKEEV+dq/dZwl5kCjGF/IGqILmuhRfGjWno9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YytVpOlHux+apy1e5js41CwL/6EbDFR9LFxBf0SYkvIxwizwO56
	D0IaAwL1YXZHDiPAaP3zYFTOFSJBzqGlXUDmbgmqEVSaomq9fD5Jwe0OFGyuglLpJbZupfAUV1a
	9ygN6Jo9VSMzZ3qDJPCIw9xU/qQlhUADhcy7+t0m/sjXp+ZKmO7paqEJ+Sd3+Zl1wC6nx
X-Gm-Gg: ASbGncsqIlhtu+NP24kNOezpEgZZWiSyoTA3JMostatumCOZVl6JrEQLR2nXdrxSD8N
	+7pKafPWzHTiilziAEG4WN8P5WoJqnPtp83T+qStsC4Kf0j3wlcuuZ9F4prmvp+6CUMK1qSAf75
	NO1YR+mwGHSF23lEAGZKAGp4DrNhHbAd54Ug1GJB1NNOJGK3kmPJcf/Vp9DqY9ikeUTb00/t2tG
	yaufucnD8N0MON/ye6SxCdMHyWzZTztDCfc4WS4SH2iNWujZefBK4fKE7UjGSVLxHnY/V74/hwd
	0Iji2o0iVcIJn4rNU+dHR8cPiXn42iB62yWV
X-Received: by 2002:a05:620a:2981:b0:7fe:8292:187e with SMTP id af79cd13be357-831153044a9mr439670385a.60.1758144961495;
        Wed, 17 Sep 2025 14:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgrDf8gJYhUIJzEwTULltCfyH7s4S4m39eiaKlOlt3E68DHH7VRkVThpprANoB2Pldaly3LA==
X-Received: by 2002:a05:620a:2981:b0:7fe:8292:187e with SMTP id af79cd13be357-831153044a9mr439667685a.60.1758144961015;
        Wed, 17 Sep 2025 14:36:01 -0700 (PDT)
Received: from thinkpad2024 ([71.217.38.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836262b5592sm50656385a.2.2025.09.17.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:36:00 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] tuna: Remove broken testuna
Date: Wed, 17 Sep 2025 17:35:49 -0400
Message-ID: <20250917213551.12944-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This script relies on the older, incompatible Tuna syntax, and
rtctl which is no longer packaged for most distributions. No one
has complained so remove it since the changes to update it would
be extensive with no users.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 testuna | 230 --------------------------------------------------------
 1 file changed, 230 deletions(-)
 delete mode 100755 testuna

diff --git a/testuna b/testuna
deleted file mode 100755
index cb98640..0000000
--- a/testuna
+++ /dev/null
@@ -1,230 +0,0 @@
-#!/bin/bash
-# Regression tests for tuna
-# (c) 2008 Red Hat Inc.
-# Arnaldo Carvalho de Melo <acme@redhat.com>
-# SPDX-License-Identifier: GPL-2.0-only
-
-dprint() {
-	[ -n "$VERBOSE" ] && echo $1
-}
-
-ktpidof() {
-	echo $(ps ax -To pid,cmd | grep "\[$1.*\]" | head -1 | cut -d'[' -f 1)
-}
-
-get_rtprio() {
-	echo $(chrt -p $1 | grep priority | cut -d ':' -f 2)
-}
-
-get_policy() {
-	echo $(chrt -p $1 | grep policy | cut -d ':' -f 2)
-}
-
-get_affinity() {
-	echo $(taskset -p $1 | grep 'current affinity' | cut -d ':' -f 2)
-}
-
-get_nr_processors() {
-	echo $(grep -i "^processor.*: " /proc/cpuinfo | tail -1 | cut -d ':' -f 2)
-}
-
-get_nr_cpu_sockets() {
-	echo $(grep "^physical id" /proc/cpuinfo | cut -d: -f2 | sort -u | wc -l)
-}
-
-die() {
-	[ -z "$VERBOSE" ] && echo -n "$2: "
-	echo $1
-	rtctl --file $INITIAL reset
-	taskset -p $INITIAL_INIT_AFFINITY 1 > /dev/null
-	rm -rf $TESTUNA_DIR
-	exit 1
-}
-
-die_with_a_diff() {
-	[ -n "$VERBOSE" ] && diff -u $INITIAL $NEW
-	die "$1"
-}
-
-tuna_save() {
-	tuna --save $TEMPCONF
-	grep -v '^# rtctl --file ' $TEMPCONF > $1
-	rm -f $TEMPCONF
-}
-
-die_if_not_saved() {
-	dprint "$2"
-	tuna_save $NEW
-	(diff -u $INITIAL $NEW | diffstat | \
-	grep -q "[ \t]*1 file changed, $1 insertions*(+), $1 deletions*(-)") ||
-	die_with_a_diff 'FAILED!' "$2"
-}
-
-die_if_conf_changed() {
-	dprint "$1"
-	tuna_save $NEW
-	diff -qu $INITIAL $NEW > /dev/null || die_with_a_diff 'FAILED!' "$1":
-}
-
-die_if_zero() {
-	dprint "$2"
-	[ $1 -eq 0 ] && die 'FAILED!' "$2"
-}
-
-die_if_not_zero() {
-	dprint "$2"
-	[ $1 -ne 0 ] && die 'FAILED!' "$2"
-}
-
-die_if_not_equal() {
-	dprint "$3"
-	[ $1 -ne $2 ] && die 'FAILED!' "$3"
-}
-
-die_if_not_str_equal() {
-	dprint "$3"
-	[ $1 != $2 ] && die 'FAILED!' "$3"
-}
-
-TESTUNA_DIR=$(mktemp -d -t testuna.XXXXXX) || exit 1
-INITIAL=$TESTUNA_DIR/initial.tuna
-INITIAL_INIT_AFFINITY=$(get_affinity 1)
-TEMPCONF=$TESTUNA_DIR/tempnew.tuna
-NEW=$TESTUNA_DIR/new.tuna
-
-[ $# -eq 1 ] && VERBOSE=1
-
-dprint "Saving initial configuration"
-
-tuna_save $INITIAL
-
-TUNA_RPM_VERSION=$(rpm -q --qf "%{version}\n" tuna)
-TUNA_BIN_VERSION=$(tuna --version)
-die_if_not_str_equal "$TUNA_RPM_VERSION" "$TUNA_BIN_VERSION" \
-	"Verifying --version ($TUNA_BIN_VERSION) matches package version ($TUNA_RPM_VERSION)"
-
-rtctl --file $INITIAL reset
-
-die_if_conf_changed "Replaying initial config"
-
-PID=$(ktpidof "watchdog")
-RTPRIO=$(get_rtprio $PID)
-POLICY=$(get_policy $PID)
-POLICY=$(echo ${POLICY:6:1} | tr 'A-Z' 'a-z')
-chrt -$POLICY -p $((RTPRIO - 1)) $PID
-
-die_if_not_saved 1 'Saving changes to a kernel thread priority'
-
-chrt -$POLICY -p $RTPRIO $PID
-
-die_if_conf_changed 'Restoring kernel thread priority'
-
-new_policy=$(echo $POLICY | tr fr rf)
-
-chrt -$new_policy -p $RTPRIO $PID
-
-die_if_not_saved 1 'Changing kernel thread sched policy'
-
-chrt -$POLICY -p $RTPRIO $PID
-
-die_if_conf_changed 'Restoring kernel thread sched policy'
-
-PID=$(ktpidof "kthreadd")
-AFFINITY=$(get_affinity $PID)
-
-taskset -p 0x2 $PID > /dev/null
-
-die_if_not_saved 1 'Changing kernel thread SMP affinity mask'
-
-taskset -p $AFFINITY $PID > /dev/null
-
-die_if_conf_changed 'Restoring kernel thread SMP affinity mask'
-
-NR_PROCESSORS=$(get_nr_processors)
-for PROCESSOR in $(seq 0 $NR_PROCESSORS) ; do
-	taskset -p 0xff 1 > /dev/null
-
-	PROCESSOR_AFFINITY=$(printf "%#x\n" $((1 << PROCESSOR)))
-	tuna --cpu $PROCESSOR --isolate
-
-	AFFINITY=0x$(get_affinity 1)
-
-	die_if_not_zero $((AFFINITY & PROCESSOR_AFFINITY)) "Isolating CPU $PROCESSOR"
-
-	tuna --cpu $PROCESSOR --include
-
-	AFFINITY=0x$(get_affinity 1)
-
-	die_if_zero $((AFFINITY & PROCESSOR_AFFINITY)) "Including CPU $PROCESSOR"
-done
-
-NEW_AFFINITY=$((1 << NR_PROCESSORS | 1))
-
-if [ $NR_PROCESSORS -gt 2 ]; then
-	tuna --cpu=0,$NR_PROCESSORS --isolate
-
-	for PID in $(cd /proc; ls -d [0-9]*) ; do
-		[ -n "$(cat /proc/$PID/cmdline 2> /dev/null)" ] || continue
-		AFFINITY=0x$(get_affinity $PID) || continue
-
-		die_if_not_zero $((AFFINITY & NEW_AFFINITY)) \
-			"Verifying isolation of first and last processor for PID $PID"
-	done
-fi
-
-tuna --cpu=0,$NR_PROCESSORS --include
-
-AFFINITY=0x$(get_affinity 1)
-
-die_if_not_equal $((AFFINITY & NEW_AFFINITY)) $NEW_AFFINITY "Including first and last processor"
-
-taskset -p 0xff 1 > /dev/null
-
-NEW_AFFINITY=$((1 << NR_PROCESSORS | 1))
-
-tuna --cpu=0,$NR_PROCESSORS --thread 1 --move
-
-AFFINITY=0x$(get_affinity 1)
-
-die_if_not_equal $((AFFINITY & NEW_AFFINITY)) $NEW_AFFINITY "Moving init to just first and last processor"
-
-NR_CPU_SOCKETS=$(get_nr_cpu_sockets)
-if [ $NR_CPU_SOCKETS -ge 2 ]; then
-	CPU1_SIBLINGS=$(printf "%d" 0x$(cat /sys/devices/system/cpu/cpu1/topology/core_siblings | cut -d',' -f2))
-	CPU1_SOCKET=$(cat /sys/devices/system/cpu/cpu1/topology/physical_package_id)
-
-	tuna --sockets=$CPU1_SOCKET --isolate
-	AFFINITY=0x$(get_affinity 1)
-	die_if_not_zero $((AFFINITY & CPU1_SIBLINGS)) \
-		"Verifying isolation of socket $CPU1_SOCKET"
-
-	tuna --sockets=$CPU1_SOCKET --include
-	AFFINITY=0x$(get_affinity 1)
-	die_if_not_equal $((AFFINITY & CPU1_SIBLINGS)) $CPU1_SIBLINGS \
-		"Verifying inclusion of socket $CPU1_SOCKET"
-
-	tuna --sockets=$CPU1_SOCKET --isolate
-	tuna --sockets=$CPU1_SOCKET --thread 1 --move
-	AFFINITY=0x$(get_affinity 1)
-	die_if_not_equal $((AFFINITY & CPU1_SIBLINGS)) $CPU1_SIBLINGS "Moving init to CPU socket $CPU1_SOCKET"
-fi
-
-if [ $NR_PROCESSORS -gt 2 ]; then
-	THREAD_PREFIX="watchdog/"
-	PID=$(ps h -C ${THREAD_PREFIX}0 -o pid)
-	RTPRIO=$(get_rtprio $PID)
-	NEW_RTPRIO=$((RTPRIO - 1))
-	tuna -t $THREAD_PREFIX* -p $NEW_RTPRIO
-	for CPU in $(seq 0 $((NR_PROCESSORS - 1))); do
-		PID=$(ps h -C ${THREAD_PREFIX}$CPU -o pid)
-		RTPRIO=$(get_rtprio $PID)
-		die_if_not_equal $RTPRIO $NEW_RTPRIO "Using --thread globbing"
-	done
-fi
-
-taskset -p $INITIAL_INIT_AFFINITY 1 > /dev/null
-rtctl --file $INITIAL reset
-
-echo 'PASS: Healthy tuna, no lead found, eat!'
-
-exit 0
-- 
2.51.0

