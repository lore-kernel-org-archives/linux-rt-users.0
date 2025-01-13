Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17122A4F2
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770753; cv=none; b=WP/rQUi94+oF/d4b48RahEuR0eHCSN3ZN1Qbuti1nFTWAcOC2+MXiR/fcDUdWaT0JdMRB/KQT9JlUZ9pApL6F3UINq6aeBBJPsd6QRX6VHTjWomfTJXp4JXa+QAkhj02jBb+owgCva2dVYxL9HHaoTeSnFK8MfjzN3WwSMWxPx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770753; c=relaxed/simple;
	bh=lQeVtV5T08xjD/I1InxPCbWdQpv5G55AquosTQ+rLoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYasvnNk/wQ0h0J9sxEsaGORLKnzJvkghOaFKQ6Qc/wo/GUj268duppEn/PCw4dwdBudh3MTqoeUuMHfRb0GWjoSOE9lSVaFdd4NsCN/RHlc5U8uSXlAbNI8x75pmlJsg+sw7Bt1/bEn2siL5IRHhWHhMVNo9BQGZqeNaJ+q/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivzYWRVP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivzYWRVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736770751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y5zr0HMV1F9b8GfxTzEwBFmzj5nZCRraRy0dvCcDfEE=;
	b=ivzYWRVP8tXxwWhtrrGfS3r5AGR75z5TgBM3x4AsGTk8qIC+kur9OwhyGjLToBNLLrd2cb
	ugvoRSqUq7Po/Xxi7z9dGk2IGXbKPTfgxquf9ckVCZEyfTefYO+hCwoxOUWbLF+0OXJc3Y
	N7PSj+aDd8uEV+kpck8f1yBRNb6lzE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-7AXMcKP4MUypzvJLnKxY_w-1; Mon,
 13 Jan 2025 07:19:09 -0500
X-MC-Unique: 7AXMcKP4MUypzvJLnKxY_w-1
X-Mimecast-MFC-AGG-ID: 7AXMcKP4MUypzvJLnKxY_w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF90E19560AF
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 12:19:08 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.214])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E9641956056;
	Mon, 13 Jan 2025 12:19:05 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] rteval: Allow configuration from stdin
Date: Mon, 13 Jan 2025 13:18:56 +0100
Message-ID: <20250113121856.225406-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Modules can currently be set only via configuration file, if rteval is
called from a script run on different systems, the only way to make sure
the loaded modules are known is to provide (or generate) a configuration
file and pass it via -f/--infile .

Add the possibility to use - as input file to read the configuration via
standard input.

This allows something like:

 # rteval -f - << EOF
[measurement]
timerlat: module

[loads]
stressng:  module
EOF

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 rteval/rtevalConfig.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index 0c2fc6b..4c41ed7 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -238,10 +238,14 @@ class rtevalConfig:
             # Don't try to reread this file if it's already been parsed
             return
 
-        self.__info(f"reading config file {cfgfile}")
         ini = configparser.ConfigParser()
         ini.optionxform = str
-        ini.read(cfgfile)
+        if cfgfile == "-":
+            self.__info("reading config file stdin")
+            ini.read_file(sys.stdin)
+        else:
+            self.__info(f"reading config file {cfgfile}")
+            ini.read(cfgfile)
 
         # wipe any previously read config info
         if not append:

base-commit: 5edb31a58bea3c2433e817439e053b79221a06df
-- 
2.47.1

