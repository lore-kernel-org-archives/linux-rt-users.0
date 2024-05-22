Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C81B5A4
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389044; cv=none; b=taVPsVnlu59As42nEpe64lKqAh6YPAoFDRJ6ukjbOyRvXacQkbPsRcNsXwrHiMKn2zZbfq2B/asrm9J49XYF9IXoW//S/FVw0OEQeDFM+wd+TAOJpGCfEC4brHjQwQRh/+ZIST5hyYTYMU1DTRpWDsm2V4OMWbNNo6rpfq1KqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389044; c=relaxed/simple;
	bh=6sSrfvk1/kcujqgfkoKJSdZgUf8CHGNQOzgm4oY/1IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdGmtJKJ27NxTnKJqbhNiMUHm7Ba5LX5pts/Jx7topM2U0WklUNfRTMYAqjZIIuHyPAD/TVjehobb0/oma0PHbhqiXph67BpSgNKKR88pNGwWrWTn6tVcIpYCG/MPRIMgEsuuYaHrB9HAXnsI9cyx60SadGOIJ5/3c6Pkzd8NWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8hcdnQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8hcdnQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716389042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJxVfKh2AXC2Bv5e89l36UOtB1vPZi794jHyNuLbDmE=;
	b=F8hcdnQi+3sU5Ztf8aV6WhWVreeWNRXmCKC285n3Hc8mIQeFEAeR89XJu+U1/TlhKhI4sp
	KjCabRhRbxw+9ima5UTtnPQ12uonSnfKRTgMsFB0URPKuhVgzn0C9aSuSXMBZHqZX1IAEv
	IkR4yBOIkO6u4yTimq98dVz83ciMEhs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-bnJX9IhePvG-QpetoiMwrw-1; Wed, 22 May 2024 10:43:59 -0400
X-MC-Unique: bnJX9IhePvG-QpetoiMwrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CE348008A4
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 14:43:59 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.10.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECBB940C6CB4;
	Wed, 22 May 2024 14:43:58 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 2/2] rt-tests: hackbench: properly recognize when integer arguments are negative
Date: Wed, 22 May 2024 10:43:47 -0400
Message-ID: <20240522144347.13281-2-ashelat@redhat.com>
In-Reply-To: <20240522144347.13281-1-ashelat@redhat.com>
References: <20240522144347.13281-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

hackbench is supposed to catch when the user passes
negative arguments to options -f, -g, -l, and -s.

Previously hackbench would allow options to accept
negative arguments, resulting in undefined behavior.

Now process_options() assigns variables outside of
the if considiton where they are used. hackbench will
output a usage message if the user inputs a negative
argument.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 src/hackbench/hackbench.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index fec8357bef81..55be325a38df 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -426,7 +426,8 @@ static void process_options(int argc, char *argv[])
 		}
 		switch (c) {
 		case 'f':
-			if ((num_fds = atoi(optarg)) <= 0) {
+			num_fds = atoi(optarg);
+			if (atoi(optarg) <= 0) {
 				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -435,7 +436,8 @@ static void process_options(int argc, char *argv[])
 			fifo = 1;
 			break;
 		case 'g':
-			if ((num_groups = atoi(optarg)) <= 0) {
+			num_groups = atoi(optarg);
+			if (atoi(optarg) <= 0) {
 				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -444,7 +446,8 @@ static void process_options(int argc, char *argv[])
 			print_usage_exit(0);
 			break;
 		case 'l':
-			if ((loops = atoi(optarg)) <= 0) {
+			loops = atoi(optarg);
+			if (atoi(optarg) <= 0) {
 				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
@@ -456,7 +459,8 @@ static void process_options(int argc, char *argv[])
 			use_inet = 1;
 			break;
 		case 's':
-			if ((datasize = atoi(optarg)) <= 0) {
+			datasize = atoi(optarg);
+			if (atoi(optarg) <= 0) {
 				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
 				print_usage_exit(1);
 			}
-- 
2.45.0

