Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679716130B;
	Tue,  7 May 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095021; cv=none; b=HpCTUPAm6F6oY1vGgw0fK/pp2zHNGnRVWvAiITPFNGElm7SpIzPz41l0QBoj86u/BA3irGKKFnmIJ/9xvmgSv3CPMJmLKKt7ZqkYY4fZoV8x8/2RtvHXYvtW4P4dVzHNPFxG4hoB2WjYIpR+Dns9EQQHE+eEUIPD1tRgweCylJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095021; c=relaxed/simple;
	bh=axc7D83xZY+M9GOKDBmlE8Uiep7sZqUy57pi6Y9OdkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hs/4b8DgW6P6JVDfr2L7XyGmNpqElacjifdvzAXiGBwQDWZhVc84PoM6V76H0WZHIIodOQx6hspW37nbjfspj7vKHDc6TXLjhOLpLR+S4Ua4OdbdpsTMTnYFieTgRg80j6BwhpKssJoK6bVr1BRprwMGmBESsrhkxMD66N2i15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=aaxPIIRQ; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="aaxPIIRQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8ABFFDB3DF;
	Tue,  7 May 2024 17:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1715095015; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=/K1BszgO4HhkgM/dGOUg1JDl9BqIsMT795T5xI0/ZkM=;
	b=aaxPIIRQrHAOC0VvTO7yBcFF8tYODtzuCFEsReE0Gt/YgHnr4jXgaJRElN3KBzgFdQoCya
	8uXE34Tc/7bSH5Jqt6UaNrgxJVxvr9e3Y5w8BZfCS1UQZkNKoioNP5Wy4Rxd9KbxwyNtTT
	G6u0uEFpV/in+GOW9FKYrWwHqJaZYucojbCxO5XYzZ2CJL1XuPpOHeNrd1OpAp/EBLrAqm
	y0IJ32US18HGrDvB8VojTvhC1LjEGpLe4z49WPDQfGH9Zgf0VrBs5ZJBqJ/WsFDB3OFx7x
	PkjICB7JY9aI+tu/ipUEUPZ1gS4Y4f2hzCsa27xU8zry2vNrSQ52QM8NtiqnPA==
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
Subject: [PATCH RT 0/1] Linux v4.19.312-rt134-rc3
Date: Tue,  7 May 2024 17:16:47 +0200
Message-ID: <20240507151648.17883-1-wagi@monom.org>
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

This is the RT stable review cycle of patch 4.19.312-rt134-rc3.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-05-14.

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

