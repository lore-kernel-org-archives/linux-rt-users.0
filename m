Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6951CF8B
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389048; cv=none; b=UgcywKOtDHbQLRMSwIpN5Rqm50F+QU6r+cjqSgofg+eG5TbAqw+D1vLTo0BTYBSvXEvxCs2zmNZX2B+0AIBPRW5G4IvwS10OdOvG6SYmmdprRc1ilbiBbhXABFeniKgZgmQ6IMg8NUnE15h8YFYjKkOYckb9Ug6KGuvcH7mk8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389048; c=relaxed/simple;
	bh=9mjeMinRcxEgMtzVx5ir2RFZ+MmXZmbTcwU3hGOtZKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9zuWQKyiU6ymMDmV8lRNKC+nDF1gJd6YqavcxssDeyMS5/wtW4GAbooYeeYitnNLqeOJbXtkGqr+4dOYSQyOxLXeVPY427CpqLwfYTvH6IFVsNtK7md91gmyc3dlEgyDNXc2MLhJFMN/wRagGZzi/z1R2NSIiQncOIJxPbM9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrLG7pCZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrLG7pCZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716389046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m9bAdpxSeDrKz7dJEUWWFjXSu2iTXga6rqxQmx7H+Cs=;
	b=OrLG7pCZIC2lSZYj+7j3mW9RDHROJafRq4vhpIO8mE4LnEyvyaJinKQ/iz7Su6t0EN/gh0
	QHo1NQibBvLmdXXmxYxfvZ+Z7YOO++IAKnJkhBRB+Y8t7UozmAqnGkJ8GscDmod2FojpiX
	vibfl+yGV6YtTUexXTg76QQOblz7wX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-OpsSkTZVM3aXx8JXdXrbxg-1; Wed, 22 May 2024 10:44:00 -0400
X-MC-Unique: OpsSkTZVM3aXx8JXdXrbxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E00C7800074
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 14:43:58 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.10.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD78940C6EB7;
	Wed, 22 May 2024 14:43:58 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 1/2] rt-tests: hackbench: removed extra use of optind
Date: Wed, 22 May 2024 10:43:46 -0400
Message-ID: <20240522144347.13281-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Currently, using the -s option displays the usage message, even if the
option is properly used.

This is because Commit 778a02b7c519 ("rt-tests: hackbench: drop incorrect
and unnecessary usage of optind") forgot to drop a use of optind when
processing option 's' which was fixed in this commit.

Now the -s option works correctly with the proper arguments.

Note: The next commit in this patchset fixes "ERROR: do not use
assignment in if condition" on line 459.

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

