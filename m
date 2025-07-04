Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230E2F94A2
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635692; cv=none; b=ThbMKJtRhgiGZMtvStr12ZA5mG7tPW06qVc4oJoXG/REIAKSXVpX7FadIVS1KFB0MGaXjdTQ7n9P3I4KCcpsZMGZZ1vnwuaTySS8twePPxT0LTlVo8BpqlPNSJ4ljnfUh//+l8MVAy07p8YYBC4Eoe4TilkytI70bfaAxKnF84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635692; c=relaxed/simple;
	bh=mr0bTOd5elN8Mgvk5KW6oROsWE8GJSRMpxWSCYfkNYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2JfhihkfJ02ja9uiO+GG1WTOB0xnlcjGIjZ74NQV/9Xbed4sbs8PU8Cga6Dmdqgvn5X++iLETRK30VsNQWH2Bsgy1JqnWvGkvTjbGctp4NGNEo4aT96LfGFub9cQ6bKmXxyY6LZhLxH6JV5p80UVRB78hsANkUqzdiWENQMlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+Apqa8c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4aDiXrK7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+Apqa8c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4aDiXrK7"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L54QKBic5uMq+7QG8Lj5SOME+zcfGBOYnfwsitm+xl0=;
	b=m+Apqa8cIAw611C/BTbY4iQ+Z1IhnzkWwmMwFufjQqWOewkT62Q+i7KPfJXbZe1vYOLCsN
	zDFDkR7zp+joulB3gCjVAiXVntVfAOt1jZFMXmcQmpxKpNI4LJ2g1H2legyfnqXA/LYWSc
	ATGsu1Y/cnZpo2R4jZlG3UH4fdiMPvvjNp72btInmYF/YqQ+YLAK0BHwWbGZ3AdFFy6i86
	WUxC3KyhbRUvkexJh3rd3T6zjucLy/pxDVMR0R/w0VIeR+lMWq0rpvpcSxQyJKb3m//rfu
	eurh+RV4acuDuqGlHun6j8Q/QJeGz8FC4TuyzJdzWF355TdTY6Fa77qmQsMPFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L54QKBic5uMq+7QG8Lj5SOME+zcfGBOYnfwsitm+xl0=;
	b=4aDiXrK7FEp0DZQNS7GDFbAcFk95Ztcn0yYM7iMKWr1vtHdqn88gF9BPrivSPk5N5/snuz
	ME1ARUMKJvAx0tBg==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 12/28] cyclictest.8: Rework the Synopsis blurb
Date: Fri,  4 Jul 2025 15:27:05 +0200
Message-ID: <20250704132721.13325-13-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cyclictest's SYNOPSIS blurb is buggy and incomplete.

For the cyclictest's flag list:

  - Remove 'f', for --fifo, as it's not a flag and requires the fifo's path
  - Add 'N', for --nsecs
  - Add 'R', for --resolution
  - Add 'S', for --smp
  - Add 'u', for --unbuffered
  - Add 'x', for --posix_timers

For options with arguments, expand the argument names with something
comprehensible since the whole purpose of the SYNOPSIS section is to get,
in a blitz, an understanding of the tool's actual options.  The original
argument names, especially when -combined with the one-letter option's
shorthand form, were totally -incomprehensible.

For consistency, be coherent regarding the arguments' names; e.g.,
"*-path" for all file paths like file-path and fifo-path, "proc-set" for
cpuset-related arguments, "num-*" for counts like num-threads and
num-loops; "*-usec" for microsecond arguments, and so on.

Also add the missing options --deepest-idle-state, --histfile, --latency,
--mainaffinity, --policy, --spike, --spike-nodes, --dbg_cyclictest,
--default-system, --smi, --priospread, --smi, and --tracemark.  Do not
add --laptop since it is deprecated.

Note, this makes the cyclictest's SYNOPSIS blurb complete and gives a
comprehensive view of cyclictest's abilities in a glance.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 57 ++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index f093677..0271f5c 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -7,33 +7,58 @@ cyclictest \- High resolution test program
 .
 .SH Synopsis
 .SY cyclictest
-.RB [ \-fmMnqrsMv ]
+.RB [ \-mMNqrRsSuvx ]
 .RB [ \-a\~\c
-.IR proc ]
+.IR proc\-set ]
 .RB [ \-A\~\c
-.IR align ]
+.IR alignment\-usec ]
 .RB [ \-b\~\c
-.IR usec ]
+.IR break\-usec ]
 .RB [ \-c\~\c
-.IR clock ]
+.IR clock\-type ]
 .RB [ \-d\~\c
-.IR dist ]
+.IR distance\-usec ]
+.RB [ \-D\~\c
+.IR duration\-mhd ]
+.RB [ \-f\~\c
+.IR fifo\-path ]
 .RB [ \-h\~\c
-.IR histogram ]
+.IR max\-latency\-usec ]
+.RB [ \-H\~\c
+.IR max\-latency\-usec ]
 .RB [ \-i\~\c
-.IR intv ]
-.RB [ \-\-json\~\c
-.IR filename ]
+.IR interval\-usec ]
 .RB [ \-l\~\c
-.IR loop ]
+.IR num\-loops ]
 .RB [ \-o\~\c
-.IR red ]
+.IR oscope\-red ]
 .RB [ \-p\~\c
-.IR prio ]
+.IR thread\-prio ]
 .RB [ \-t\~\c
-.IR num ]
-.RB [ \-D\~\c
-.IR time ]
+.IR num\-threads ]
+.RB [ \-\-deepest\-idle\-state\~\c
+.IR idle-state-num ]
+.RB [ \-\-histfile\~\c
+.IR file\-path ]
+.RB [ \-\-json\~\c
+.IR file\-path ]
+.RB [ \-\-latency\~\c
+.IR pm\-c\-state ]
+.RB [ \-\-mainaffinity\~\c
+.IR proc-set ]
+.RB [ \-\-policy\~\c
+.IR threads\-sched\-policy ]
+.RB [ \-\-secaligned\~\c
+.IR wakeup\-usec ]
+.RB [ \-\-spike\~\c
+.IR trigger\-point-usec ]
+.RB [ \-\-spike\-nodes\~\c
+.IR num\-nodes ]
+.RB [ \-\-dbg_cyclictest ]
+.RB [ \-\-default\-system ]
+.RB [ \-\-priospread ]
+.RB [ \-\-smi ]
+.RB [ \-\-tracemark ]
 .YS
 .
 .SH Options
-- 
2.49.0

