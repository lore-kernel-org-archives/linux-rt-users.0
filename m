Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1630506A
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781013; cv=none; b=JQYcFYp+pjen389WyvjpTDkRSKdMo8vEka1GHbA6HwIMscVLlj0tUJ3JAaKwPmV69TNCbwDm2QdI40uFNf3N9aLdiwAUpmT75orWZN7x10IcyTMB+YfMtPpB7IfO79ytQjNnunEYH8m8dX34tFJ/4mbF7udRQbjmeCR9Db20oQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781013; c=relaxed/simple;
	bh=8S9asUjcIxr8sygDyH1CWh2gKwhksrVASAxP3jOnMKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzJvtHwzTZtBcjXF2nbIEf+9SgHVzoYPlE24HNPuu3mpWPDigCx29YkSiv7lei3QoAWTKRzN5T6qm0mbqnRmqsQhuPdE/35eTnfSAh9CxyxshzATFS5Zhw0wY/S7vj36S4mMdzLahelkeoOd27wuSgVfZllk2jc12SNnSUC566c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7xVRX5u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7xVRX5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762781011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud5JfjQ4+LDpOAiRd8ZMGAIQrFChoWIuAK54p+sOG/8=;
	b=i7xVRX5uNHXxqIaMrehpcocDd6FBawR50gNjRP7EiKLKzEMLVhIS5uuX8LvJWRIWD6JJ7V
	waR1nrDxod41JwABtw9RDY7eez7v3HsXitc2m6YedUDRtbEDx/hwo2rZH39CAJWDKzXfaZ
	S0cN1HixSuXwpSZ8YTHlOSeVrRD1DGQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-IoAJkaaUPpeIb2n2ZuYtWQ-1; Mon,
 10 Nov 2025 08:23:29 -0500
X-MC-Unique: IoAJkaaUPpeIb2n2ZuYtWQ-1
X-Mimecast-MFC-AGG-ID: IoAJkaaUPpeIb2n2ZuYtWQ_1762781008
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B797E180034A
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Nov 2025 13:23:28 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12A6E196FC8B;
	Mon, 10 Nov 2025 13:23:26 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>
Subject: [stalld v2 6/6] gitignore: Exclude Serena and Claude Code metadata
Date: Mon, 10 Nov 2025 10:22:41 -0300
Message-ID: <20251110132241.43685-7-wander@redhat.com>
In-Reply-To: <20251110132241.43685-1-wander@redhat.com>
References: <20251110132241.43685-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This commit adds .serena and CLAUDE.md to the .gitignore file to
prevent Serena IDE metadata and Claude Code documentation from being
tracked in version control. These files are development environment
specific and should not be part of the repository.

The .serena directory contains IDE-specific configuration and cache
files, while CLAUDE.md is used for AI-assisted development guidance.
Both are local-only files that vary between development environments
and should remain untracked.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index dc802f6..62fddc0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,3 +18,5 @@ node_modules/
 patches/
 tests/legacy/test01
 *.patch
+.serena
+CLAUDE.md
-- 
2.51.1

