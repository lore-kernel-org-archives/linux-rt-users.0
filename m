Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2547023A99E;
	Fri, 24 Oct 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317829; cv=none; b=XW/JEhbdhJB58ygVTv7z4VG5XUH+KJGxa8UnXng8PW/Dp8IB+HCgCSk5cgyIDJVdeJYOcndq0q5lYbeSkxlPIRupEI/wNO+KEX5D6UCXrX41Q04uOOgNdrtmRrIaGWs/MsIPk6H9GgB1Q6JgcGJYXrB5qxFWFM0Wmd6tfZJ05Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317829; c=relaxed/simple;
	bh=lHnav4cPHx6JkeWDDcOGkx10TKSwFlxv1j2pzTeY4cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FzmPRAHOJIDTyYGsC6NE7aDGrIZ+b54IAxjAV7T3VuKYVSjbxZLCBT4dGUSEVN3kV9x+gYRDnB3HZNfxCDDTjwgqkPKkueGrL5xTNBy6ik32QFsCXPOO2TrEFsrT7RI7ue2kBSTW97M+L0FEW/0YMp+eHcCrixeDBtcsToKVTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KB2aflRz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=84clBrsb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KB2aflRz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="84clBrsb"
Date: Fri, 24 Oct 2025 16:57:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761317826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JtWVRobZuiuWi4HNeldvVaIkj3QLo97sXbbx84d065w=;
	b=KB2aflRzZPekLdjDBxtWmBXyT5bVjccJ8XNdlbxNaCoMTTrn0Jx2POgcqMbA+IvAwRzHlZ
	H1EwLZ2ROL26/4uH65JqYYtzReBoKAEVcTuiXSbflkUjqFdwRDFJIklGcfCtysFeGDVF2K
	HHWK20VXJ08vGEF7XNuau6gDkcxcoYNBkDbLTud/CF4erVTwhE97C1cIA8rbr0Wlpn2txb
	UPQJI0Lv7+ZTuMirTqdxkP/n6UiZ1K2DY1rZhLW3Y2JoBKQgpVNVp+XRQ6hjSf4vNqU/u5
	4/MjMoaTPiXovlcIJ47Gsz2ZRT5XTERfKPUOnjr6iaNLUPsqxXhHcHMQ2n6kQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761317826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JtWVRobZuiuWi4HNeldvVaIkj3QLo97sXbbx84d065w=;
	b=84clBrsbMDYSGZdJ1Hu5aJrZ11+GZXRY/dUWn+onF3LEC6aXR79KnkRWx22sRvLhsg2zR3
	SS4uTJKGKvSHXKCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.18-rc2-rt1
Message-ID: <20251024145705.mGSpfWqu@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.18-rc2-rt1 patch set. 

Changes since v6.17.5-rt7:

  - Update to v6.18-rc2

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.18-rc2-rt1

The RT patch against v6.18-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patch-6.18-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patches-6.18-rc2-rt1.tar.xz

Sebastian
