Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD748820
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 03:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MW7r7P4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702957072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=optyMKq0STIIgxn39O81gLuoOe5on4u02UbhIsfcaJs=;
	b=MW7r7P4BdCyuk0P0MI9M4Le93rEig3zwGUcl2DpXeIhFFOib5iFt/7oyHQdA9BCUcTGTzB
	kNfmVB4hdmR+pZ9032X0Gq5+VexfOVvrMv125r0RVawtahRtfW5Qk5Ss2n1scFxv9zXOzP
	L95rw37DYjL5Kyj3TFkFJ7XjglZQuMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-kQ4lAPTzPK6De6mchcUhYA-1; Mon, 18 Dec 2023 22:37:51 -0500
X-MC-Unique: kQ4lAPTzPK6De6mchcUhYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0742101A52A
	for <linux-rt-users@vger.kernel.org>; Tue, 19 Dec 2023 03:37:50 +0000 (UTC)
Received: from p1g2.hsd1.mn.comcast.net (unknown [10.2.16.229])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 908032166B31;
	Tue, 19 Dec 2023 03:37:50 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH v2 0/2] rt-tests: cyclicdeadline: Add histogram support
Date: Mon, 18 Dec 2023 21:37:48 -0600
Message-ID: <20231219033750.334327-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Add histogram support to cyclicdeadline, with the goal of supporting
cyclicdeadline in rteval.  New output-compatible histogram code is used,
to ease sharing.  The new code is intended to also be usable by other
measurers such as oslat.

Crystal Wood (2):
  rt-tests: cyclictest: Replace histogram code with library
  rt-tests: cyclicdeadline: Add histogram support

 Makefile                            |   3 +-
 src/cyclictest/cyclictest.c         |  82 ++++---------
 src/include/histogram.h             |  42 +++++++
 src/lib/histogram.c                 | 172 ++++++++++++++++++++++++++++
 src/sched_deadline/cyclicdeadline.c | 114 ++++++++++++++++--
 5 files changed, 343 insertions(+), 70 deletions(-)
 create mode 100644 src/include/histogram.h
 create mode 100644 src/lib/histogram.c

-- 
2.43.0

