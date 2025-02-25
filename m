Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829131624CD
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Feb 2025 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521349; cv=none; b=dv0Ea185tYodbgF/iy9lqiBdt+B7yiAFhxj3VvQYZ/O3/WY3BIuR5SzBlDbqcOgnkSBqhUKJXPUvUKDTPZGNAiVp6rzl1UTZ4Ag+K53iByj89QAMwhg9iBQs18cQ2oIBpqpcqkeu7oD79RaLzGUHETOt4RMaBTleqw5m9mGIWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521349; c=relaxed/simple;
	bh=2uyo8JHlC6MNj2dVaYk3E9nZEandYEAynhbhCjGRHuQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TkC6NeWtE8lWOWyEB2xmMFvMF+dnIR33BwkqSrkSqF/UBOyKQU9c56YttyJWqlzbc2sucjan7gAySMLECbby61Xlbsg37jUrc8VI9RsIn0jjCjFaVAFgYZHDPgsZ2Vbmtu/R54TRmtFYfnmH4yEIUQrBDH4aThwzsPw2edxDQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftC/yOAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftC/yOAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740521346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VMUwmd5c4elVuE5B7h/fsPug+slvKZ0QGpHijJBbwjM=;
	b=ftC/yOAFc505JECamQ4lBBB+eMjzUqE1+qKNnLQZRZ9JBHk+OzohpWMxsIcnyauIeQiik9
	t3eVILHHUVge9zShz9ViNYgrzseL9r4zqK/IIjEQTk1EU+f7DLrHooIAtARVrcfonvsweR
	7psSkeE7+YO/6BwY+YLmZhAbdssC8BM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-QlFK4oDJOdWGqhGJYfJAug-1; Tue,
 25 Feb 2025 17:09:04 -0500
X-MC-Unique: QlFK4oDJOdWGqhGJYfJAug-1
X-Mimecast-MFC-AGG-ID: QlFK4oDJOdWGqhGJYfJAug_1740521342
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D5D91800873;
	Tue, 25 Feb 2025 22:09:01 +0000 (UTC)
Received: from localhost (unknown [10.22.80.185])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6FAC19560AE;
	Tue, 25 Feb 2025 22:08:58 +0000 (UTC)
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Wang Yong <wang.yong12@zte.com.cn>,
	Xuexin Jiang <jiang.xuexin@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Xiaokai Ran <ran.xiaokai@zte.com.cn>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/4] Linux v5.10.234-rt127-rc1
Date: Tue, 25 Feb 2025 19:08:53 -0300
Message-ID: <20250225220857.216591-1-lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Dear RT Folks,

This is the RT stable review cycle of patch 5.10.234-rt127-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v5.10-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2025-03-04.

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.234-rt126:


Ahmed S. Darwish (1):
  u64_stats: Introduce u64_stats_set()

Luis Claudio R. Goncalves (2):
  rt: fix build issue in at_hdmac
  Linux 5.10.234-rt127-rc1

Sebastian Andrzej Siewior (1):
  netfilter: nft_counter: Use u64_stats_t for statistic.

 drivers/dma/at_hdmac.c         | 12 ++++--
 include/linux/u64_stats_sync.h | 10 +++++
 localversion-rt                |  2 +-
 net/netfilter/nft_counter.c    | 78 +++++++++++++++++-----------------
 4 files changed, 59 insertions(+), 43 deletions(-)

-- 
2.48.1

