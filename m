Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C8311C06
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780994; cv=none; b=HSDbinTS1hRzJrjxkHx7RtSn1SgeY4DJUatJjQceoBdU4daRi3J3ijmDCwnTO9EWWa7A/7Ncl5G/9k6q3zBO0Pf2qM3m19V2UtDGms2QvPwwl9V5nIOsv75tStTQgOH8rJ+LwBnzBRTKN3mwyWox6gpeoRcoA/7/ZPi2Sse0MdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780994; c=relaxed/simple;
	bh=aiPnc/5lw1FuCMtabOOIhzt2RYGBhxTDYexVL+tv6Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYV1+5TQTi/nw6pJEQ26dUCGyKq46jvdqhP7d7YBniqImcVXTCwDXQsybCbOEBxVjSzFGWuUENUqizPnox6t/WZV7EEbo3RKEfab/4bxItuoX2l36I6+2maG3utSJ2LkR1s/NRTItC8oHt3t6yFlCE4LMylhd9YkTLLtGt3WoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDkOwFSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDkOwFSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762780991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z2vPm2KJfWHr7ZuE1vkmiQiF6VJegDI3wqPT/8QaeZ0=;
	b=PDkOwFSQKOw0+i1Av5yW2v3AiebsGNFUziks3EvDtvSN8DS4aZpBkWJgk6TOj6gup/gqeO
	pAF5qlQPdiWJ/TF3qBPN8QRVf20ZdfU3/87QUzkIwzybt2cLXMHMO5jSSrQbCE1ZQdPgTk
	+PMs30edVUicOOLGYTtWYBx4GmoUMks=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-wZkzyxKRMTmU7JsgteBDfA-1; Mon,
 10 Nov 2025 08:23:08 -0500
X-MC-Unique: wZkzyxKRMTmU7JsgteBDfA-1
X-Mimecast-MFC-AGG-ID: wZkzyxKRMTmU7JsgteBDfA_1762780987
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F98F1956095;
	Mon, 10 Nov 2025 13:23:07 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 212D2196FC91;
	Mon, 10 Nov 2025 13:23:03 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>,
	Derek Barbosa <debarbos@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>
Subject: [stalld v2 0/6] Improve Makefile portability and debugging
Date: Mon, 10 Nov 2025 10:22:35 -0300
Message-ID: <20251110132241.43685-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch series improves the stalld build system to be more portable
across different architectures and compiler toolchains while adding
better debugging capabilities. The main motivation is to eliminate
hard-coded compiler version checks that were brittle and could fail on
non-standard toolchains or different architectures.

The changes replace minimum version checks with direct compiler feature
detection tests, ensuring that compiler flags are only used when
actually supported. This approach tests each flag by attempting to
compile a minimal test program, making the build system resilient to
variations in compiler implementations across architectures like x86_64,
aarch64, s390x, i686, and powerpc. Additionally, the series adds build
environment information output and cleans up redundant checks to improve
maintainability.

The series also includes minor improvements to explicitly specify the
test target invocation and exclude development environment metadata from
version control.

Wander Lairson Costa (6):
  Makefile: Conditionally add -mno-omit-leaf-frame-pointer
  Makefile: Improve compiler flag detection for -fcf-protection
  Makefile: Explicitly run the 'test' target in the tests directory
  Makefile: Remove redundant GCC version check
  Makefile: Print BPF tool versions for debugging
  gitignore: Exclude Serena and Claude Code metadata

 .gitignore |  2 ++
 Makefile   | 42 ++++++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 18 deletions(-)

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>
---

-- 
2.51.1

