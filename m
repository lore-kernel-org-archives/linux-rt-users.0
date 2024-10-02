Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96A1D1F6D;
	Wed,  2 Oct 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892819; cv=none; b=SNj/n0trOA4tzqkeKJufH6yDWs38/kxSrB1Km7cys/7M11UfOqqTAEij5HVH9TvZ6c4G0oCD8eh82k01FwhdNrmnn+QKxce2GRdwEwmlz8nYsP7j1iWdbkrzan/qQE7Lx23wFFTndPj3C2gGCSAFXHtp2PA8s4RhY8/pLtJmcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892819; c=relaxed/simple;
	bh=9WXAlYDtGOD91RcJVkNwOMg/7yNh7h8n3wWt5jnpalM=;
	h=From:Subject:Date:Message-ID:To; b=U9vflI4cQ6FaLhudj4aqvcboQr17NkbuQ0uChwg//Q8vModdlCFfoJVDu7DPbNPgFS/6cZ3pDrC4mTV/9EUuro11BYjnANzSpNvg/9PqxQeZNPmNo2peKNefZrSGEie09R3KsfiIT05b37OZyHTcQ9Lygm+rG3ZgFSrHaU8Qlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10C4C4CEC2;
	Wed,  2 Oct 2024 18:13:38 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.167-rt79
Date: Wed, 02 Oct 2024 18:04:00 -0000
Message-ID: <172789224014.2619596.4504014412810368464@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.167-rt79 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 48b8624ddf7fdda5869adfeb11d11559511c171f

Or to build 5.15.167-rt79 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.167.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.167-rt79.patch.xz


Enjoy!
Joseph Salisbury

Changes from v5.15.163-rt78:
---

Joseph Salisbury (1):
      Linux 5.15.167-rt79
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 30758e0b2242..cf94a551bf32 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt78
+-rt79
