Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC91EEA2A;
	Mon,  3 Mar 2025 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042381; cv=none; b=QBGSD8yWOtnzAu0N9LVuvKF5xiGJ1B46tEURseeTsD2/1S84Y4KNig2nY/CXO4st//10nLetIhwkTd/pRCuICKZMssGVGBXtaNXOtw5vApW8TZlhfiLWuTS/EHHntxvw7R50HQpI719IWxzVySvduA05HuL0zJd0Z7tuXgzwkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042381; c=relaxed/simple;
	bh=KfiId/4HR3Wgozh0PqnBZ037FsWM5JkfptHbEcDga9U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aboIWcQFoCczu6pEUxEHO6re/9BAquXNEM8oDmRs0RurFUGqThtb/KZdmrll8AwqPy3eUvsv3AbeL3hJl5MNb7Wys3xz+U8bwX2NxgbD0G+naUzDIYVwqWuYwONZj6N5JF8OD5wECr3sOV7TN2ZX8iLFM0MiBvMQ6m6qBjJkCc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grOW8QP+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grOW8QP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F6AC4CEE8;
	Mon,  3 Mar 2025 22:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741042380;
	bh=KfiId/4HR3Wgozh0PqnBZ037FsWM5JkfptHbEcDga9U=;
	h=From:To:Subject:Date:From;
	b=grOW8QP+fyUQG0KpaiXdIr8wBsyWSLEaBktJ0xZDiz625GrvV642y8ZH1bbO2aAE7
	 66GqpDZKUfF/kc3vvR9x6QFMsmb4vfM6wtIZczRehtrR3Pqqq/uPuv8Y5U/g5rHxuf
	 EV7+PbHgCD39/2mLoeAep/4s3yAIYHHAH/Z6R38kNzq5AnAOd5HriU/r2XLOnTUfFA
	 vRCU/jwZUO11JOGBk+QnS+efK0qknkDzeUtK18mWiDfdA7m88XkP2AoMss55lperFF
	 dP9sGupr1Xpo+hoGl8pA8/zHe4c8v6SVNGXvSZcCGHAKstqAkiZdBPb9Z54M4/4Pf/
	 ESldI+yfSqpnA==
From: zanussi@kernel.org
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <wagi@monom.org>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/4] Linux v5.4.290-rt96-rc1
Date: Mon,  3 Mar 2025 16:52:54 -0600
Message-ID: <cover.1741042351.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 5.4.290-rt96-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2025-03-06.

To build 5.4.290-rt96-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.290.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.290-rt96-rc1.patch.xz

You can also build from 5.4.290-rt95 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.290-rt95-rt96-rc1.patch.xz


Enjoy,

-- Tom


Ahmed S. Darwish (1):
  u64_stats: Introduce u64_stats_set()

Eric Dumazet (1):
  u64_stats: provide u64_stats_t type

Sebastian Andrzej Siewior (1):
  netfilter: nft_counter: Use u64_stats_t for statistic.

Tom Zanussi (1):
  Linux 5.4.290-rt96-rc1

 include/linux/u64_stats_sync.h | 61 ++++++++++++++++++++++++--
 localversion-rt                |  2 +-
 net/netfilter/nft_counter.c    | 78 +++++++++++++++++-----------------
 3 files changed, 98 insertions(+), 43 deletions(-)

-- 
2.43.0

