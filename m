Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E82FBFFF
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635660; cv=none; b=IIy4O+pi2XY8Wjh9jV63XfvpEwc6Z/8yI8om7txVXSvgDBa9unVDFg9pbJhj0xsic7c6E8Vy8C6rRGsp8lbeazek3g7eqgw4sp8MXYP9u0iTc4BH+cROb/cprha2b+KbpGHtsfIGkQ2F0/YfsH0g/N/nIkc5RFXI9li4d55F0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635660; c=relaxed/simple;
	bh=N+xJYMzTTy5LufbW/9Kr+rF1hy6SkkWDASmGPJvFTdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnZdmm5gF9oJ9U76zFolREoRWpBV15iQ/9+wcWjBw9rTuwdO2rdu5XOjShAt7H/YmB1PFPpLVRFDoty+vhrtYg6F3xAjDvQ+i+94/jjP8DY7ypWl9emI2ug7FwdxkAXPp1tRDrAWMapbb2zoP845iJEL9iWRCdhvnbXwf36OBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceMMfup5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ohrci31C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceMMfup5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ohrci31C"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HueJXEQptA44Ryo445M/s8YxdHw7iewMNw+GOscQL0Y=;
	b=ceMMfup5Gc6uwcSV6aF1hD/H9fDpfzp0OkJ58dVSQFlqyK8PZbiP8p5KWhdUMtX/AJw1NU
	DNzKpNeG0jgr7BPl7z9UqtVwLNLUdbA0+Set+0mwSccbyPDjEy7Avl1tnXhQJ2jr3hTTQc
	kDSybEemwopE3Ctv/ieL3zXbEUjtLkRZv4BZr53h92VNvYqvnMH3VPDeyqQbtCWh8/lu8x
	AHcwZRYtVsaPNCcyuFw1KUO73rd7/t4u67P0OsiYSh2s9Gd8OYGELMkLnt/Au7+sZcXLa4
	zHZmFaX+PPL7iFPvbuo8uTVJ3+i5cB7LY8xf8I+38QN1FqeEyC+Hy5O1KS8O/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HueJXEQptA44Ryo445M/s8YxdHw7iewMNw+GOscQL0Y=;
	b=Ohrci31C7kWAZTe3JFNMxUDDyly9lUaUYUyrtpRdEMQ8lqchSkzDTVarIfHypZb+cndJ7c
	uumTmOcOTHDhRXAw==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 04/28] cyclictest.8: Synopsis: Remove -y
Date: Fri,  4 Jul 2025 15:26:57 +0200
Message-ID: <20250704132721.13325-5-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a3a7ee1a6831 ("cyclictest: modify option handling to use
enumerated types") removed "-y" as a shorthand for --policy, but forgot
removing it from the manpage.

Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 312bf7a..76b10f3 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -19,7 +19,7 @@ cyclictest \- High resolution test program
 .SY cyclictest
 .RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
-[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-y " policy " ]"
+[\-p " prio " ] [\-t " num " ] [\-D " time " ]"
 
 .\" .SH DESCRIPTION
 .\" This manual page documents briefly the
@@ -41,7 +41,7 @@ in the set in numeric order, in a round\-robin fashion.
 .br
 The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
 The ! character can be used to negate a set.  For example, !B-D means to use all
-available CPUs except B through D.  The cpu numbers are the same as shown in the 
+available CPUs except B through D.  The cpu numbers are the same as shown in the
 .I processor
 field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets.
 * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,
-- 
2.49.0

