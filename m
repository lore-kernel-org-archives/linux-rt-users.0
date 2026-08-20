Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC353314D9
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Aug 2026 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234289; cv=none; b=ip06DAaut7f8U3HOXHlYaHmGL5ENdLuh4+zDa2SdHZ3t7vtxoDB/d9swmIoxksnD9MYcfxtlslDyWYBulxUaYEFf+8z7uK69qxSGsh7Zsj1gWoMEpCdzDk++gQBVU3qrsp9eSPXSPMQNLW8xG9lDdAjzMWZgKDeoYoEoF2QCjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234289; c=relaxed/simple;
	bh=ZrIeOJ4OXKFuL33qGTZN/uDNa7sA1QjY8t1AnTtgE6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVDPif/zRZLECzn+AHfrI0BxT3opfkAITgfxOXqqFjmkIO7Lmc9cyIL0yW4TGIPW69PI1l3qWz3y1XvT3S0mbEjcXYJDgdLh+yFlOICZyC+2+QwxteUL4H9pPSo4Ps/X30SxnFJhCQY4NPZf/FmlWfLfINLM/XkApiluDcSIVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfVfE05P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfVfE05P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787234287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yoVG89juTISnp3+y+V7kvn0TqpzR42/pkMmGW8S5Yw=;
	b=DfVfE05PPRCNMObvjoU83M753wsR80iF+YVflLEA8WhT24G5nzyMasgKhdSfbM3NFZadQh
	GOrTmaduPBxKiXPHIWW9U599asAnGVH/huMT3sPPT5vWCFSZmHNedwE/fuLcvuHEaL3GOc
	+9sIjareXxcQp7ZyooWNoTswYZmzTQ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-OWlCfZcwPIeq4Su54dEM0Q-1; Thu,
 20 Aug 2026 09:58:05 -0400
X-MC-Unique: OWlCfZcwPIeq4Su54dEM0Q-1
X-Mimecast-MFC-AGG-ID: OWlCfZcwPIeq4Su54dEM0Q_1787234285
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F323D1956080
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Aug 2026 13:58:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.2.16.164])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92E743001DAF
	for <linux-rt-users@vger.kernel.org>; Thu, 20 Aug 2026 13:58:04 +0000 (UTC)
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH v2] Adding stressor validation for stress-ng
Date: Thu, 20 Aug 2026 09:58:03 -0400
Message-ID: <20260820135803.385563-1-sansshar@redhat.com>
In-Reply-To: <20260818231549.224764-1-jkacur@redhat.com>
References: <20260818231549.224764-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Previously stressor names were unvalidated.
This has been changed so that now if the user inputs an invalid
stressor name, they get an error message telling them to check
"stress-ng --help". The list of stressors is created dynamically
during "WorkloadPrepare()"

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/loads/stressng.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 32e2dbd..ed93646 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -10,6 +10,25 @@ from rteval.Log import Log
 from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList
 
+
+def get_valid_stressors():
+    """Query stress-ng for list of valid stressor names."""
+    try:
+        result = subprocess.run(['stress-ng', '--stressors'],
+                                capture_output=True, text=True, check=True)
+        return result.stdout.strip().split()
+    except (subprocess.CalledProcessError, FileNotFoundError):
+        return []
+
+def validate_stressor(stressor_name):
+    """Validate a single stressor name against stress-ng's available stressors."""
+    valid = get_valid_stressors()
+    if not valid:
+        return
+    if stressor_name not in valid:
+        raise ValueError(f"Invalid stress-ng stressor: '{stressor_name}'. "
+                        f"Run 'stress-ng --stressors' to see valid options.")
+
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
     def __init__(self, config, logger):
@@ -51,6 +70,7 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
+        validate_stressor(self.cfg.stressor)
         self.args.append(f'--{str(self.cfg.stressor)}')
         if self.cfg.workers is not None:
             self.args.append(self.cfg.workers) #default is 0
-- 
2.54.0

