Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE919CCFC;
	Tue, 31 Dec 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735665707; cv=none; b=Ag6xGYFwC11JP+k+UTci12hh9u2FzOdKUVDT7+ISPnheMPEYUleq9qd4na03exfkiSj002V+v56HElJBTPBEqq/KFfY5kqmPUqikDs2lp6AT9ke94Cb4M/ObSzvAlWgaR62kv8E03jTbEQVg+nBIzq4/dMftyeyQRHv2x2pOqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735665707; c=relaxed/simple;
	bh=AS7sFPEyloo9TYdS4oO3ZNs7ufXRc7lIn0buH0r6Efo=;
	h=From:Subject:Date:Message-ID:To; b=gwI2MBEuJQzVaRKAGF4o4sd1mjVf2iUFUpEzorAlQDZ5j90TJzsQiCG1u6CDy8jz0HB3ylv1bEI2X8eZkLLu4/dM3D7ENlYRo5tAn7PMz3RfP7b9APi+h6VDMGSc7E/hN9wdFao/I1lBzVpPtqhzXcy73jnFS6Z2NhZU5QbO1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26456C4CED2;
	Tue, 31 Dec 2024 17:21:47 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.120-rt47
Date: Tue, 31 Dec 2024 17:16:49 -0000
Message-ID: <173566540925.1432029.4935545966181953250@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.120-rt47 stable release.

Well, not so much pleased as embarrassed :)  This is a fix to a mistake
I made when doing conflict resolution for merging the 6.1.120 kernel
into the v6.1-rt stable tree. I picked the wrong diff hunk for the file
drivers/net/vrf.c, which caused a reference to an invalid structure name.
I compounded this mistake by skipping an 'allmodconfig' build, so shipped
a borken vrf driver.

Many thanks to Ranjan Dutta for pointing this out!

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 029f397b09cddc99b8748dc23a4c3d5a5cb1c85c

Or to build 6.1.120-rt47 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.120.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.120-rt47.patch.xz


Enjoy!
Clark

Changes from v6.1.120-rt46:
---

Clark Williams (2):
      net: fix mis-merge from stable in drivers/net/vrf.c
      Linux 6.1.120-rt47
---
drivers/net/vrf.c | 2 +-
 localversion-rt   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index c3e5fb98cf7f..164ffe1919de 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -154,7 +154,7 @@ static void vrf_get_stats64(struct net_device *dev,
 			tpkts = dstats->tx_packets;
 			tdrops = dstats->tx_drops;
 			rbytes = dstats->rx_bytes;
-			rpkts = dstats->rx_pkts;
+			rpkts = dstats->rx_packets;
 		} while (u64_stats_fetch_retry(&dstats->syncp, start));
 		stats->tx_bytes += tbytes;
 		stats->tx_packets += tpkts;
diff --git a/localversion-rt b/localversion-rt
index 272158183778..8a777ac42aab 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt46
+-rt47
