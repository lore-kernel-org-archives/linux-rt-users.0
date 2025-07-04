Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6578B2F94B4
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635714; cv=none; b=bhVRMpwctqRPSRzfFFqbz+dnJrf7CGUnVE1hIk3WEgOdL/lhOwv3G2ssGn5AgOXslIhcyzGoX+nfwfa5QZL1gHXbKty8ixU5v2rQ22a/+BpUniU/D9AXT8m67EhmLNmu6Lxob/8AAP+pdIHYGVH5hjBe3i5JGCW8x1rIEAkiQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635714; c=relaxed/simple;
	bh=bR6AN+iHDqbpjqvCAf56psCwsxEbfEHD9gMZivmxyRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAi2YcasMNOfj8b+5UXLMWxeWhA5zXZxPRBXugfB2qMQdE9cpQGFG8Xkh2kuDBHj0FuZSNUo5N2W90z75ikAPNwZKxI7DanWA6sxeliZRxtdLe1wra/BAJM6pXj/8gCFnz6DNnTlJ2dKZYCxyBzKdTQIhWDDaLbII9ASjmxUaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/6vIWNv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQqj8dga; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/6vIWNv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQqj8dga"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hdx9AkL/IMIPasiaQWdtH0jeBR3WRhveQhvOShXUoms=;
	b=T/6vIWNvYSxhKkDXmb2gwAhEvmbeEHsoq9szJaPDmP//ud62sUyBKhEenAEllGG9Uz8abM
	IcPVkR/CcYUhFr9dQjbejqa1px9zzJNB6+8bKkxytofJTOptWXVM7xXZ8J/j9cOtb+UZVV
	0VvF1rxHNHQaa0HBgRXHCgRJuzNhZmhd7qMl+5E6c7IBRjw2no1K6dP3NXrpkR2mnZeppu
	DSa6pYede9y84FaiZJptMjmQcfZxM7Fm8YkpGCea8P4BEdjfFwMc/c9kFXGY2frWxAKNST
	N6vTQqu/WgoDEDKlWAApp8SUrBQu3gJDJ8E3tzt6xyo0LGYECFiHSMmazQQ+0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hdx9AkL/IMIPasiaQWdtH0jeBR3WRhveQhvOShXUoms=;
	b=PQqj8dga2LOR+1iIBG/5/a2SfB7PsLxAII8wNcs5T4T5aXOSFCcSXCVsik6oBczyHFJbiq
	ADdGOzydXJc4jODg==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 18/28] cyclictest.8: Group memory options
Date: Fri,  4 Jul 2025 15:27:11 +0200
Message-ID: <20250704132721.13325-19-darwi@linutronix.de>
In-Reply-To: <20250704132721.13325-1-darwi@linutronix.de>
References: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number and breadth of cyclictest's options is huge, and just
exploring them in sequence can get the manpage reader lost.

Put the cyclictest's memory-related option:

       -m, --mlockall

into its own group.

Further groupings will be added next.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 src/cyclictest/cyclictest.8 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 7fc0420..a099416 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -180,6 +180,12 @@ field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
 sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
 v1, PROC-SET, if specified, must be a single CPU number.
 .
+.SS "Memory options"
+.
+.TP
+.B \-m, \-\-mlockall
+Lock current and future memory allocations to prevent being paged out
+.
 .SS "Other options"
 .
 .TP
@@ -223,10 +229,6 @@ for automated tests with a given number of test cycles. Cyclictest is
 stopped once the number of timer intervals has been reached.
 .
 .TP
-.B \-m, \-\-mlockall
-Lock current and future memory allocations to prevent being paged out
-.
-.TP
 .B \\-M, \-\-refresh_on_max
 Delay updating the screen until a new max latency is hit. (useful for
 running cyclictest on low-bandwidth connections)
-- 
2.49.0

