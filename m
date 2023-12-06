Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjQGRV3f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F2FDC
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701896111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VdsUqga0xq19R+aNlrYg9gFVfnsH/ocOqno+VOJyw30=;
	b=WjQGRV3fymcudHmmn9Rm8jxubQwtl+brhG+JvHgL8Bt+QJRxObuhbzYgiijaPHBD33bLcx
	VYYjRtuDeIySlwPhSpWs/McCcJacHkvr1tNNglm2d8aLaca74rGP929uFwO9F82CGIIWYK
	K4jNBvtRdjqlwg0tKCQH/qErnD8qi+0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Kq0icVOxOTO6RyqFrGhTNA-1; Wed, 06 Dec 2023 15:55:09 -0500
X-MC-Unique: Kq0icVOxOTO6RyqFrGhTNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9407A85A58F
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Dec 2023 20:55:09 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.17.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6257B2026D66;
	Wed,  6 Dec 2023 20:55:09 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH 0/4] rt-tests: cyclicdeadline: Add histogram support
Date: Wed,  6 Dec 2023 14:55:04 -0600
Message-ID: <20231206205508.17148-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Add histogram support to cyclicdeadline, with the goal of supporting
cyclicdeadline in rteval.  New output-compatible (except for the change
in patch 2/4) histogram code is used, to ease sharing.  The new code is
intended to also be usable by other measurers such as oslat.

Crystal Wood (4):
  rt-tests: Fix warnings
  rt-tests: cyclictest: Remove histogram totals
  rt-tests: cyclictest: Replace histogram code with library
  rt-tests: cyclicdeadline: Add histogram support

 Makefile                            |   5 +-
 src/cyclictest/cyclictest.c         |  94 ++++-----------
 src/hackbench/hackbench.c           |   2 +-
 src/include/histogram.h             |  42 +++++++
 src/lib/histogram.c                 | 174 ++++++++++++++++++++++++++++
 src/sched_deadline/cyclicdeadline.c | 119 ++++++++++++++++---
 src/sched_deadline/deadline_test.c  |  10 +-
 src/sigwaittest/sigwaittest.c       |   6 +-
 8 files changed, 357 insertions(+), 95 deletions(-)
 create mode 100644 src/include/histogram.h
 create mode 100644 src/lib/histogram.c

-- 
2.43.0

