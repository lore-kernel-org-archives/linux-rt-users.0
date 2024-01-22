Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C745482E2
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961606; cv=none; b=UPF5CKcrEgmt2xFZYJh5OrjQRiTE4FKC0gidy5p7hnRwccmcQZ9UMP8obnkP4rtmZrD7IIkmpKv8ViRYQwb7uiQGK0D1Vm1mF2eRm6nXE24ieXajDCl0teTe/RgdPYVVSljMz/Ne53Qo0/EC5vcTvxQZHLVU3mV691yPb8USanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961606; c=relaxed/simple;
	bh=n4pjtSkoWSVLYcomp1m3GeLU4iXPOF9YKXY1ouyN874=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHATNvnE195EchKA1O1nBDbsMG4SV+b45uOYtU22anneTKR7bmf8UXQ/TJr9/mAwfUkYmUxj9DUfjDByzvxxHUZJUx3qJyw3uM1hgmVVjPzrMwiDt6u0HUJTCee7QI0tEFW9mCawyHfqewCAYT5ISjkcOUqTXSR1AjldrLL5OD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3zYEkTS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3zYEkTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705961604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYwZJx1JOJPadtHq/jmXfmxYWdvpYTL+5Uh4sVZ3lYs=;
	b=Z3zYEkTSYDFNS4qB3aRnRA5uPISsUZAPTCprpK9O/ZM/lsCfFlz/1tt2P2zYyzCdbUiNDW
	1CnnFAG8imbjAUoaq50YDpQ5RoLEqgB17llwc48/aR/QVmDWOm/QpqzpCdmeNI1ka4+hpB
	9EFdOWPMIwuJD7SsI7+87jn55+GyzKo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-_jVzkroIPxi7lfDDA9lDUA-1; Mon,
 22 Jan 2024 17:13:22 -0500
X-MC-Unique: _jVzkroIPxi7lfDDA9lDUA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 165AA1C05AEE
	for <linux-rt-users@vger.kernel.org>; Mon, 22 Jan 2024 22:13:22 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C2D73492BC6;
	Mon, 22 Jan 2024 22:13:21 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 2/3] rt-tests: cyclicdeadline: Print the histogram regardless of quiet
Date: Mon, 22 Jan 2024 16:13:20 -0600
Message-ID: <20240122221321.9545-2-crwood@redhat.com>
In-Reply-To: <20240122221321.9545-1-crwood@redhat.com>
References: <20240122221321.9545-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The histogram printing code should not have been gated by !quiet,
even though other summary printing code is.

The non-histogram output also should not have been gated based on
the presence of the histogram.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index b3155547b9bb..3cb8f714b788 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1117,15 +1117,15 @@ static void loop(struct sched_data *sched_data, int nr_threads)
 	usleep(10000);
 	if (!quiet) {
 		printf("\033[%dB", nr_threads + 2);
-	} else {
-		if (histogram) {
-			FILE *out = histfile ? histfile : stdout;
+	} else if (!histogram) {
+		for (i = 0; i < nr_threads; ++i)
+			print_stat(stdout, &sched_data[i], i, 0, 0);
+	}
 
-			print_hist(out, sched_data, nr_threads);
-		} else {
-			for (i = 0; i < nr_threads; ++i)
-				print_stat(stdout, &sched_data[i], i, 0, 0);
-		}
+	if (histogram) {
+		FILE *out = histfile ? histfile : stdout;
+
+		print_hist(out, sched_data, nr_threads);
 	}
 }
 
-- 
2.43.0

