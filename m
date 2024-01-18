Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847F13FF8
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jan 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569508; cv=none; b=pSUOp99vaVDmpu7jnVF4NAmPCL2ARLNKcX3Y3ERhl+BDMOvoG/gHYtY9ImfVRaHmZL/eOvB/Ja3t55YaX04bytF+z3FM0Y9prstqWzoRRBt/JR33vZoxPYmDMQucbN5Qsy/lfM+QsRDiUcGcEeSHnYVMQ7y0GphO/mRpmn6mSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569508; c=relaxed/simple;
	bh=a94T6nBqRyHt1I27LxTlw2NY5Ow7opRgWfZu2TL/BgM=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By; b=rGhBKcIKu+UKI7Wc2xAGfOyuclRWb67vPHVDbyM3/FYbQs8ub7KcTnsIB42GCh3bjRnYKj0MfEVUpHvxL0JJNlXb6fM9WwCB6KmlUi20peCoc28t/HZPF7189zlCjByhWg+uqglNoDWsuoqY23MKlWxVzwJKo3pfgy/yIrsb6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHJ1yqOw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHJ1yqOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705569505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cGMyuSRpFMoUbW96T8gG9qfHG5FU6pKSATK3376Y3No=;
	b=eHJ1yqOwdWa2pH7sOBMIsPN6vEjBYvd9B8tFk+P9ZccP176TarWhYAaClfvtlDcvwdzs2e
	yPGvUDTBXg+mklTYYZNuS43JyKd5rgk3ADalSML2ddtZ/eTyFTguufsVH4yxHbLV9DUtym
	nnEuT254X23X4FJ7op/cLhOAYBhn7jI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-5-VJlw5MOcO5LCDYyHo2pw-1; Thu, 18 Jan 2024 04:18:19 -0500
X-MC-Unique: 5-VJlw5MOcO5LCDYyHo2pw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5D208353E0
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Jan 2024 09:18:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C612D1C05E0E;
	Thu, 18 Jan 2024 09:18:17 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 0/2] rteval: Add relative cpusets
Date: Thu, 18 Jan 2024 10:18:08 +0100
Message-ID: <20240118091810.127396-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

From: Tomas Glozar <tglozar@redhat.com>

Note: this contains only original patch 3 and 4; 1 and 2 have already
been applied.

v2: Implemented feedback for two remaining patches, namely keeping
the assignment of short names of functions from cpulist_utils in
rteval-cmd and other places. The original patch changed this to
always use the full cpulist_utils.<name> syntax, which had some
formatting issues with lines being too long and also made the patch
some tens of lines larger.

Tomas Glozar (2):
  rteval: Convert CpuList class to a module
  rteval: Add relative cpulists for measurements

 rteval-cmd                               |  34 ++--
 rteval/cpulist_utils.py                  | 161 ++++++++++++++++++
 rteval/modules/loads/__init__.py         |   8 +-
 rteval/modules/loads/hackbench.py        |   9 +-
 rteval/modules/loads/kcompile.py         |  11 +-
 rteval/modules/loads/stressng.py         |   8 +-
 rteval/modules/measurement/__init__.py   |  11 +-
 rteval/modules/measurement/cyclictest.py |  53 +-----
 rteval/systopology.py                    | 198 ++++++-----------------
 9 files changed, 259 insertions(+), 234 deletions(-)
 create mode 100644 rteval/cpulist_utils.py

-- 
2.43.0

