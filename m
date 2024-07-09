Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE5143752;
	Tue,  9 Jul 2024 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513566; cv=none; b=qWMgY+uQ8KpEKADjyzVHSM3kxaOScnMG3WHDiG60VqM3qZNtpwj3ZIwgnVmKH3n6kVSzDsLf38XybMywy3U7z60PaTBLp+z9s5tSjTmfs9b2Vnm5nUw4EXauAbjdanTGdbpomBQtJVHIxu5X4w6B53Rbk5f0A24t5tgRlY5x5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513566; c=relaxed/simple;
	bh=pr8wIDCD45d8QCeilQNKwD30DShDaMx2RWVNvlk+yUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSXByL3Q36jxBF29LnHZOXbk/IJMJB4PhEZjTUzDn0DhC/2+Id08fJFBNKP/g3fKswX995iy/0UkU1YvVYtK9KE3sOIlaU1QazwHnj8ASkbo/pOuVSBRXJ0TBDRcuRGsD88CgIDN0iU8QLeMRT5XIe2E7mKA6sxKox3oVtu42+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=X3V5/5ke; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="X3V5/5ke"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD213DACBD;
	Tue,  9 Jul 2024 10:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1720513561; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WTbFZ3lBM56CMIGthDXFvscF17IJD9BkmdHCFHHDPU0=;
	b=X3V5/5keksxKnRdiFmrloVTE0jsZOA96OsJyrjOgrmP0lRnDQUovBj+hQUBo9OiGSFlc3W
	b05u0/zKAwaEjs0+k5wGsV4AwO/yYgXNMVLiv16nhWS0Ce2DUFoIyzns3aZ1x+yO+Irkrv
	sXFzO2nebvttmT7J35d/qam1kVuSYefBs0CHem9tJzOLR5VPhop+tWQKbJkN9CognP4va7
	4SKfOfjplGLibRD5kSzxPecEaGESWGEUloo3t1yKY2wiIjZtcGwUruCWGlNh9pN0TrWf35
	hC3FZFlYL1MBl+TA3e/jxXT+HVrJHyjmXe+LqM1cvsc0rhyQmEyHj4hOkSt5VQ==
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
Subject: [PATCH RT 0/1] Linux v4.19.317-rt137-rc1
Date: Tue,  9 Jul 2024 10:25:57 +0200
Message-ID: <20240709082558.11012-1-wagi@monom.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.317-rt137-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v4.19-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2024-07-16.

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.316-rt136:


Daniel Wagner (1):
  Linux 4.19.317-rt137

 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2

