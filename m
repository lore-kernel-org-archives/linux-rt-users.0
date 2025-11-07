Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397A33C520
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541900; cv=none; b=rJtxrh4YgQAsqjooGHy/ORV8+UI8d7aPA3kqJcrdKdduH+MDm5hfLVHUhRaLtTWLT62+ydr1yd1MOIiZ9E+oI//KFXG0trY4gENqyXCPAxPu8Z0VB3diDlVsBlXO0aeMzKtuX7S4R5mCo6EiahW7Y+0r9pggUpR/b1jC1gm9Ksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541900; c=relaxed/simple;
	bh=zSAg77qzaNX5EVSRcQMNIcrXu9Ibl1dPjHeS51yEBGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZx2zK+zE4D/Ckminv3q9L5GRfNHvz6B7maF1/mQNgxE2RukTSCAzLZhAMq0SOsSc06O89tXOL4wl2SLrjXMNRRR8LIRlvzjLN6pmo2F1Et/L7gjvxqdeLc5kgLhUKCLYgXGcH3yJpvyq5LXAltVlgVGNDodvNxizlDYZXgGf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFuTaQrz; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFuTaQrz"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-891667bcd82so112461085a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541897; x=1763146697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIhb/5iCvPreFCqYk8a17JL/kbe3JJM65J8CaO3RWwk=;
        b=JFuTaQrz8kZp6JIcnCwc2keIwAgu9zjvuQlMAgcOreJoZaQbo7MNW4GA8ZqySFiqfF
         UgLI2byykf0Q7pzVeDFXpT0/bYbDShuknGP/mtp2KTxRwlfEDLPOUw4kNiw91cYd6xpz
         AhfuGEvdP5Uobl/2Dc+Xv/BlMm1AhBzvzx2FMbKboetlelgE1taxejtassZ0CymWKn5c
         6NTzGp9ZaZJFMyurEAlJdbW8qhsbZqRRxypsX88gmfxk590soR/fKDeTk+5cWbCPIjw+
         8Eyb9jr2pi79IuNXVwZNKFzSKuSt0kXrslTMtHWmgYOGy0y+qdl9Hbn39XtOPlzIUGcS
         qqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541897; x=1763146697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIhb/5iCvPreFCqYk8a17JL/kbe3JJM65J8CaO3RWwk=;
        b=Y+xdMDimfrTxBNH588pUQlCxEmb6zZijbv6vI7NUtO4tWsAH4KmeoXM92dzk7Qta2D
         ze9DLauaiSy+K2Jjz2ZfgDN1eCPkSg6sBbDouy9J0BWagyPvjnD8mU15z/c2IS8fpth5
         1A2D+ZinqkbfsAitJABoU6U+BNIIRByRm8bo7FW0tUl6qJ4JYcTYm0U/ud86A3tyD/gb
         VTzHNPc6Kxos2jvJA69mOJ+ZEBhRLxjxlu5YZPCwDFrZVwwqk2b0Zu3W6gMvVPNdH9Pt
         26kTjmuE801bIx8tJmt4iJWulSsaASTpxUs+o5OzmedPraHB72rlLZ749mPrW0JapAUT
         2jBg==
X-Gm-Message-State: AOJu0Yy07UNAUBtVOK1b9PqV/2C2Iir+lMJG3AO4hnODtNnZdNYqn8ol
	pgmXC+DuVWWaIeLbHCRh/nY+bhH51k+y66Wv5ZZCdxhWVwpPZc6bh+xSTHi4+T38
X-Gm-Gg: ASbGncvIHLvRJfzCCONriGbimL8ow2KyHPAV9zRw5VXUUpeOFcxbj/LwCiToUIAcJDw
	yUIo99PZYOXa77e6SIkEu/Rl/zjtL+8ehPBDdQSkgYuuTgHpY1LRpo3DPAfS2Ba76E+akpxSOLX
	3x46wIPtsIvIIWEpI5nyQhASUktI+P/y360j91h+6Ag4u2GoBg80DdDYePKPQcAEpR+QJpIiXls
	aU7/rJKXuc0LpEpK3Q8Mqowk1py82bO3GHCNf66hKECUI8Q+DwefDbNmHBKkb5ec+SDSVtQrsWZ
	GhBf6bFBADVQdKbvxgpotXbpuYxi4v6U4zZOp2P5gmGE16ap/mzXC9SSDauDbtCNRe1jhifQz2S
	kEiv5V2auAAHhhkb3D/ZrZbOH3InhitRjhXFKDzhcUEsQa6Y5PBfV/OLsFBSLDc9rqxePxf/IAC
	+WpknqzCVI
X-Google-Smtp-Source: AGHT+IHFTtNfzQeuR05zwrerZMs2tSkyyJy6wiSxf6ZeWopySFKkcOoNJtjjM3/72+s1ONGOSKY/VQ==
X-Received: by 2002:a05:620a:44d2:b0:8a3:c4fa:9b5b with SMTP id af79cd13be357-8b24d6b1fc3mr307306585a.12.1762541897544;
        Fri, 07 Nov 2025 10:58:17 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 18/23] tuna: Remove broken testuna
Date: Fri,  7 Nov 2025 13:57:27 -0500
Message-ID: <20251107185732.23992-19-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "John B. Wyatt IV" <jwyatt@redhat.com>

This script relies on the older, incompatible Tuna syntax, and
rtctl which is no longer packaged for most distributions. No one
has complained so remove it since the changes to update it would
be extensive with no users.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 testuna | 230 --------------------------------------------------------
 1 file changed, 230 deletions(-)
 delete mode 100755 testuna

diff --git a/testuna b/testuna
deleted file mode 100755
index cb98640c0167..000000000000
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
2.51.1

