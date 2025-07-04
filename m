Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556602F94B9
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635673; cv=none; b=ZjvYDSY3mk3zvjxZuk0AKQPHOO5wg3W+5x17KShR3byMNnTIid0sdT3ks1hzVz31daIgPGGw6M7OJHWlyCeoD0C6hhFO8HD96JrNGftT+mWtO6itC4ACF9s029yqdxdWk0+sbB5wusEj9YH2bdSFHZn2q73jNC4Bp0oqzJiBw5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635673; c=relaxed/simple;
	bh=KMixi9uftAyvWos2OBiSD1yecmq4iivjBBIk6dhc1UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNou4yAqYv5lcmAOew5bcaV42nOBR2VNMuTcwycwG08ejw3W/d/MqVS1IHGQ+Q/Fg41oM+HYQSboMBj0+4GTy+ii8zoKJW5GkS7DNXm3G4Fuete5LNy8IZbKpB/77jOY++r2Ror3jaoCmTcgzPOYXBcDRlN6RURurjqScG4oCIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xkZBk2mJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lsfv2p8/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xkZBk2mJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsfv2p8/"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+tfH6Aed8OkMGR4iTr5d+z2ezk28k2q1sUU7khdZT4=;
	b=xkZBk2mJdLFqvqSeAziWmxLD64me0xFtBG02AoiUsVTIm6RLHNgf5StONojQ51SLJjUWP3
	uW/CZeledZ/JHM0FNEFkt/plmxdhNr/n55iuKMZ/UDDBF6cwmqm9rkGZr8XVIenI30WvZF
	fKSYL2/Ioamx7Yjpsyyvv2yWLSQ+A2F7uzH+f7hO9JBZRElKAMskboWPnQ6255JxN5JKEH
	meF9tFmbJsYN/sPC5ljCrFts3jbVmm+zGrvnmQmfVylbbh8ewXpbIud6nmCpRs/NcTwGCQ
	A7aIaWI7TPe1ZMLaAM/Wj2IGmHmbnV8Qlr0YC5rXswgJW8B+c4nl+zW2dBTXlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+tfH6Aed8OkMGR4iTr5d+z2ezk28k2q1sUU7khdZT4=;
	b=lsfv2p8/SqiBwOul7gusNI0jqybbMMR3K8bqrQNPHjJwJ4h+C2ywgW8e1qz7769+/JEeTZ
	X/aNF2MdtTnUu0BA==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 07/28] cyclictest.8: Remove left-over comments
Date: Fri,  4 Jul 2025 15:27:00 +0200
Message-ID: <20250704132721.13325-8-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the cyclictest manpage source by removing all obsolete comments.

Per commit 79ad2eca9abe ("COPYING file and cyclictest's man page added"),
most of such comments are random leftovers from the original template the
cyclictest's manpage was based on.  Namely:

(a) Remove emacs markers; modern emacsen do not need them.

(b) Remove the roff macros description table; they're all already
    documented at man(7).

(c) Reference groff_man_style(7).  Per man(7): "man page authors and
    maintainers who are not already experienced groff users should
    consult groff_man_style(7)."

(d) Remove legacy, commented-out, earlier cyclictest descriptions.

(e) Remove a reference to info pages; cyclictest does not have any.

(f) Remove an obscure joke about the manpage being written by "The Rise
    and Fall of a Fooish Bar."

With this, further documentation cleanups will be easily stacked on top.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 803c5fd..d4ce648 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -1,18 +1,6 @@
 .\" SPDX-License-Identifier: GPL-2.0-only
-.\"                                      Hey, EMACS: -*- nroff -*-
+.\" For a man pages tutorial, check groff_man_style(7)
 .TH CYCLICTEST 8 "April 22, 2016"
-.\" Please adjust this date whenever revising the manpage.
-.\"
-.\" Some roff macros, for reference:
-.\" .nh        disable hyphenation
-.\" .hy        enable hyphenation
-.\" .ad l      left justify
-.\" .ad b      justify to both left and right margins
-.\" .nf        disable filling
-.\" .fi        enable filling
-.\" .br        insert line break
-.\" .sp <n>    insert n+1 empty lines
-.\" for manpage-specific macros, see man(7)
 .SH NAME
 cyclictest \- High resolution test program
 .SH SYNOPSIS
@@ -21,18 +9,11 @@ cyclictest \- High resolution test program
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
 [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
 
-.\" .SH DESCRIPTION
-.\" This manual page documents briefly the
-.\" .B cyclictest commands.
-.\" .PP
-.\" \fI<whatever>\fP escape sequences to invode bold face and italics, respectively.
-.\" \fBcyclictest\fP is a program that...
 .SH OPTIONS
 These programs follow the usual GNU command line syntax, with long
 options starting with two dashes ('\-\-').
 .br
 A summary of options is included below.
-.\" For a complete description, see the Info files.
 .TP
 .B \-a, \-\-affinity[=PROC-SET]
 Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
@@ -184,10 +165,6 @@ Use POSIX timers instead of clock_nanosleep.
 .SH SEE ALSO
 .BR numa (3),
 .BR numactl (8),
-.\" .br
-.\" The programs are documented fully by
-.\" .IR "The Rise and Fall of a Fooish Bar" ,
-.\" available via the Info system.
 .SH AUTHOR
 cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
 .PP
-- 
2.49.0

