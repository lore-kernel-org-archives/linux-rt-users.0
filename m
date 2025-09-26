Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8B15278E;
	Fri, 26 Sep 2025 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907067; cv=none; b=QIGdqrGb5aQcspq1LKPGO442SiEA7PC7IKQCt8Aiy7iixIx1jDTw4cXxljgxFM/VeguJ8ZF7UEB19D15vTfUy1VWzLnOxnyotrt4uadCMAkHHPq7C2Mf5BCzvZhjGXF0sICZnTxSLoJu86m4zdx5pTHQnvsT3YBpfucNyWGc1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907067; c=relaxed/simple;
	bh=CDLfsApOM3JncEadjqaKh4AhZMTTTysfk1bQzc9vBeE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KjfN54mALAqXCvy3M4CkuXrJnhnYqGswRRjpFjBNFtacQrAMHdF9qcwzuLkT6nLNcrp0BdueLwpX1uSXJ9jrXwhuxeuCQHM8I4C819WbbXHLs69Sre/V1dZPSRz6sna8Tj55cbKs6uQrUvfEehkOFZUH6oaAUWzreRkWTaJQ/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=T5VlPnt3; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="T5VlPnt3"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFFB4E6C5D;
	Fri, 26 Sep 2025 19:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1758906602; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=+oRR/6uTeGiq95EV+G75ZWTTdywQDO6I91yuYVpGfYs=;
	b=T5VlPnt3iIW41bCztd1pe2AAxZSOdRRjWFjLspAEveSceHqoYHGmfs/MUEA7r0SRV6jIkd
	Tm3TO7ixRxc6VWEq6dCatZB0/TiKbGQ1dzUZb8MChE9+iUJXdKLxwLEqeob8U9cQ0EE19e
	Lb+YYL+1jZdpUuB8Snr73qsXg+L7QJhIjr3VoslAud/zMSjr7c5VLxv4CbTtXryD0zlRXH
	ytKNwDe9aHNUgbRJD9tbrIg40lvJWbnc0R/8V8gJ0EyYCQgIvUIiy9nSVUJUdf+3/Ay9mV
	Ick+N+c3Bzs8gdZElF/TpCCJDkACcAyrJinjncouIvBq7LXNZfrzYfyA6wbt8w==
Date: Fri, 26 Sep 2025 19:09:57 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.12.49-rt13
Message-ID: <175890647477.247135.15139497129183245010@nitrogen>
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

I'm pleased to announce the 6.12.49-rt13 stable release. This is
just updating to the last upstream release. No RT specifc changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt
  Head SHA1: f9510ff38b57dc1c06d97930db4c9773a529bf70

Or to build 6.12.49-rt13 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.49.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.49-rt13.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v6.12.43-rt12:
---

Daniel Wagner (1):
      v6.12.49-rt13
---
localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927..9f7d0bdbffb1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
