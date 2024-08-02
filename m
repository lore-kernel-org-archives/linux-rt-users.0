Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DD1F61C;
	Fri,  2 Aug 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610909; cv=none; b=t2OukXZQdVfbsMN/Eq+Gw86LGeD94aC2PCx8xZqs74EkoV0zuKth45g9EI5xS3X9n3owB22fcfMaC9/VfqYkmX1KnApAfTiFIAO6ziy0/nSZ80r2SBigl8t+/b+/lc0aX51zGHQsUP3OKqMb1gDTjWjo73sVEwAe51sPpu3W0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610909; c=relaxed/simple;
	bh=TNm8PThnDv3WiKDoRpzIgsXgANDIKlBfgmOcRi0bBA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jcIJLHnjdfPnnDY2p5uPSvGiuSnllcY5dKP6h7J2VW+q2VwGuDrBA2nJP+RT4yB8SIe2hMcpf32qtSrG6Pzj3MBVXJeL22vjAnJvH7HZGRQbnDElHBojrKXqEOVufgLTiB/x9iY9zTyJV/0zpDrLOVQGSzC+y5kLprJECZ0uWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VFImo5/x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jv234pF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VFImo5/x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jv234pF"
Date: Fri, 2 Aug 2024 17:01:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722610906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qiXrXAu2b5HCw8e2JvrpCFrTKk34pc8sz9ZEqzZRQd8=;
	b=VFImo5/xyeQAy0j43Ctur8q9x0VD/kZpRtSM3Pw55f1YnUj1o8jEYTq4zohAWuXM4Ix93T
	+Uj5WgGCC+l9z8FegxQiMu9kbH6WJIsezZQeYuGdRXvHSNK2H1hlIB3r1Ga2izNI2eqACD
	cwYo1OirdmhOOrdOGncACenS5IcA/PdKBgqNb/5UBZrcuDh3ndzfbkQ6UsTdvFwzZB8S9r
	mti1mRXmhoTtDVPPEsNMGig/k1wLSn2kQe/JGuk+3+PQRFylmdh6ExYJy4ozK3pTNMetrn
	eNUZDDm6+6r/yc3Tm5fmVjX1hQ2trOM+MNUV47BM9vEdwuDgbPeJ9z9fbqFCTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722610906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qiXrXAu2b5HCw8e2JvrpCFrTKk34pc8sz9ZEqzZRQd8=;
	b=2jv234pF6SSN5L87wGOUxKd0tEsAMbUdHihsJSfQfuKeEnCYIudFpo4J6kaE2GmApkMCOg
	+vkyCPhIE3beNICA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.11-rc1-rt1
Message-ID: <20240802150145.pIfTM_ju@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.11-rc1-rt1 patch set. 

Changes since v6.10.2-rt14:

  - Update to v6.11-rc1

Known issues
    None.

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.11-rc1-rt1

The RT patch against v6.11-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patch-6.11-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.11/older/patches-6.11-rc1-rt1.tar.xz

Sebastian
