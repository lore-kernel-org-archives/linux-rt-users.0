Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C4219A68;
	Thu,  5 Dec 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407031; cv=none; b=SzjngmdNeQwdpeYnIk1X3NF8tyrUmMZhW8Yc9+s0Q3LRuuzjyv7tffm9YXiq8qt8yqEwWSxaNe1BXBfvJrAh0P0PxiAQeDa0/hkB37d+haIvIJnY/bNjzX7RdvNOL2abdYFRuuDdda50G8u5tz8ZuASiRXpKAs2hvkXCStWF2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407031; c=relaxed/simple;
	bh=je2zj7fD0FddiGbiY0XDMI7nIcZj/3JIJPNgFgLplK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DfYIqNdiPl8p4VAZ0DNi1zNEBjaC+1/G3LJbgbl8YL5FKfuYd2l96HaJxEF5Vt7PeGIks6GNSZr8wZOx+ydzVKWILbQK4vMrWOMtuHkpPUpMoekPFl+ohVD/1q7R2RCI6aL4TOGe3pIAMvBNxPJ1zRjWLNQL6nNmb8GVebt78BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=jbdHjFaU; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="jbdHjFaU"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FEABDAC70;
	Thu,  5 Dec 2024 14:57:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1733407025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UtwhQ7C5wIeYPqzyZt2Yd8pSy/Elm6bNLL9V5/J8XZE=;
	b=jbdHjFaUlxfsL26C+dla6KyV8k7UjqTgRVoj/TvhdfoeHCtxQdiqUmObIUma7YYxmPqR4Q
	40/T8kELCF3zw9Yycq/V7T91V2L6Ha7MVpc3XXzOfGl7/R6As3x3dQHIHX7Ro3tN6bzpVp
	hjvql7TU4J84AYaERo4EzSYDTqJnNZly9L+pM962hw4mu48WXwC22aFo8mqe8EkRBr440c
	5FahfA6zAqZWR0LMemdIDw8uCGj2imic1K3I4ZoK+ljIOJCMjDjMBlRKyD8rKzA0bDeEcg
	Obi+LJufd0e/dNT/cYKs40KqXPzxih9R6aodufL99xc+98jFzsU+uVXFZnKBbw==
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
	 <linux-rt-users@vger.kernel.org>,
	 <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/1] Linux v4.19.325-rt140-rc1
Date: Thu,  5 Dec 2024 14:57:02 +0100
Message-ID: <20241205135703.20341-1-wagi@monom.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.325-rt140-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-12-12.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.324-rt139:


Daniel Wagner (1):
  Linux 4.19.325-rt140

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.1

