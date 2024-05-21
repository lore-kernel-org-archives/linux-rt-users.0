Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209E3FB8B
	for <linux-rt-users@vger.kernel.org>; Tue, 21 May 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323387; cv=none; b=JA4H3ck3Dt74wbfVYrCP/xLHoWBRD0RmCPbIMGbKHKsgZRMFFtBWTcl+9FW6k07EGW0UV05auP0gNjOTw0fGBGuibs58H1IMbuwCmWmVw/eNUTTupZC7GrGZsA8ExHrIxXshHZznp4g+acabrMXf224/BSpQnPkdBjNz5+sxmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323387; c=relaxed/simple;
	bh=R/DRH90I1hd5lYawsSkWZBhO/skpjwxVbLW8gOmjhJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ll/eiqgMrSVd9fVUzk59/YFq2CNndLqpXqVuarvDuOMplF3fEPlFGJNsS5UiVAbdaLZEvqQhqzxQoNN+zxp/oPEGQ6Rlw/kooDjJTafpCzKl7XdT23cvEJtRESpYugyJkOBcrYnoFtlw9wqfwsBU1WTS93u/orRtro/FqOcKEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqALjI1G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqALjI1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716323384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lx73nn8F4Ho6ef6K7a7LKG8q6qKvppeV1KsmLrXCbM=;
	b=MqALjI1GISaFysdeKMgJtgwn0EMLltWt/GMZ8V0u53ZNh+jKerfN/XKu93mFYwFfM4F55S
	MZWqd/JSxlYEjVHUKqUu5mWqBzd/Q2iMlPu10hQVxi3w0WRmPSePuToUduMCLa/ahVf7af
	6yPzC3UQ37qRcF5VhVP6VgZdNly+jfs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Wqb6uKN0NeqSJ2G1K8cS9w-1; Tue, 21 May 2024 16:29:42 -0400
X-MC-Unique: Wqb6uKN0NeqSJ2G1K8cS9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F52800994
	for <linux-rt-users@vger.kernel.org>; Tue, 21 May 2024 20:29:42 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.34.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 498141C0654B;
	Tue, 21 May 2024 20:29:42 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 2/2] rt-tests: hackbench: properly recognize when integer arguments are negative
Date: Tue, 21 May 2024 16:29:40 -0400
Message-ID: <20240521202940.242048-2-ashelat@redhat.com>
In-Reply-To: <20240521202940.242048-1-ashelat@redhat.com>
References: <20240521202940.242048-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Previously hackbench would allow options to accept negative arguments, which would result in undefined behavior. Now process_options() properly catches when arguments are negative.

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

