Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB29763F1
	for <linux-rt-users@vger.kernel.org>; Tue, 21 May 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323388; cv=none; b=M3htDm1ScvGWD1DK57/9umkVBIsy8HDeIEekdSc1DXCfN/HJhNz+1KwC0eYzmvzgtHZwYBWO/7PYdIiXeL78421/Q7znwzr8TqVL7tW8GsCRGkY9IYqSNK3/lwGnLl3aySas/BBaPCHXXC6yzBkN1U44J0b+ScT73H5ryOx96LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323388; c=relaxed/simple;
	bh=MWOa1kZScgXLLeFGFuG1H8/9ETe+RNGYDGm/EguhhFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRIuEvMNIGBVx3E5AsmuR1ZAalq6AQg+bh4NpsUvWd+LphNpCylDQL109QHQl/ibTsBotAtkazcvTkUA5wm82j9FHVeicneVYkN1kamH7ZF5C8lQuGXN5t3hYvO4WIRIbSORwc/JV4bK806PZp7Fsa5PyaQerTgoUeLhFnYhw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9sYQ3df; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9sYQ3df"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716323384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OO0oLkLC31sza4Up0r7aw5L4nUiacfbbfNPFVtsQU1k=;
	b=T9sYQ3dfd/EIefJTlhgP52z3PZuF5wvGeqlmcKzRh38v95bcnrSWxtOpYxL8tGmfmiAIP/
	f2zU70d+HpUk75zvXF7HQ456mh+NwQX4/YC0hzS+t4rH4GgDOgWLH551jkzhBXuw8CniHd
	I3FDK+bFHGRfJ4GeXu9i2ge6d7dQHYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-mPw06JJkN0WjnFqOemXtpw-1; Tue, 21 May 2024 16:29:43 -0400
X-MC-Unique: mPw06JJkN0WjnFqOemXtpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42460101A525
	for <linux-rt-users@vger.kernel.org>; Tue, 21 May 2024 20:29:42 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.34.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 178F11C09480;
	Tue, 21 May 2024 20:29:42 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 1/2] rt-tests: hackbench: removed extra use of optind
Date: Tue, 21 May 2024 16:29:39 -0400
Message-ID: <20240521202940.242048-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Commit 778a02b7c519 forgot to drop a use of optind when processing option 's' which was fixed in this commit.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 src/hackbench/hackbench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index d4924b3cc129..fec8357bef81 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -456,7 +456,7 @@ static void process_options(int argc, char *argv[])
 			use_inet = 1;
 			break;
 		case 's':
-			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
+			if ((datasize = atoi(optarg)) <= 0) {
 				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
-- 
2.45.0

