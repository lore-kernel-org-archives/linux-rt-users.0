Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455C4734E5
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039266; cv=none; b=A620MHwtXZoofBxxpWI4Am4HaiQumUyV4W2InNS0wbPBEcamucytHb3t7EUWox9DKlNUDIwVgspZRPhprbg4n9T7pD7255jtkRe95+OGvJRY8dZU1hNbFNC57E79hDhRC2NBVAoBDWId5fCpiEwyZt8fmGOnXwdLI6yK7NsoLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039266; c=relaxed/simple;
	bh=Rk5gzu02mMN1ex0R9ghKDgovASZtezgwgipuRD20OCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cse2jrMNmkbNgu3erqKXfsGCeiYQ4p/icI2l+RSxIdjXAsEiqBNXAJXtu/iKoMQko9BHkECHLO3ow2qDhSgHf5B3C/pvyep6XX/HAmuNOkw1gI4YmUDQOb5iJlM9sbFdti4YfcdgfsT6V4KCu043GdG5hl1lBg1u3Hl84D1LJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFK5u8vJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFK5u8vJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789039263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VWvTT7WLBo2FKTT3UrkjXZwn71kr+uy0hWU60tUyHr4=;
	b=bFK5u8vJ/gJiOZB0WJVzssoWHsMUta3Ww7oiNu9oOhzeVnnDgxcyGTePbjaKiQzOkNmT3O
	9wxR0htca8o+8XYrL/BHt14JkCHIEBSw2Lqay8YguAc8WJqS8TyZpAx4iWu34+pr+nF0LQ
	dqnr1RCa1FkZJNUZUttNpXB5UbPiNqM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-PmaNBSeIOo6Zagz0_fOByA-1; Thu,
 10 Sep 2026 07:21:02 -0400
X-MC-Unique: PmaNBSeIOo6Zagz0_fOByA-1
X-Mimecast-MFC-AGG-ID: PmaNBSeIOo6Zagz0_fOByA_1789039261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D11E1955DC5
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Sep 2026 11:21:01 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD89D18002A6;
	Thu, 10 Sep 2026 11:20:59 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Update E2E tests to cover multiple recent changes
Date: Thu, 10 Sep 2026 13:20:48 +0200
Message-ID: <20260910112048.310474-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

There have been multiple changes to the command line passed by rteval to
rtla:

- Commit f2c619a7ca08 ("rteval: Fix timerlat module for rtla short
  option parsing bug") changed the format of rteval's short options from
  "-o<arg>" and "-o=<arg>" to "-o <arg>".

- Commit 5153f0e854cf ("rteval: Refactor timerlat parsing and fix max
  line duplication bug") commented out "--no-summary" to get more
  information out of rtla.

- Commit daf3e54bae7c ("rteval: Fix timerlat stoptrace trace analysis
  capture in XML") makes rteval not pass "--no-aa" in runs with
  --timerlat-stoptrace.

Reflect the changes in E2E tests to make them pass again. Note that
some partial matches were extended with more arguments in the process
for the purpose of more clarity.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tests/e2e/measurement.t | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/e2e/measurement.t b/tests/e2e/measurement.t
index 9d1f438..62c39eb 100644
--- a/tests/e2e/measurement.t
+++ b/tests/e2e/measurement.t
@@ -72,30 +72,30 @@ check "timerlat duration" \
 
 check "timerlat command, with --measurement-cpulist" \
   "--noload -d 1 --measurement-cpulist=0-1" 0 \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c0-1'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c 0-1 -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --measurement-run-on-isolcpus" \
   "--noload -d 1 --measurement-run-on-isolcpus" 0 \
-  'Command: rtla timerlat hist -p100 -P f:95 -u'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-interval" \
   "--noload -d 1 --timerlat-interval 2000" 0 \
-  'Command: rtla timerlat hist -p2000 -P f:95'
+  'Command: rtla timerlat hist -p 2000 -P f:95 -u -c [0-9|-]+ -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-priority" \
   "--noload -d 1 --timerlat-priority 80" 0 \
-  'Command: rtla timerlat hist -p100 -P f:80 -u'
+  'Command: rtla timerlat hist -p 100 -P f:80 -u -c [0-9|-]+ -E 3500 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-buckets" \
   "--noload -d 1 --timerlat-buckets 4000" 0 \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E4000'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 4000 --no-aa --dma-latency=0'
 
 check "timerlat command, with --timerlat-stoptrace" \
   "--noload -d 1 --timerlat-stoptrace 1" any \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary --no-aa --dma-latency=0 -T1'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 3500 --dma-latency=0 -T 1'
 
 check "timerlat command, with --timerlat-trace" \
   "--noload -d 1 --timerlat-stoptrace 1 --timerlat-trace trace.txt" any \
-  'Command: rtla timerlat hist -p100 -P f:95 -u -c[0-9|-]+ -E3500 --no-summary --no-aa --dma-latency=0 -T1 -t=trace.txt'
+  'Command: rtla timerlat hist -p 100 -P f:95 -u -c [0-9|-]+ -E 3500 --dma-latency=0 -T 1 -t trace.txt'
 
 test_end
-- 
2.55.0

