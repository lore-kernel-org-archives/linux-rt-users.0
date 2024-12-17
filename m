Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E71F9436;
	Tue, 17 Dec 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464422; cv=none; b=i6ovHTaW7fZ0bFmiaVwQUvFREM54bI14EcBw0Y6iUfWARLj3QJLzzUTXyT5oe2fofbEoW33hF1aCGdhflK7yuiwa6G/hJEbtYDVMi9RqxPtISvO3eDNpm4cD9Grwzzu8hoQT0NUlw0Ov6yNBtntHP+4x6FQDATKvy047hOvLPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464422; c=relaxed/simple;
	bh=AgDdEJVeQhBJeFgwBSd6qqxfPMc80/SqrpV/Sr6YzmQ=;
	h=From:Subject:Date:Message-ID:To; b=tfzuPnlkKXrhcR3mZl5MjVN7CWnQ/u2lkhMF2+QVUPd00+4Lg1hwR2N3bFVTNVekhHUCLA0JpUkcOWo6ifWi4V51pSyZFvW4qjm+QUh8orExIpkKK5wMz4XpemMSeO2q2J4P+P/J3lw6wS3dZ/C5aMax44QRctcHYZ0fqhrl/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF62FC4CED7;
	Tue, 17 Dec 2024 19:40:21 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.120-rt46
Date: Tue, 17 Dec 2024 19:37:47 -0000
Message-ID: <173446426761.810839.10241405280484476684@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.120-rt46 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 061eae4897c2fee62fed3f946864107faf3292b7

Or to build 6.1.120-rt46 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.120.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.120-rt46.patch.xz


Enjoy!
Clark

Changes from v6.1.119-rt45:
---

Clark Williams (1):
      Linux 6.1.120-rt46
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 38c40b21a885..272158183778 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt45
+-rt46
