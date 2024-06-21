Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F85625
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936665; cv=none; b=VnaS2XsDAH7iUNCWAO99JhZO8u6kgpJpFq4/ofqIb1TmkQn9yCI0A7kFiwqw6V9mOrijiGxQptBZ/K6HgdbAjgIHKaSmfSbVcHG/L0WB0SQd5QvHkAawwsymtzjC74+KxtxHZPHR9gAZa6v7LxsdUB2Y8fFCxJcyj5acyqdg14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936665; c=relaxed/simple;
	bh=xdPNvTzFbOJKGNX5+vAY2FUe/OyhDdfrGeFBmES85so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqaYVHO6P8VK6BF6Acr7l+f8unq1o0ZkmexQOftqNE5tVY4UW17sbJDRHd9jd3bCutSGz4BGUrOPjqDxYgo7V8Yejk4qM1Fy0gan55gySxOmqBpcLC1PdlrlSSCbroBcv6WX5NmWmcYKtjPXXAaKBuT94oyPHhUDpq/57dy86lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzrzERnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzrzERnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718936662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=boffl59mJVkhuvLgc0e/20yinbBxMFMvEua81kFCeR4=;
	b=fzrzERntNE9KntqNZMUo5XSXxdSDKrvzG2zSA9M7EqZ4ToIPJQud3H8v3bXXnWtxqZLY9q
	d7xZYfetxpslIA1EXm/WXM+xNTp9MI1Sp9cs7+37f8rvqJ8Fsh5hhA4SUaLWZzPV4+P7ao
	L+WZYU/fe8/MQKawXmzYvCAvaheoKYA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-i0S7cR_wOKmUegUP8eMUBA-1; Thu,
 20 Jun 2024 22:24:20 -0400
X-MC-Unique: i0S7cR_wOKmUegUP8eMUBA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83AB6195609E
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:24:19 +0000 (UTC)
Received: from p1g2.hsd1.mn.comcast.net (unknown [10.2.16.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C8AE1956053;
	Fri, 21 Jun 2024 02:24:18 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH 0/4] rteval: Remove measurement profiles and make latency mods exclusive
Date: Thu, 20 Jun 2024 21:24:13 -0500
Message-ID: <20240621022417.2086751-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ensure that only one latency-measuring module (cyclictest, timerlat, etc)
runs at a time.  But first, remove some questionable unused module
infrastructure so that we're not just adding to the confusion.

Crystal Wood (4):
  rteval: measurement: Remove ModuleInfo()
  rteval: Remove MeasurementProfile
  rteval: RtEvalModules: Remove unused methods
  rteval: Enforce only one latency measurement module at a time

 rteval/__init__.py                       |  64 ++++----
 rteval/modules/__init__.py               |  61 ++------
 rteval/modules/measurement/__init__.py   | 180 +++--------------------
 rteval/modules/measurement/cyclictest.py |   6 +-
 rteval/modules/measurement/sysstat.py    |   7 -
 rteval/modules/measurement/timerlat.py   |   6 +-
 rteval/rteval_histogram_raw.xsl          |  24 +--
 rteval/rteval_text.xsl                   |  41 ++----
 8 files changed, 88 insertions(+), 301 deletions(-)

-- 
2.45.1

