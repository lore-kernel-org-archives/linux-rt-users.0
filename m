Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEE85626
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Jul 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635647; cv=none; b=QWH8EvSgX44g8nPUJJ0cVRrzcgAJ+ZwXTxPZRMVFUIK0qr6QhGqsuWIulab1Af7fWG/TM5awo3zarcA72D3Uf7uPgXrQnbZpkw+Hk2rMDPBfL5s3ERJC5nUkJ5yXGgL2SozWPskxrYbWqZNWmx+IHqzPw2cVIzR6OxJ+OVMmVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635647; c=relaxed/simple;
	bh=u8VfIfcn0ipwMUDc8ebRMbfQYx8h/5yAADohPD3iYH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdSnLv++m1wwAdYdHnAT4t0fuGgUPcvOSV7uycei/2K1/LqnMSGonfXyWyXo7ingmeYmaZJXzDSh0aeXdsoYAwHXFgGtC7it5yH9jdifiY2qIS3T4vOY6daGQDSLGpPtd2mVBGiQo8HLkvkIa+0sgL9DSMFXreQNl+7Y4TjYDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L6JTDOj0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/WhK9QlV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6JTDOj0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/WhK9QlV"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M+OpSJ8wgj9CLKdG/y9A5RTuMCRTdwUB/nHHQqFIvYQ=;
	b=L6JTDOj0udXhrhrl23rgCvPzCyUZ5uDfeF/gH+ExnnY4DLoUASfzkb5Gq5N5VgbWwh3DSl
	7yELLseuo9LSJDhl6F7vQKqzFrMURti1RGBs9naXdjaR7rI+vOU/Fr0NDZuHO9gfPljPr7
	YMXFeV6I1y5T8xD1RGwJFzWjcBcoQCUDPLn7RzjS1UJAXsK78KmabyCWiBJ5VUHTa3W2Lw
	aScvGh/hl2afOivleKL1VFhpdENKUw/2901oIeSFIq9NrE2PFj8cfUWCLsR82TjnPw9BUU
	WQ9WB52Lzwx9ZyPil3bCIYQMTeeY/8UXH9O9yppCe6KNfshRpVqApHPyLXqhBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M+OpSJ8wgj9CLKdG/y9A5RTuMCRTdwUB/nHHQqFIvYQ=;
	b=/WhK9QlV1CC9ZwcLClIB7Fib3fsUUBt18jD8A4TGQlCh55alw7tA3S7oWhbHbks6Pbf8kM
	tbbST5OAHLxIG5CQ==
To: linux-rt-users@vger.kernel.org
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 00/28] rt-tests: Rework cyclictest manpage
Date: Fri,  4 Jul 2025 15:26:53 +0200
Message-ID: <20250704132721.13325-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series provides much needed bugfixes, cleanups, and updates to the
cyclictest(1) manpage.

A sample before/after view of that manpage can also be checked at:

    https://cacheline.de/pub/mainline/cyclictest-manpage-before-after.png

Thanks!

8<-----

Ahmed S. Darwish (28):
  cyclictest.8: Comment-out SPDX license tag
  cyclictest.8: Synopsis: Remove -U
  cyclictest.8: Synopsis: Remove -w/-W
  cyclictest.8: Synopsis: Remove -y
  cyclictest.8: Synopsis: Remove -h flag
  cyclictest.8: Standardize --verbose paragraph formatting
  cyclictest.8: Remove left-over comments
  cyclictest.8: Align source file to 75 columns
  cyclictest.8: Separate source sections
  cyclictest.8: Capitalize section headers
  cyclictest.8: Synopsis: Fix parameters list rendering
  cyclictest.8: Rework the Synopsis blurb
  cyclictest.8: Synopsis: Distinguish --help mode
  cyclictest.8: Group system-altering options
  cyclictest.8: Group sleep-mechanism (clock) options
  cyclictest.8: Group thread wakeup timing options
  cyclictest.8: Group SMP-related options
  cyclictest.8: Group memory options
  cyclictest.8: Group thread priority options
  cyclictest.8: Group tracing options
  cyclictest.8: Group test duration options
  cyclictest.8: Group output options
  cyclictest.8: Group x86 options
  cyclictest.8: System options: Deprecate --laptop
  cyclictest.8: Options: Expand --default-system description
  cyclictest.8: Options: Reference clock_getres(2)
  cyclictest.8: Add example invocation
  cyclictest.8: Reference rtla-timerlat(1)

 src/cyclictest/cyclictest.8 | 403 +++++++++++++++++++++++-------------
 1 file changed, 264 insertions(+), 139 deletions(-)

base-commit: 9166c3f0bb9c5d3e31dc80aff165a5073b5ac5be
-- 
2.49.0

