Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DE624
	for <linux-rt-users@vger.kernel.org>; Wed,  5 Jun 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611900; cv=none; b=QL/YKjTZvCS0kKxftZ9uAVuAbA+ERyB4Z5EhHXH5qo13nej24EoYSXKYUNY9Qdit68w1zpMpkLHvU/h3jmy4VjG0PnIQyun/LIUFEJzs1Kmfu4i1Gg/yaikj9czoKsuQEU3v4rgLYkhH4rpcfediweeOrjtgZdccodhixw3K+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611900; c=relaxed/simple;
	bh=AB0hdZVXpvbq6Z3Ejw3dYa3q9LOWISGv6+xOrzbxJ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPj2PKu318uz8oLYvilBsTH0n/CErG475tCGn7CD12yKYTaVU/mWGqA59vaJwgCFW2LpTloDtRouJflKqn3zwmpb82Q3po+JhaP0S9EAmHgbJ+06s2ATsBN/HLvYWvZ+qdvYMQbwS+j0daERdpZ/mnWAv6i9sLtAzoNyqrL9uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FU6ibzjS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU6ibzjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717611897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XpOo5729Q72VVyx1wf77gMqI8d6fxM9T0zaid807q+s=;
	b=FU6ibzjSfbr9Tem3XDGlPeHJ+DQDk3ZfdfaHEp+dTyUWW12zs6YJ+NP12A0oNW1sjKdSO2
	GivCK6qi1hVg8bwRf6aV37z27Xo7QBfq/Q+fz+cNFT16zfd3i4KgHQD3jmnAo9koNcsgM2
	XwAig9YBWH7L17zP5hN67GaRMNk/cm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-a-7Br505MBOlPQ5I4j3fGA-1; Wed,
 05 Jun 2024 14:24:56 -0400
X-MC-Unique: a-7Br505MBOlPQ5I4j3fGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FB601C05122
	for <linux-rt-users@vger.kernel.org>; Wed,  5 Jun 2024 18:24:56 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.20.22.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02AA7212BFC0;
	Wed,  5 Jun 2024 18:24:55 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] Updated rteval man page
Date: Wed,  5 Jun 2024 14:24:54 -0400
Message-ID: <20240605182454.96479-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The rteval man page should reflect the functionality of the
current iteration of rteval. Currently the rteval man page
reflects the functionality of an outdated version. This patch
removes deprecated options and adds options that have been
added in recent updates.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 doc/rteval.8 | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/doc/rteval.8 b/doc/rteval.8
index 578de370effa..264bf5207716 100644
--- a/doc/rteval.8
+++ b/doc/rteval.8
@@ -63,6 +63,9 @@ for example to execute a ten minute run of rteval:
 .B \-v, \-\-verbose
 Increase the verbosity of output during the test run
 .TP
+.B \-q, \-\-quiet
+Set rteval to run in quiet mode.
+.TP
 .B \-w WORKDIR, \-\-workdir=WORKDIR
 Tell rteval to change directory to WORKDIR before creating any
 subdirectories for report files. The default WORKDIR is the directory
@@ -71,11 +74,8 @@ in which rteval was started.
 .B \-l LOADDIR, \-\-loaddir=LOADDIR
 Tell rteval where to find the source for the loads
 .TP
-.B \-\-loads\-cpulist=CPULIST
-List of CPUs where loads will run
-.TP
-.B \-\-measurement-cpulist=CPULIST
-List of CPUs where measurement applciation will run
+.B \-i INSTALLDIR, \-\-installdir=INSTALLDIR
+Tell rteval where to locate installed templates.
 .TP
 .B \-s, \-\-sysreport
 Have rteval run the sysreport utility after a run to gather
@@ -103,11 +103,25 @@ Log the output of the loads in the report directory
 .B \-O, \-\-onlyload
 Only run the loads (don't run measurement threads)
 .TP
+.B \-V, \-\-version 
+Print rteval version and exit.
+.TP
 .B \-S KERNEL_VERSION, \-\-source\-download=KERNEL_VERSION
 download a source kernel from kernel.org and exit
 
+.SH GROUP OPTIONS
+.TP
+.B \-\-loads\-cpulist=CPULIST
+List of CPUs where loads will run
+.TP
+.B \-\-measurement-cpulist=CPULIST
+List of CPUs where measurement applciation will run
+.TP
+.B \-\-measurement-run-on-isolcpus
+Include isolated CPUs in default cpulist
+
 
-.SH MODULE OPTIONS
+.SH CYCLICTEST OPTIONS
 These are options that affect the execution behavior of the measurement and load modules.
 .TP
 .B \-\-cyclictest-priority=PRIORITY
@@ -116,21 +130,23 @@ SCHED_FIFO priority for measurement threads (default: 95)
 .B \-\-cyclictest-interval=INTERVAL
 Measurement thread interval in microseconds (default: 100)
 .TP
-.B \-\-cyclictest-distance=DISTANCE
-Interval increment in microseconds (default: 0)
-.TP
 .B \-\-cyclictest-buckets=NBUCKETS
 Number of 1 microsecond histogram buckets (default: 3500)
 .TP
-.B \-\-hackbench-jobspercore=N
-Number of jobs per online-core for hackbench load
+.B \-\-cyclictest-breaktrace=USEC
+Send a break trace command if latency exceeds the given number of microseconds.
+.TP
+.B \-\-cyclictest-threshold=USEC
+Exit rteval if latency exceeds the given number of microseconds.
+.TP
+.B \-\-stressng-option=OPTION
+Pass in command line options for the stress-ng package.
+.TP
+.B \-\-stressng-arg=ARG
+Pass in command line arguments for the stress-ng package.
 .TP
-.B \-\-kcompile-jobspercore=N
-Number of jobs per online-core for kernel compile load
-.\" .SH SEE ALSO
-.\" .BR bar (1),
-.\" .BR baz (1).
-.\" .br
+.B \-\-stressng-timeout=T 
+Timeout after T seconds.
 
 .SH FILES
 .BR rteval-YYYYMMDD-S
-- 
2.45.1

