Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4D430B9F
	for <linux-rt-users@vger.kernel.org>; Sun,  1 Mar 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772400287; cv=none; b=TEyrvHU+deVV5OCapYku++lo+3g4fmWuiIW/jDCbXY60kZTcAp9VxwvLoS8Hsu4GV+nQn/At/V2vt29KVbtnSYngecWB9jnS9jusSr8u/aSMsBDJ7DXS9CeJEXBhKhAFEbkf5rP9zY21keoHTpbmllSTSimzBY9l+qZHPrtjjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772400287; c=relaxed/simple;
	bh=5XqZj8CXzdqrmLqNPsiyDtv9Uvp3NHJACINqWEYt6Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMQ7UhEC0+Imbqmoyrcg1sPmC6a0OO7RHwe6ABWtgnpSVCo0VfAt9dQazzD36fRj6jC05YaRfUJs2491Dja3b9K5GDRdSWqKa57QgcJhkPMuqQT4YTHPu44HNVSV/6EEBKN53N9ZboO8NX9PmoZe7oFm+cWj5DEbDMaPzNcH8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wsHq5evn; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wsHq5evn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wsHq5evn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wsHq5evn"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fPFSh6455z9sdH;
	Sun,  1 Mar 2026 22:24:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772400276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RuAu+0AZOVXubAWonL1sk5zJjFoBBZS9Iz+w9BTJIYI=;
	b=wsHq5evn66gWDE7nK/gjceXx2giNlosPXn/MFDxil+CB3IwHQB6e12Y8sSZatUGLpI/kv4
	hXfVYx9hppkO9XRRWhE6qLz0tWuiZosk89mRbBECE12Zt0CV05zDG8sp5NZOFwE/SbakZB
	arBqUsjhvT+Ejp3QUsCsLGhw+pbzKGbpwXtkmBeQ6hM0u3WK2KlhDdjEcHi4ozz+mKjGtp
	FAyGBmSYvTw6r4Vj0HBiH0nPlZjbp3VLfN9s20Zox0sZCENgjnKxJjyt2zLUjZYvAfWJRE
	s5VNobR04zCHooxFsi+0nYH4aTUcKnneEvDfAzxsOdarG9ANVYUjhob2ZZguaQ==
From: Lukas Beckmann <lbckmnn@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772400276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RuAu+0AZOVXubAWonL1sk5zJjFoBBZS9Iz+w9BTJIYI=;
	b=wsHq5evn66gWDE7nK/gjceXx2giNlosPXn/MFDxil+CB3IwHQB6e12Y8sSZatUGLpI/kv4
	hXfVYx9hppkO9XRRWhE6qLz0tWuiZosk89mRbBECE12Zt0CV05zDG8sp5NZOFwE/SbakZB
	arBqUsjhvT+Ejp3QUsCsLGhw+pbzKGbpwXtkmBeQ6hM0u3WK2KlhDdjEcHi4ozz+mKjGtp
	FAyGBmSYvTw6r4Vj0HBiH0nPlZjbp3VLfN9s20Zox0sZCENgjnKxJjyt2zLUjZYvAfWJRE
	s5VNobR04zCHooxFsi+0nYH4aTUcKnneEvDfAzxsOdarG9ANVYUjhob2ZZguaQ==
To: John Kacur <jkacur@redhat.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Lukas Beckmann <lbckmnn@mailbox.org>
Subject: [PATCH 0/2] cyclictest: fix growing shm stat file
Date: Sun,  1 Mar 2026 22:24:05 +0100
Message-ID: <20260301212407.3146506-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a456458cb932c7a180a
X-MBO-RS-META: thsjpr54s84xa481fgndwd4k6eg1j3pw

I recently started using cyclictests with get_cyclictest_snapshot and
noticed that the shm stat files grows indefinitely.

Example:
for i in {1..10}; do
  killall -USR2 cyclictest
  sleep 0.01
  ls -lh /dev/shm/cyclictest* | awk '{print "Size: " $5}'
done
Size: 1,4K
Size: 2,8K
Size: 4,1K
Size: 5,5K
Size: 6,8K
Size: 8,2K
Size: 9,5K
Size: 11K
Size: 13K
Size: 14K
   
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>

Lukas Beckmann (2):
  cyclictest: fix growing shm stat file
  cyclictest: simplify rstat_setup

 src/cyclictest/cyclictest.c | 90 ++++++-------------------------------
 1 file changed, 14 insertions(+), 76 deletions(-)

-- 
2.53.0

