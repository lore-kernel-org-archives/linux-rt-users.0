Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECB25A655;
	Tue,  4 Feb 2025 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738635193; cv=none; b=NMbwRQyQCb+VI3/t2jTxfcFZ/pSf78p0ICbWqm2dhDEurSMQGGU8979x7PQtD4ewXVts1iTzwCkqV9qqXOYvZsNXSZjfaHCwXSgGgmdCWn9lhzNrhcj2jz8LqsrgIAFp2VXOtvv11NseybXRfZWAlLdQoXeCdVIoJNkGM3OMC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738635193; c=relaxed/simple;
	bh=Si4bOR8QQPaDpVUBhSkWZmqPbmWYfv7MTbe/67PUgP0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B0lh3Rc3SVovaVFiN9zF2EYXUjCWzcVEY5y3MFbSkW8cDCxWZcoONeQY53mNa9gcBgK5lHnzaj/nObqYYtgCNBGtjyQJZsl/nFg4MpEaibcLE4LpotqPBA/R/OUlGMoxXe03egiOk1bkGLoQO/Sh7BN7B6BgRCM3l2BJuL0EeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=YOjweMAN; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="YOjweMAN"
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 5140mQwa4135965; Tue, 4 Feb 2025 09:48:27 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=
	1738630064;x=1739839664;bh=Si4bOR8QQPaDpVUBhSkWZmqPbmWYfv7MTbe/67PUgP0=;b=YOj
	weMAN1C7Hy43el+MI+4tlorZWJMOStJCuiKBnVLs06pIiRqTYZDyHLFaJxw0SbRPtx6mjQ1WxxwYI
	0uS4dwEkZLjAm9ObomImZG67hDJDqGbBnajtIiiDPm/8vAPVLqn/DYbSL94lcu2sKfxI5sWibyD24
	BNNYnr+V9beLLZtc/4MWCC6HGQPZmCOgKh8/2pMrFv8Dph+8Pl0IzUlEwtuSJ2a8eVG58F0kJ82Yt
	42B+zZFjAb7zR/RmsgMMsGtXWj4jcf0asUq8YzUlXmm97oH3hxYCZDRSQI2dSsNp19hzxXZYybZOK
	ISi4Qlk5whf5B5zI9pL3xwOXea7APNA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5140lgJN4066260; Tue, 4 Feb 2025 09:47:43 +0900
X-Iguazu-Qid: 2rWh5b6vESC8CgKcan
X-Iguazu-QSIG: v=2; s=0; t=1738630062; q=2rWh5b6vESC8CgKcan; m=hDviWYt8PzLl5GDgSBVLdPWMXaTHyLbrfYk/J+DCCfU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 5140leUm491300
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:47:40 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 4.9 v1 0/2] Fix repeated WARNING in unpin_current_cpu()
Date: Tue,  4 Feb 2025 09:46:02 +0900
X-TSB-HOP2: ON
Message-Id: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

This is a patch series for v4.4-rt and v4.9-rt to resolve problem that
WARNING in unpin_current_cpu() happens repeatedly while kernel is booting.
Please see commit message of the second patch (2/2) for more details about
the problem and how it's resolved. The first patch (1/2) is a preparation
for the fix (2/2), considering compatibility issue in future updates.

As the both v4.4-rt and v4.9-rt have been EOL already, it's not expected
that this series is applied to the branches anymore.
On the other hand, the Civil Infrastructure Platform Project (CIP)
has been maintaining its 4.4 SLTS RT kernel[1][2] based on v4.4-rt,
and needs to fix the problem above by this series.

It is much appreciated if RT experts could take a look at the series
and give feedbacks about its way to resolve the problem, which is
based on the same approach as changes happend around v4.14-rt.

[1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#kernel_maintainership
[2] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt

Kazuhiro Hayashi (2):
  init: Introduce system_scheduling flag for allocate_slab()
  mm: slub: allocate_slab() enables IRQ right after scheduler starts

 include/linux/kernel.h |  1 +
 init/main.c            | 12 ++++++++++++
 mm/slub.c              |  3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.30.2


