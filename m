Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B062250BE9
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Feb 2025 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159879; cv=none; b=P3scaOcU8W3I0W74gV1JXoGEeVo9Mv4UVGnuOX6e6diwX78UABmK32GOH12CjJbEyUskb2wjXtj1VZbJ+aB3ElcNsAn7cpq4SoOY9gWaqV88BQC44aNSpq4T6z3K9fIyBhCj0j2TYfjJ0EbACS09T1qUUEsbXoISX1y7Q0fPZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159879; c=relaxed/simple;
	bh=ZCFO9J/fH3XF26w4a3MwKwfke0e8Eoa33vEQDv8wvi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BT90i5bMz1KlEMQnCcoJ/gHf3bPD8bTaq2BgBKXYA02jdyKV7S9Ydf4GaNRh4KQ7r1iOHQ+fxU/AJWcN8TPFokJDIOR+iXn17o8p3dlt12v3nzu0bb9hU0QCrXppSimUne4KO+Rt6gjlgzIWDM/EGcbBIEZLT3BFCeew2xXE9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=bXs4xoLS; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="bXs4xoLS"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250221174427ec90cd4b6be9be2cac
        for <linux-rt-users@vger.kernel.org>;
        Fri, 21 Feb 2025 18:44:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CyWYjLwgEFVupC+lE6T8M2W06qMt1/E9bEONKE95mfM=;
 b=bXs4xoLSnM3/LFNQ3e6xD/M4j7W7jTZBDOi1WGxYNnec5GLAP4QZooOyTV1MyRqV4xQHGL
 EogK2mkLxDyMG+nqtTM2QmwXHYuzM5MHulRwTjUdXnTdO5ED0TbzbM2Ufvm3Hyd0szZH36mW
 fAKeZmO4BVjOEA+qaEi5+B3C9nsCTF16feTKlGAkl/Za1Z8QlqArHD8uUG8gyLrCjiA1K+xx
 SIenUGfqOtlkI0EW6RiOd3JoMosvZU2OZyPLy7c5eNL4imPu4SXgfuCzqDnT0XN71muNDKFs
 RcX9x05dU6CgCp2vbR4VQn7JfTadMbx0/bTXkktD0hVpemmh2oLZuZaQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
	stable-rt@vger.kernel.org,
	Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>,
	"Ahmed S . Darwish" <a.darwish@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [5.10-rt][PATCH 0/2] backport of RT fix for nft counter
Date: Fri, 21 Feb 2025 18:44:24 +0100
Message-ID: <cover.1740159866.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

As 5.10 requires some manual work, here are the two patches needed to
address [1].

Note that 5.15-rt already has the fix (f036d9effdba). 6.1-rt and 6.6-rt
can pick 4a1d3acd6ea8 without conflicts or dependencies.

Pavel, please check 4.19-cip-rt and 4.4-cip-rt. I suspect the task is a
bit bigger there if more or all of u64_stats should be missing.

Jan

[1] https://lore.kernel.org/stable-rt/CAMLffL-PTp+Y-rXsTFaC5cUJyMMiXk-Gjx59WiQvcTe46rXFrw@mail.gmail.com/T/#m67dce3408cac40318ae3dbe1c713b13621ac66c9

CC: Ahmed S. Darwish <a.darwish@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Ahmed S. Darwish (1):
  u64_stats: Introduce u64_stats_set()

Sebastian Andrzej Siewior (1):
  netfilter: nft_counter: Use u64_stats_t for statistic.

 include/linux/u64_stats_sync.h | 10 +++++
 net/netfilter/nft_counter.c    | 78 +++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 38 deletions(-)

-- 
2.43.0

