Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6914FC0A;
	Fri,  7 Jun 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768880; cv=none; b=IR0wUARhX/S5d/ttvBQe1o1Pp4fkZubbyGEzSzkTSrE3Q9cjwZ9xKaL1cDOa0tzwEhNvQhYK6UmcyAaesISDoG4G4N0lWOfC3jFiJQFNTp4XQrZWK7nRGbeOjOBuC1XQnNTbF2bHfr3ZHdYSDWGsOvRZxF6GZfyFUU3lNaNIB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768880; c=relaxed/simple;
	bh=nYmRZVpz2mQNxli7JraFOtVsUbnToFRdBavC73TzA1Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dw1fSOPpqFSgPG6hnnrzVMlQc1CE0uvgOscgKtd2iNAOltcPMhgtnv7MKoyuDZhsL7wixh46P2l3eXDhHb5KNaKwwLXr/hPtQEyyJ9JWUSwScfAQnOUujN3BwQDUiwhVLG9d5uxmdEzmejKRKNvAag8oc9mFEjzfLu54k90LJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=lrS8OQoe; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="lrS8OQoe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 310A9DB4A5;
	Fri,  7 Jun 2024 16:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1717768870; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=BK1qLsXdELqqMxnJyp/mZ3oX9UWbnQ09OculbYCqhoo=;
	b=lrS8OQoefl4tt7TNQl6CrsVahJIMIX0lMW3TpgjTED1lSoDBYrkVYuqOis82+XvILONa2/
	aRUNTY6SyaQgXuDeYKPyuCsDYmVLGOZPw4EA+XN4V15oRZCrNv1n4t0iTEtPswp+G1B/QC
	G/fB/qE1jGzO2nhDEfE26vBlcn47eFKfb3sO/mDZshS0GevjycVOBgZOpX4tD3B9fO4RwO
	0RoH38YuTk46RwAOuN/Eedb+veBOHWgNykGCOJRjOYGiH8RcVvJT/ToRuvNn/kBMMYlWOe
	3qYEwZhf24itKwD/eHNBSJvAXs3q+2g6fcrcz+fZ0tsFMo6nNjXAYKi7uR6Y3Q==
Date: Fri, 7 Jun 2024 16:01:05 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.315-rt135
Message-ID: <171776879104.8091.1320953589515538722@beryllium.lan>
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

I'm pleased to announce the 4.19.315-rt135 stable release.

This is just an update to the v4.19.315 stable release, not RT specifc changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 66fe9135e37bd5851c55180e2fa301b2968b5588

Or to build 4.19.315-rt135 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.315.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.315-rt135.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.312-rt134:
---

Daniel Wagner (1):
      Linux 4.19.315-rt135
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 6067da4c8c99..e3026053f01e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt134
+-rt135
