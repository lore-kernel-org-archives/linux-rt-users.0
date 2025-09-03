Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC331A76BB
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Sep 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898256; cv=none; b=bJf5tl/gv6NgFDesTnUi4c012kgXSuWz6HQPE41fcmYSLsyjW9qO+zcqc1jApzrDRPT6U3RqyPbx0rySHYxlykW1vxhS+d5GHo5T36/DPnHxyhj4P16qWFapHwjJEQu1L8w0+xZC8FKPscsYfLCC6CkIu82HQzqQ0KkoJM9roEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898256; c=relaxed/simple;
	bh=YfW8CikyODmWzz19wtphnvtHchg7AzySlOPBhOcGXNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT1ei8vWvw69GU2ADChVnwGIbxTN/AEPBGrzTygHzTvUzRtO2ijabwkX3bIE7zYXylgzwLq69+WlU716Qs5l98Qs8Quuo015hBZoL4lTEv258H85nLNKQnFNQThpvLPboZY7+vVrsE5A7sUfkE5jTl/VIFJEj3rcm1jukTvITSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gPwl7ohM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SXmmPijh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gPwl7ohM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SXmmPijh"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756898252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjgQIaSaC6bT3UoB7IFKgQVPoTJl2ksrtImBsd2yfAg=;
	b=gPwl7ohMFVHdtNdAgmpB1xxVuHyb/YZ4295ZALmNp99qchw87TjkapplHfzZZDYlCTrgYO
	6ToJryeMjjf1Rv8XuYwf29QfLqdqGirVDWfQ9aR9IUd1VsEY0hMPXyYAoZQSRojpVXtsv3
	zyLIKVdmzXSbr+DkEWvqTuzHwUx8DNPQNNPhUC33Ugjf8YdYklDmZyL7rIH3WNyJvmTz5d
	baCmpx39/HfVEu02WzMu2mQsziCSE+WZTfdU32gXdyXyPZHEF7YtD5yixx3jq2EacjDfq+
	A+PO5MBWl+TCo+cgnaO+KuJw3VMpfHo7INYwRC0bHBwVXgZFWyFzQ+7oa0V3Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756898252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjgQIaSaC6bT3UoB7IFKgQVPoTJl2ksrtImBsd2yfAg=;
	b=SXmmPijhjG70hwpBWNqrFESGN5z/9LarQEsUoexQY+lkQAlwzgzBG5yw6ig3rlI1QkIASc
	pmX3ta0A4QujRzDQ==
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 01/10] README: Drop "debug" from the tracing path
Date: Wed,  3 Sep 2025 13:17:08 +0200
Message-ID: <20250903111717.1391196-2-bigeasy@linutronix.de>
In-Reply-To: <20250903111717.1391196-1-bigeasy@linutronix.de>
References: <20250903111717.1391196-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The tracing interface moved away from debug/ configfs. It moved one
level up and the debug sub folder has a compatibility mount which will be
removed.
While at it I noticed that the -f option is long gone. Take the
opportunity to update this, too.

Update the docs accordingly.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 README.markdown | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/README.markdown b/README.markdown
index 3ab6ddf53c7ed..617b57e88614f 100644
--- a/README.markdown
+++ b/README.markdown
@@ -57,15 +57,16 @@ then probably be regarded as real-time capable.
=20
 What, however, if the latency is higher than acceptable? Then, the famous
 "*latency fighting*" begins. For this purpose, the cyclictest tool provide=
s the
-`-b` option that causes a function tracing to be written to
-`/sys/kernel/debug/tracing/trace`, if a specified latency threshold was
-exceeded, for example:
+`--breaktrace` option to halt tracing if the specified latency was exceede=
d. A
+tracer must be configured upfront. The resulting trace can be invastigated=
 in
+`/sys/kernel/tracing/trace`, for example:
=20
-    ./cyclictest -a -t -n -p99 -f -b100
+    echo function > /sys/kernel/tracing/current_tracer
+    cyclictest -a -t -n -p99 --tracemark --breaktrace 100
=20
 This causes the program to abort execution, if the latency value exceeds 1=
00
 microseconds; the culprit can then be found in the trace output at
-`/sys/kernel/debug/tracing/trace`.
+`/sys/kernel/tracing/trace`.
 The kernel function that was executed just before a latency of more than 1=
00
 microseconds was detected is marked with an exclamation mark such as
=20
@@ -80,7 +81,7 @@ latency.
 If the trace output is not obvious, it can be submitted to the OSADL Laten=
cy
 Fight Support Service at
 [latency-fighters@osadl.org](mailto:latency-fighters@osadl.org).
-In addition to the output of `cat /sys/kernel/debug/tracing/trace`, the ou=
tput
+In addition to the output of `cat /sys/kernel/tracing/trace`, the output
 of `lspci` and the `.config` file that was used to build the kernel in que=
stion
 must be submitted. We are sure you understand that OSADL members will be s=
erved
 first, but we promise to do our best to help everybody to successfully fig=
ht
--=20
2.51.0

