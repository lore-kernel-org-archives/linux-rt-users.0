Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B62F260C;
	Tue, 22 Sep 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088117; cv=none; b=Yi+l26oeNe0SSnDoEB5tqFbys7PInT5NHv33PdRc2gJbojqrjjh8yn6zANNec6R3i6/AroHhrURtEb+hXV3UHMwVtWBydcMNHY4CjwHDgBIpNe/cSlryz9WjJEFjbZLHCT+/wVil4alsyDk2VsAHcrp+QMUSJ+cTRitIbzN9MGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088117; c=relaxed/simple;
	bh=Mr0BcbuzVjx02muvY50bn5Nj1YUsnUM+s4POErGD674=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cntgURkDiuQLc7/fj80icYAO8IQZEhdaiUeJNpD/9/DwgR5ql91ec8/kWE1uwwr22PaoXpMzFqIfU0ZJZ6jxsd/JSyK47A5nWWbkJ13YAR0Ba3n18ZKiM4WZ6rpTX9fQN+SPU/AUK7eNZYcng5HTnRMbOhoeThMtDBg/3WkUeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3lqNQmdu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1eQalyf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3lqNQmdu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1eQalyf"
Date: Tue, 22 Sep 2026 16:41:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790088113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lNI0rcEaCDgoUY5N6IqDb074LzbMBFwwALJ1DKhdTKQ=;
	b=3lqNQmdu5mmU+b1DyJIEQg438MDKuLMsJYTJ26jGQNeWFtfObcKGu30yo2EeqkwuIgF9jo
	5e3uNuci4KtLt1u8rpUXIrU/4LbgN3yQd2cFAyLvuTAm40rer1lTstZf6O1oyhgBRmtrRr
	ZAHdoC3Se4BNmAwwjx5GKT+X6yeyvZV5RdY7jYy+V8F7gDw+FQXNNuPhcLWquHJPtiZJ7z
	NXCH5PHgqm82Hkbfjc5mPv0970j9yYwk3FUREl+XTaso3hcYHgNRdlgCYdJIK3kbKA0Aao
	g9Jk5EBN0xSusX6/NfkJbKfmidskK3Bg7BLuW8t8m35lWcKl9Lj6HM/r9EjJDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790088113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lNI0rcEaCDgoUY5N6IqDb074LzbMBFwwALJ1DKhdTKQ=;
	b=M1eQalyfFVbOzCG9XFQodiX5FJl5Nkb6L9iCBft0VUGS8HT19a2OkIiUJYnXp+Sel10YTv
	hN76pdiEQwoTkLAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [ANNOUNCE] v7.3-rc4-rt1
Message-ID: <20260922144152.x2J3_tNz@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v7.3-rc4-rt1 patch set. 

Changes since v7.2-rt5:

  - Rebase to v7.3-rc4

The printk related changes are all gone. What is left in the queue is
PowerPC, i915 and a sysfs file:
- PowerPC
  Some progress has been made. What is left is a pseries related MMU
  change, a patch dropping KVM_MPIC (which is e500 only) and a stack
  protector related workaround.
  The stack protector workaround might work with a different fix since
  only arch/powerpc is using boot_init_stack_canary().

- i915
  The patches in the queue are different compared to what is worked on.
  Both sides seem to be stuck. The XE driver seemed to be an alternative
  on platforms which are supported. Now that I test it has the same
  vblank issues as the i915.

- sysfs file, /sys/kernel/realtime
  This file has been around since forever. It was used to "easily"
  detect if the PREEMPT_RT patch has been applied and the required
  Kconfig symbol has been enabled.
  There has been a discussion if this file should be upstreamed, if it
  should remain at the same location or if it should become a folder
  with features.
  Any change here implies that users need to update their scripts. Even
  if the file is present in !PREEMPT_RT kernels and returns 0 (as the
  file was created with the patch queue applied but CONFIG_PREEMPT_RT nt
  selected).
  Given that this never part of an upstream kernel, it is probably best to
  no include it. The uname(2) interface provides the same information.

I am considering not updating the queue anymore given how much has been
accomplished.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v7.3-rc4-rt1

The RT patch against v7.3-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.3/older/patch-7.3-rc4-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/7.3/older/patches-7.3-rc4-rt1.tar.xz

Sebastian
