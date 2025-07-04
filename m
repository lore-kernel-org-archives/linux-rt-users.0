Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C12FBFF2
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635686; cv=none; b=b81LtMSHpe5kHQGanifWiX4erylEcdtLEzNl0TwShWkNw/t9vbRsMiYfz0bS9abKJ7GV3q9PGvFm9sZwxHRiMMDgjY61uSfhacNJSNwHFl/rWGqXEDLwZl5iEHPQPf28ROc43oLJYsbFiCsCJ2RHwohE8zIrwHOmGivQCE0LBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635686; c=relaxed/simple;
	bh=3rfEWGFGBO2a0cffrhybTn/hrIosNQA69VEl6dW/PZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQv5OtG30Tdme/qt94nfO6OhMQlJThJv6gCrKd31ygDHlGPfSHQPveEi1d7zSPgNje5/wkNJ+DNWSCpIlgQn9aRLPw/mN1lQBHRnH1WaZtDlCCkHKatpl3hPB3AUl6jbR8Ifa2kHAjtuVmj7o1ZAJqc4LrjxPxnFuVuUU1kQFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZ8DvI8d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+QF6NLGv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZ8DvI8d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+QF6NLGv"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3j51knG5wnPVzpeVpHPiWEK8D6MVGHoui/EoWQWvjw=;
	b=fZ8DvI8dQjwNPFuHwEARA7S1uTwfYuAPb+owV+Bak2uqIV+eJVFDHOKa2cCOcVRCRHqZlo
	+M5rbcHJbwehSa65Ed+QZUa4pbs4JOsq3BEzw8GGg1lklcD/t/XcgjxuGqh1cCX394PVZP
	pbxi1NDgQHek6oNb16qcZthGah8x6xzTXioWrjInM2aTIylANHykpXWb0yfDmKAnJyUe1R
	j2oBAi6tth2D4+XnkWDii8KjXyczq7DUORG3SQ2m5FcY84vfJ7+dU2OC77I/f57deMnNcC
	wCHUAGCU3WCgPGsvc4Z4eV5EIZeS23l4VhGuWAFnXQ2VosRe7xOu1d9CG/4ruA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3j51knG5wnPVzpeVpHPiWEK8D6MVGHoui/EoWQWvjw=;
	b=+QF6NLGvXJg9Id5ra0gBK2e5YY93CAIEIgay6lWkQzSE8a7b7yLrksxkxoH7x7t4yJu+U1
	kW5fZa6sxu5w5pCw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 10/28] cyclictest.8: Capitalize section headers
Date: Fri,  4 Jul 2025 15:27:03 +0200
Message-ID: <20250704132721.13325-11-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per groff(7) and groff_man_style(7), capitalize the section headers
without resorting to all caps.

This makes the manpage's output calmer to read as well.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index f27fe66..7f1bd39 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -1,17 +1,17 @@
 .\" SPDX-License-Identifier: GPL-2.0-only
 .\" For a man pages tutorial, check groff_man_style(7)
-.TH CYCLICTEST 8 "April 22, 2016"
+.TH Cyclictest 8 "April 22, 2016"
 .
-.SH NAME
+.SH Name
 cyclictest \- High resolution test program
 .
-.SH SYNOPSIS
+.SH Synopsis
 .SY cyclictest
 .RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
 [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
 .
-.SH OPTIONS
+.SH Options
 These programs follow the usual GNU command line syntax, with long
 options starting with two dashes ('\-\-').
 .br
@@ -229,11 +229,11 @@ Print info userful for debugging cyclictest
 .B \-x, \-\-posix_timers
 Use POSIX timers instead of clock_nanosleep.
 .
-.SH SEE ALSO
+.SH "See also"
 .BR numa (3),
 .BR numactl (8),
 .
-.SH AUTHOR
+.SH Authors
 cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
 .PP
 This manual page was written by Alessio Igor Bogani <abogani@texware.it>,
-- 
2.49.0

