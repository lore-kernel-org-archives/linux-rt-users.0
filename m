Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110D01339A2;
	Mon,  6 May 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992381; cv=none; b=GEj1KjYCcx08/cA2OJj6bJq3fCnxJQnSV3ttghjryj+qs1FywXBG2YE4GT+L2WBQ4G0Nb+KT7WeFPlz2QI5wgmEeq1EhSt0aRnBVAdTSOjxE4n47DvBaL+6w8hhhlcYDWpf6jhiSbC+76UFfiE/f5e8aFRc8l8aL9W06BVgLEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992381; c=relaxed/simple;
	bh=mz0kzg8O3jZsXVFnQtikJvb2VJBdAi8sDLH3GdT6nfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmdRJBg6G/d+ryERHFAxxdtxU1UdezgqmGPUoyeDEKE1jtzvO2PxjfTgaP3eZHqPHc2J25L+Mvg2NAnoDPSVFAhuj8y0kMjlP3vZpwDHUXpvfIlz111Zabindg/2SrPGeYVjw+VLB5/9l1G/AnTuhqKrhirOGnejEOLBNSux548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=vboeW9Yt; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="vboeW9Yt"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8C11DB383;
	Mon,  6 May 2024 12:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1714992370; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WLmZE8ctAqg4BLW43nqO/J8E5dbdvfrS+1ubOiE/c7g=;
	b=vboeW9Yt32IssbmdbAA61Tn192GVCp245G9T+89DUZUd9gBqthnPYFY+qrdCcIfABqSaRj
	WqpveiR2tj9rwzTgCTk3sVF049mnIUbwstxk9OclywQ4l0o7OYIkW34FUvBV/KqQDHsgwb
	PwgLuJQaqt4FBJXqG/CoRUtUC5/qAH1Sls8Xt30UN76+DYbxxiegqjFNGDzPLiegQCJRXD
	UYCtAKqrdaOzQiaP7ivIcm4rW//GwwK9rRsGEkN46F9R43WAt9cj/KmNY4jAOfuZm/aGlF
	rAmFUdQM4igP/aVIqUooNrEdQ3ovMPO/t1W5Alu9oO1H2YRWzoDPg7lhtx72jQ==
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
Subject: [PATCH RT 0/1] Linux v4.19.312-rt134-rc2
Date: Mon,  6 May 2024 12:46:01 +0200
Message-ID: <20240506104602.16972-1-wagi@monom.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.312-rt134-rc2.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-05-13.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.307-rt133:


Daniel Wagner (1):
  Linux 4.19.312-rt134

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.44.0

