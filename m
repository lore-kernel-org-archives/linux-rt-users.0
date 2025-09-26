Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35272222C2
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917838; cv=none; b=KhOdDON3dKsgVfm+HwG87peSeP0CjF3EgZksmDgwwwlZZ6YiyPr7X9EGPln9FWC2+vRywOra8z4vLvG1HVT7Kc3BHWreStuZlIthsefsNek5+fEsnAbrsXZAZaz8JFUJIrTR7xoo9/Ph1G7BGkgs6ts7OYNwE9zpjgAt1/CwPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917838; c=relaxed/simple;
	bh=td68y4RlaNywT6kURw9d0TYJ5MJVVxLBnRJrAz1+vsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LxR+GxhH8SQXSsgVtzu3PoErtfojbHOl1QK4ZcTBM9++PK+nHeQxPICgQzK+f/l6wcSsRmdur7BnOvSynU1dbPgiu9iF6YJ5D3EbJqIa3gQYHxTr+IPi6JJdx60L21UMJApWX7hmAc44tbOglV1P7ojdCa92wY4fRmYFQt8j9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxbeRvEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxbeRvEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758917833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RlZPxc7EZPWe2a6Popk/vSV+gIL/ZB72nwcY1CzEUc0=;
	b=FxbeRvEVh3n3QH0jDUpdskNHPIgd8L3nrRHt02CtM0Oq4W9HU1mOfzZZ4Zm6jCsbd0hSbx
	LX7ycoxE/TAA3vB+lQlTA7NEtOY87g8KSUagFPpRWqKXBDC3E4kczb1cvQLCVJlxWk5ZNd
	CyMY1HySMmsN/cdFFvBY2vaiNCowTh4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-zPlYVJ-UO3if-OsvWme8GQ-1; Fri, 26 Sep 2025 16:17:12 -0400
X-MC-Unique: zPlYVJ-UO3if-OsvWme8GQ-1
X-Mimecast-MFC-AGG-ID: zPlYVJ-UO3if-OsvWme8GQ_1758917831
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85adb6a349cso611545085a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 13:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917831; x=1759522631;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlZPxc7EZPWe2a6Popk/vSV+gIL/ZB72nwcY1CzEUc0=;
        b=M1gs6VXS1G+79smsGdFitrYwlItsqUuIFYPPzrntxfifT+tXmE/X3IqV76lSDW8Bt6
         a4j21w9pgdLseQzhb1vm1wEtvdokmRpwHZn1YQxhqzwcUKwBBct+1GjurcP+OuJxSmmu
         UfF30mL1uw+M4CkQHUhVjJA2rMObSJfYl5Ek3uG3+tEvVqswOXiGC7Vj6dkVmI21+Pic
         zHtpTbMnQfWHKmO7CFHALHzUjB4UsEZkFmk0eoxArRC1MzOSGw6vMA+cbkJuvFeLEMhP
         cEPgnWD50nZApckgeNxMZBSzrkgK8YPnFpRkT976x0CGBpjfUy+lxR6RrRmxRZR91RM5
         lx+g==
X-Forwarded-Encrypted: i=1; AJvYcCVXDtKek8Lsmxwgw2lbz/vYUGZXzObeZTNHLVC1DFPS8R38ghQxeunLqubABQ2pTiUhupq7ibn+6SKPcSFMgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6b2u3okHKNTUTTXM1J8MmRU0Lgd8QkcW/ezEDH/lFsWjtgqh7
	1KDEkySKXXeimncdkm9VoeWLJ1J6NC7187GhQYEXIzH/xPPFirWdf3QaYjKVDhXZDutsROjV82O
	re7lGr5fOHCM0YotP8zAOMtA4uQ/+MSj2x3OcbqT6cQASTPqEHlNMFoqiRsb2+e9SH7n/
X-Gm-Gg: ASbGncvOWtNPebmqflJPo99ugKBUs0Hg+O6QFgu7jeHfTnXdbsmp7+RRbYQI/GvLJ3W
	wzk+7P6m9mWPMW/Yw+mLnNUcAOD61RPWx5Mhepue4kAVMEtsvan9aw0NJ+Gr0JHEBdgBQlP0xN7
	IEhqxVXhpAU8jTADwUI2KhUVyqySXs4P8Xw+JrL8/T+uacPnIVEMbVaU+3WMv+YMky3RbJdfYtB
	250Dv35tezuum5fOy1KrSfxPjyL8JsmOeuIz/4a3t6g01NEkUxsS5yqk6XXaCrq5vYBavyJu+vk
	YDnt4yPNIolExXKIChHa1hF71xxaGafT8xv4gawfCMxMvVj3tDvt7uh38zBIKyBZFMZ3E5z5nnw
	dhileJXqhr7Wz
X-Received: by 2002:a05:620a:4010:b0:844:9c74:e839 with SMTP id af79cd13be357-85ae0dc231fmr1352784285a.22.1758917831458;
        Fri, 26 Sep 2025 13:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhf/6u9fcGf72lvHxqZmgqNeLUCYzE18EeoifCjo3usrsAqICHQZQ/dm2GQ2pUqJLASPCnqQ==
X-Received: by 2002:a05:620a:4010:b0:844:9c74:e839 with SMTP id af79cd13be357-85ae0dc231fmr1352778585a.22.1758917830850;
        Fri, 26 Sep 2025 13:17:10 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b5f64sm328605085a.32.2025.09.26.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 13:17:10 -0700 (PDT)
Date: Fri, 26 Sep 2025 16:17:09 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Remove broken testuna
In-Reply-To: <20250917213551.12944-1-jwyatt@redhat.com>
Message-ID: <96ee6f1c-c911-d820-5912-f2185007e56c@redhat.com>
References: <20250917213551.12944-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 17 Sep 2025, John B. Wyatt IV wrote:

> This script relies on the older, incompatible Tuna syntax, and
> rtctl which is no longer packaged for most distributions. No one
> has complained so remove it since the changes to update it would
> be extensive with no users.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  testuna | 230 --------------------------------------------------------
>  1 file changed, 230 deletions(-)
>  delete mode 100755 testuna
> 
> diff --git a/testuna b/testuna
> deleted file mode 100755
> index cb98640..0000000
> --- a/testuna
> +++ /dev/null
> @@ -1,230 +0,0 @@
> -#!/bin/bash
> -# Regression tests for tuna
> -# (c) 2008 Red Hat Inc.
> -# Arnaldo Carvalho de Melo <acme@redhat.com>
> -# SPDX-License-Identifier: GPL-2.0-only
> -
> -dprint() {
> -	[ -n "$VERBOSE" ] && echo $1
> -}
> -
> -ktpidof() {
> -	echo $(ps ax -To pid,cmd | grep "\[$1.*\]" | head -1 | cut -d'[' -f 1)
> -}
> -
> -get_rtprio() {
> -	echo $(chrt -p $1 | grep priority | cut -d ':' -f 2)
> -}
> -
> -get_policy() {
> -	echo $(chrt -p $1 | grep policy | cut -d ':' -f 2)
> -}
> -
> -get_affinity() {
> -	echo $(taskset -p $1 | grep 'current affinity' | cut -d ':' -f 2)
> -}
> -
> -get_nr_processors() {
> -	echo $(grep -i "^processor.*: " /proc/cpuinfo | tail -1 | cut -d ':' -f 2)
> -}
> -
> -get_nr_cpu_sockets() {
> -	echo $(grep "^physical id" /proc/cpuinfo | cut -d: -f2 | sort -u | wc -l)
> -}
> -
> -die() {
> -	[ -z "$VERBOSE" ] && echo -n "$2: "
> -	echo $1
> -	rtctl --file $INITIAL reset
> -	taskset -p $INITIAL_INIT_AFFINITY 1 > /dev/null
> -	rm -rf $TESTUNA_DIR
> -	exit 1
> -}
> -
> -die_with_a_diff() {
> -	[ -n "$VERBOSE" ] && diff -u $INITIAL $NEW
> -	die "$1"
> -}
> -
> -tuna_save() {
> -	tuna --save $TEMPCONF
> -	grep -v '^# rtctl --file ' $TEMPCONF > $1
> -	rm -f $TEMPCONF
> -}
> -
> -die_if_not_saved() {
> -	dprint "$2"
> -	tuna_save $NEW
> -	(diff -u $INITIAL $NEW | diffstat | \
> -	grep -q "[ \t]*1 file changed, $1 insertions*(+), $1 deletions*(-)") ||
> -	die_with_a_diff 'FAILED!' "$2"
> -}
> -
> -die_if_conf_changed() {
> -	dprint "$1"
> -	tuna_save $NEW
> -	diff -qu $INITIAL $NEW > /dev/null || die_with_a_diff 'FAILED!' "$1":
> -}
> -
> -die_if_zero() {
> -	dprint "$2"
> -	[ $1 -eq 0 ] && die 'FAILED!' "$2"
> -}
> -
> -die_if_not_zero() {
> -	dprint "$2"
> -	[ $1 -ne 0 ] && die 'FAILED!' "$2"
> -}
> -
> -die_if_not_equal() {
> -	dprint "$3"
> -	[ $1 -ne $2 ] && die 'FAILED!' "$3"
> -}
> -
> -die_if_not_str_equal() {
> -	dprint "$3"
> -	[ $1 != $2 ] && die 'FAILED!' "$3"
> -}
> -
> -TESTUNA_DIR=$(mktemp -d -t testuna.XXXXXX) || exit 1
> -INITIAL=$TESTUNA_DIR/initial.tuna
> -INITIAL_INIT_AFFINITY=$(get_affinity 1)
> -TEMPCONF=$TESTUNA_DIR/tempnew.tuna
> -NEW=$TESTUNA_DIR/new.tuna
> -
> -[ $# -eq 1 ] && VERBOSE=1
> -
> -dprint "Saving initial configuration"
> -
> -tuna_save $INITIAL
> -
> -TUNA_RPM_VERSION=$(rpm -q --qf "%{version}\n" tuna)
> -TUNA_BIN_VERSION=$(tuna --version)
> -die_if_not_str_equal "$TUNA_RPM_VERSION" "$TUNA_BIN_VERSION" \
> -	"Verifying --version ($TUNA_BIN_VERSION) matches package version ($TUNA_RPM_VERSION)"
> -
> -rtctl --file $INITIAL reset
> -
> -die_if_conf_changed "Replaying initial config"
> -
> -PID=$(ktpidof "watchdog")
> -RTPRIO=$(get_rtprio $PID)
> -POLICY=$(get_policy $PID)
> -POLICY=$(echo ${POLICY:6:1} | tr 'A-Z' 'a-z')
> -chrt -$POLICY -p $((RTPRIO - 1)) $PID
> -
> -die_if_not_saved 1 'Saving changes to a kernel thread priority'
> -
> -chrt -$POLICY -p $RTPRIO $PID
> -
> -die_if_conf_changed 'Restoring kernel thread priority'
> -
> -new_policy=$(echo $POLICY | tr fr rf)
> -
> -chrt -$new_policy -p $RTPRIO $PID
> -
> -die_if_not_saved 1 'Changing kernel thread sched policy'
> -
> -chrt -$POLICY -p $RTPRIO $PID
> -
> -die_if_conf_changed 'Restoring kernel thread sched policy'
> -
> -PID=$(ktpidof "kthreadd")
> -AFFINITY=$(get_affinity $PID)
> -
> -taskset -p 0x2 $PID > /dev/null
> -
> -die_if_not_saved 1 'Changing kernel thread SMP affinity mask'
> -
> -taskset -p $AFFINITY $PID > /dev/null
> -
> -die_if_conf_changed 'Restoring kernel thread SMP affinity mask'
> -
> -NR_PROCESSORS=$(get_nr_processors)
> -for PROCESSOR in $(seq 0 $NR_PROCESSORS) ; do
> -	taskset -p 0xff 1 > /dev/null
> -
> -	PROCESSOR_AFFINITY=$(printf "%#x\n" $((1 << PROCESSOR)))
> -	tuna --cpu $PROCESSOR --isolate
> -
> -	AFFINITY=0x$(get_affinity 1)
> -
> -	die_if_not_zero $((AFFINITY & PROCESSOR_AFFINITY)) "Isolating CPU $PROCESSOR"
> -
> -	tuna --cpu $PROCESSOR --include
> -
> -	AFFINITY=0x$(get_affinity 1)
> -
> -	die_if_zero $((AFFINITY & PROCESSOR_AFFINITY)) "Including CPU $PROCESSOR"
> -done
> -
> -NEW_AFFINITY=$((1 << NR_PROCESSORS | 1))
> -
> -if [ $NR_PROCESSORS -gt 2 ]; then
> -	tuna --cpu=0,$NR_PROCESSORS --isolate
> -
> -	for PID in $(cd /proc; ls -d [0-9]*) ; do
> -		[ -n "$(cat /proc/$PID/cmdline 2> /dev/null)" ] || continue
> -		AFFINITY=0x$(get_affinity $PID) || continue
> -
> -		die_if_not_zero $((AFFINITY & NEW_AFFINITY)) \
> -			"Verifying isolation of first and last processor for PID $PID"
> -	done
> -fi
> -
> -tuna --cpu=0,$NR_PROCESSORS --include
> -
> -AFFINITY=0x$(get_affinity 1)
> -
> -die_if_not_equal $((AFFINITY & NEW_AFFINITY)) $NEW_AFFINITY "Including first and last processor"
> -
> -taskset -p 0xff 1 > /dev/null
> -
> -NEW_AFFINITY=$((1 << NR_PROCESSORS | 1))
> -
> -tuna --cpu=0,$NR_PROCESSORS --thread 1 --move
> -
> -AFFINITY=0x$(get_affinity 1)
> -
> -die_if_not_equal $((AFFINITY & NEW_AFFINITY)) $NEW_AFFINITY "Moving init to just first and last processor"
> -
> -NR_CPU_SOCKETS=$(get_nr_cpu_sockets)
> -if [ $NR_CPU_SOCKETS -ge 2 ]; then
> -	CPU1_SIBLINGS=$(printf "%d" 0x$(cat /sys/devices/system/cpu/cpu1/topology/core_siblings | cut -d',' -f2))
> -	CPU1_SOCKET=$(cat /sys/devices/system/cpu/cpu1/topology/physical_package_id)
> -
> -	tuna --sockets=$CPU1_SOCKET --isolate
> -	AFFINITY=0x$(get_affinity 1)
> -	die_if_not_zero $((AFFINITY & CPU1_SIBLINGS)) \
> -		"Verifying isolation of socket $CPU1_SOCKET"
> -
> -	tuna --sockets=$CPU1_SOCKET --include
> -	AFFINITY=0x$(get_affinity 1)
> -	die_if_not_equal $((AFFINITY & CPU1_SIBLINGS)) $CPU1_SIBLINGS \
> -		"Verifying inclusion of socket $CPU1_SOCKET"
> -
> -	tuna --sockets=$CPU1_SOCKET --isolate
> -	tuna --sockets=$CPU1_SOCKET --thread 1 --move
> -	AFFINITY=0x$(get_affinity 1)
> -	die_if_not_equal $((AFFINITY & CPU1_SIBLINGS)) $CPU1_SIBLINGS "Moving init to CPU socket $CPU1_SOCKET"
> -fi
> -
> -if [ $NR_PROCESSORS -gt 2 ]; then
> -	THREAD_PREFIX="watchdog/"
> -	PID=$(ps h -C ${THREAD_PREFIX}0 -o pid)
> -	RTPRIO=$(get_rtprio $PID)
> -	NEW_RTPRIO=$((RTPRIO - 1))
> -	tuna -t $THREAD_PREFIX* -p $NEW_RTPRIO
> -	for CPU in $(seq 0 $((NR_PROCESSORS - 1))); do
> -		PID=$(ps h -C ${THREAD_PREFIX}$CPU -o pid)
> -		RTPRIO=$(get_rtprio $PID)
> -		die_if_not_equal $RTPRIO $NEW_RTPRIO "Using --thread globbing"
> -	done
> -fi
> -
> -taskset -p $INITIAL_INIT_AFFINITY 1 > /dev/null
> -rtctl --file $INITIAL reset
> -
> -echo 'PASS: Healthy tuna, no lead found, eat!'
> -
> -exit 0
> -- 
> 2.51.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

