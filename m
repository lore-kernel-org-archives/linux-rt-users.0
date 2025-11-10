Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621602E54D3;
	Mon, 10 Nov 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797314; cv=none; b=BIKn8VdMEirVNT9EpIFc1va7HjW5UHVPcRXB/CSzzVY8YF7YBjznLB3V6fWAzByFsO2R2X6NaSWQveYl+Ih5tXlBC4k77O0qqA/b3fOISlfsjtMmNrnykYzm4H9HQrI4rcosrqrP9gpOURJu4rDwmAn4yDaknVR9lvZLj79nsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797314; c=relaxed/simple;
	bh=9UHjgrOyf3WWBzQwUT8GrCRnabtjLQHtzjPkZj6KGdQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F+f23z08Jsb39oNH5qXfZU9U3/7rRubikp4df4Fwzh2WQy2kzXfq5nKh3Baml2XlBX5Yz4sFKJ/sAPx2LetftfEUG2Lm2SLhcn0uDjUnbvoaNVKkkxwqokfC4jnTnYoDJO5cMYzUd6xzlJkDndrhtb65SaHck/QUR4M+7K/Nh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=vM1INhE/; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="vM1INhE/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F405E2FDB;
	Mon, 10 Nov 2025 18:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1762796996; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=03C/oWQClpGI1VHdN58xLpVMGfyuCghA/5Zix1zVhvM=;
	b=vM1INhE/ekKX8W8eno2QSodRaQsyw3vAmyiQTLkV3xgV1Sc8/WnFSzh6eM5lS54gDeTjc4
	7zE4SjQAHubiBiP35BroOEK3dDrm6TEmrB9ZAwSLo+KPMtLp/y7zyg3mf6WkwW1r2geBo9
	8nbU3fFofehqrgoEdKt8bBl09/FbENvMgmkXZJC92Z7w60PSFrZz5/IJJDy5iSkvQCF38x
	fjbfswN4SlOVub6AIznl+F5UV0cRk5xMlBEuy6SrI0KwwhHTlYxDJjXB1Dv7ZO38iYwLDh
	YJE7fCEFXOkx96NiLtpJofFd23eAczo+2P+oL4vd0WzM4PcJ6AXNQHpSncaKJQ==
Date: Mon, 10 Nov 2025 18:49:49 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.12.57-rt14
Message-ID: <176279692049.327964.11067729645652205807@nitrogen>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 6.12.57-rt14 stable release. This is just
an update to 6.12.57 stable release, no RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt
  Head SHA1: dd1490bab92cf543071e728408cf0ff55de81e66

Or to build 6.12.57-rt14 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.57.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.57-rt14.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v6.12.49-rt13:
---

Daniel Wagner (1):
      v6.12.57-rt14
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb1..08b3e75841ad 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14
