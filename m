Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BA2BDC2C
	for <linux-rt-users@vger.kernel.org>; Thu,  2 Oct 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438526; cv=none; b=gU8VRr60OEFf4pBw4WlQ9MwYMQdrtieB71waxNEFACXW0bXm7oIdU7E2Rwzy71CfGu0vdVcrKScCDl4VjuiVCTuFPQm1FiitwZ8PuHDktdxU2qtS/+JqFcDCD/XnPvdW7ofqcN+/DOZuSVgY2abcwYnrUkAJFh/fi8f9ngv91b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438526; c=relaxed/simple;
	bh=jjlthEGNdsmf0h3ytEMdA8rLALPcKSQJGSBTsPWVwCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktOLNtoKKcjoI7Q+bDs9ef9BM5Nx1FjSTqFEQA1yia5khJFBGbF7aJUv23/38MWKykI5sw0IMVCnLFD/70ZyHd+iVMA9IKwg613dA84gfQfUpXeeGsTz0NTstBeGU7mZtv7tQ6jqliYTlZWb8fbF8fLVc8WgusAXw89Q06nBPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQPe8Esb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQPe8Esb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759438522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+wDlvrMZ3mXyVud+/rKv1Dvz4JAi890EdsK2V55VkDc=;
	b=BQPe8EsbQMwuiQiRdrmUsRmU1d8cYv1x8cqnyR6+5rW25n3IgKiFGNS05j5KizTg7tz29L
	wBG9LsGgWfp7ASmB9Uvq+a4W3j3WXHTj/rIclD/SoXIGDd2DEu2jIK8DhZyzOVzc/9Tju4
	9YsrgdXaf3vegJldApH71Yt6VAvqPc8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-7rqrqL7kODW7Y0PAGRRzIA-1; Thu,
 02 Oct 2025 16:55:20 -0400
X-MC-Unique: 7rqrqL7kODW7Y0PAGRRzIA-1
X-Mimecast-MFC-AGG-ID: 7rqrqL7kODW7Y0PAGRRzIA_1759438520
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF0D11800451;
	Thu,  2 Oct 2025 20:55:19 +0000 (UTC)
Received: from localhost (unknown [10.22.65.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A4D519560B1;
	Thu,  2 Oct 2025 20:55:19 +0000 (UTC)
From: Derek Barbosa <debarbos@redhat.com>
To: clrkwllms@kernel.org
Cc: linux-rt-users@vger.kernel.org,
	wander@redhat.com,
	debarbos@redhat.com
Subject: [PATCH 0/3] stalld: Improve legacy kernel support and unify sched_debug parsing
Date: Thu,  2 Oct 2025 16:55:12 -0400
Message-ID: <20251002205515.1299816-1-debarbos@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch series enhances stalld's compatibility with legacy 3.X kernels
and improves the robustness of the sched_debug backend parsing logic.

The main improvements include:

1. Consolidates the OLD and NEW task format parsing logic into a single, more
maintainable implementation. The new parser uses field offset detection to
handle different kernel versions' varying sched_debug output formats,
eliminating code duplication and improving reliability across kernel versions.

2. Legacy kernel build support: Adds automatic detection of 3.X kernels in the
Makefile and configures appropriate build flags. This includes disabling eBPF
support (unavailable on legacy kernels), removing Intel CET protection flags,
and defaulting to the sched_debug backend instead of the queue_track backend.

3. Shell compatibility fix: Corrects a bash syntax issue in the run-local script
that prevented execution on older bash versions (4.2.X) commonly found on legacy
systems.

Clark Williams (1):
  sched_debug: Unify parsing methods for task_info

Derek Barbosa (2):
  Makefile: Add support for legacy kernels
  scripts: fix run-local if bashism

 Makefile             |  40 ++++-
 scripts/run-local.sh |   2 +-
 src/sched_debug.c    | 405 +++++++++++++++++++------------------------
 src/sched_debug.h    |  65 ++++++-
 src/stalld.c         |   6 +-
 5 files changed, 288 insertions(+), 230 deletions(-)

--
2.50.0

