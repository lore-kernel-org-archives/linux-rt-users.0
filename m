Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E3483BF1
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075975; cv=none; b=osISQx2whPLXksl+VNTjL16b1wxgdlUXnCkUksJnLDJR1wfaal01w5qZb7UmKL7/99l+rMqOHm28mzdArMgqPim4pVhPlnrGYAVDMDdB/Cn/0x+SpIQsyAC2hQgFkA8vYYfL1HIbyVK9V2x0oUYEgDZkw0c2JnoL21LNRa5cc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075975; c=relaxed/simple;
	bh=YbUVxklWHYMadk5CEfCMMqj3BmP15Nisx/4mFvxpLlY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FyUK2IKEPcyxU7f/hxLt/y159LftTsH1UQCb1LZgBf1D2s89MYw8VoKKfWO/jnGalV4ApEVG76EoecmTrWY2qaMtuqtbpZoNWGlkhSg2qM14hFKMHcyDBKCMVyWGumOgXlmJJTkhXMLoAk8zE7utiradH2h4zCDbFaOtM3wrIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKTNinD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKTNinD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787075972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oKsGI2SN0b9iOufjvbXnHG/09ysGKucbfFXTTydCRxs=;
	b=VKTNinD2b9biNkOwxsJnv4AeBoicPtX3UmBVzOkWL2YYptCrTwnJ0qg4BIQWpeg2ZvwJ5A
	kgVHuuWb+KWz22ZpKvtJmmkL117R8eu8qG1GCJLbRs4DKTk5kcQIii9YNW7hTylLxFQg5w
	j24zK/1bBG+XJPq/Bc4Zo5FIzapwRIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-iJgECuznN8iC3GWc5Cpn5w-1; Tue,
 18 Aug 2026 13:59:26 -0400
X-MC-Unique: iJgECuznN8iC3GWc5Cpn5w-1
X-Mimecast-MFC-AGG-ID: iJgECuznN8iC3GWc5Cpn5w_1787075965
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B35E8195608B
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 17:59:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.2.16.157])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 520613000239
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 17:59:25 +0000 (UTC)
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH] Adding stressor validation for stress-ng
Date: Tue, 18 Aug 2026 13:59:23 -0400
Message-ID: <20260818175923.315976-1-sansshar@redhat.com>
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
during "WorkloadPrepare()". The helper functions are currently a
part of the class but we could also make them static methods,
depending on opinions.

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/loads/stressng.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 32e2dbd..a72ab9d 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -31,6 +31,25 @@ class Stressng(CommandLineLoad):
         # When this module runs, other load modules should not
         self.set_exclusive()
 
+    def get_valid_stressors(self):
+        """Query stress-ng for list of valid stressor names."""
+        try:
+            result = subprocess.run(['stress-ng', '--stressors'],
+                                  capture_output=True, text=True, check=True)
+            return result.stdout.strip().split()
+        except (subprocess.CalledProcessError, FileNotFoundError):
+            return []
+
+    def validate_stressor(self,stressor_name):
+        """Validate a single stressor name against stress-ng's available stressors."""
+        valid = self.get_valid_stressors()
+        if not valid:
+            return
+
+        if stressor_name not in valid:
+            raise ValueError(f"Invalid stress-ng stressor: '{stressor_name}'. "
+                            f"Run 'stress-ng --stressors' to see valid options.")
+
     def _WorkloadSetup(self):
         " Since there is nothing to build, we don't need to do anything here "
         return
@@ -51,6 +70,7 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
+        self.validate_stressor(self.cfg.stressor)
         self.args.append(f'--{str(self.cfg.stressor)}')
         if self.cfg.workers is not None:
             self.args.append(self.cfg.workers) #default is 0
-- 
2.54.0

