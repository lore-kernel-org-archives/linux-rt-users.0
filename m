Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73467207E1D;
	Tue,  4 Feb 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681525; cv=none; b=AroWdagYQ4iScLGPKh1pHI6ofFaUa/caBa94lXlrL1zCkrJmmrb8p0ETfCj5UlrRNVrMTU1luL+0kTwjG7pbM7rwpNjN0Kf9vqAivkaNprBt8GN5fySXdjow6pW1NpYu/VuYPFavSMXXFJT8rfIxN+QICY80zXmsNN/ju7xhFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681525; c=relaxed/simple;
	bh=HvW+eT2pSS1IA8hQr940Rjf5CHjdOYbpmQD8J+xjr0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qqf5w/Vg2Vfe0nv6llBFGUBFp/7G/qMa07U9xhM4aULSJGLhJwOPTAtoYWEtDy1fQmtLJauu27Dsh8lgQGLJ+nDGc4Gmbzh8T5pk9lFN++nXr7FG5A/dBzpgFagcLbG8Wfsrsl6W4WqCA3lvOahIno+ELai58fskVFv5JN/zwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=meITvado; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P66m76M1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="meITvado";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P66m76M1"
Date: Tue, 4 Feb 2025 16:05:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738681519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AvxvlbOCR7KcOmsz+Y0q/B1Wx2NsMRadRDsq/OJENKE=;
	b=meITvadoPEZ/aMrLrL8hKq2DrP4VTq+ndwbhySZS8EGpKITl44WL8euOESGGRBNjte5WvS
	U/0dNWgIIjGo2FnBFOEdfktdotDKIKF35IrBGnpTRVy7MFsbA7jMyZR6TvrNd6L/oxukb4
	KVN83uvX+DJugVRlE7Tuajmvql7ENP/Y0PEhNbEd7H6HGPGIOr4OOZVIlIBICkObwbm+j6
	suNPIZ9L5GuwwkBnYCmR0Lp8WOvW9DDfGxQQkfz+J5dJcTC2OoSWcESuTYZXg1ytxspP5a
	66qmnLiTN4GUK5yy2IPPdEbx85gZwZayngFhCMo68syFr6GintZDnUKiPIrhEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738681519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AvxvlbOCR7KcOmsz+Y0q/B1Wx2NsMRadRDsq/OJENKE=;
	b=P66m76M1WHTiAp83ZSTGU1wo0r0cdkjJhb75hHbC4L9+nygx1M4nogd6WLxY+tG0nXEXMe
	ML7ay8mRW0PEVKDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.14-rc1-rt1
Message-ID: <20250204150518.VY4TiftX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.14-rc1-rt1 patch set. 

Changes since v6.13-rt5:

  - v6.14-rc1.

Known issues
    None.

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.14-rc1-rt1

The RT patch against v6.14-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.14/older/patch-6.14-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.14/older/patches-6.14-rc1-rt1.tar.xz

Sebastian
