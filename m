Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1C4174C
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419362; cv=none; b=D/eDgYVA/nHTnsBAcxaWKzZkwbn9xEORQiRYs3mGAyphxVSNBLeCxKzI17fA67xh2eDlp5SYwzhr0E/+2yQ6ZGFfQu60/+A9JkiuQM4pHgsOMLE6DMCgCih25Nz04M0TAvdamKKWdAj2rg3N4F6G9VcoC8O7g56qQVW7eLzjkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419362; c=relaxed/simple;
	bh=v/WXaEgxcra5s+9u8A9b1PhXBdSf8TuFUQa9X6aeI8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cknb0oETEczxd3hC03yTlf63fYvQbI6qVV7KDeq3lDoj4671ysBKwEamXqNS3u0YM1wqRPd7D1Y9vdK0PvwN4xDItojdvmVdktzfQdaQACn6W/nVcXJmuyFR06dS1UqI0f+p16N+YW03f0Q77arPDBtdmtOd7CPF+JyxhIX09Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtgRd9Op; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtgRd9Op"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721419359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JM+E0QmI63tIitQPwyLMhC2gPtaVcMNCli5gWRgx9iU=;
	b=RtgRd9Op3/xQwPmlpAgAzlMkPK2zYEEFShoKTqNCRkgl+KFafjSEqJfOOQkkbSjN0+Lv99
	+x///EUr1z9x8PRK4o2mxzRKr4lpqzLHE2iKYyC48hXtRFt1Zh/aYmNRAt7A20IBHp7eCG
	OJaCTrCOqG3X6nuUEi+FJg66m5F43ng=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-QZXXqul3OrmS38voDbqtsw-1; Fri,
 19 Jul 2024 16:02:38 -0400
X-MC-Unique: QZXXqul3OrmS38voDbqtsw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4992C1955F43
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Jul 2024 20:02:37 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.233])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF63E195605F;
	Fri, 19 Jul 2024 20:02:35 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rteval: Fix default measurement config
Date: Fri, 19 Jul 2024 15:02:34 -0500
Message-ID: <20240719200234.88661-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit 761741d15d08e ("rteval: rteval-cmd: Some style changes suggested by pylint-3")
accidentally indented the check for missing measurement config, such that
it became part of the missing load conditional.  This was harmless if
the cnofig file was missing entirely, but not if the config file
exists but the measurement section is empty.

Also, remove timerlat from the default as it conflicts with cyclictest,
and we're not quite ready to make timerlat the default.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval-cmd | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 36b167a034e5..19c82a0b64b3 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -247,11 +247,10 @@ if __name__ == '__main__':
                 'hackbench'  : 'module',
                 'stressng'   : 'module'})
 
-            if not config.HasSection('measurement'):
-                config.AppendConfig('measurement', {
-                    'cyclictest' : 'module',
-                    'timerlat' : 'module',
-                    'sysstat' : 'module'})
+        if not config.HasSection('measurement'):
+            config.AppendConfig('measurement', {
+                'cyclictest' : 'module',
+                'sysstat' : 'module'})
 
         # Prepare log levels before loading modules, not to have unwanted log messages
         rtevcfg = config.GetSection('rteval')
-- 
2.45.2

