Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8772003AC
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498328; cv=none; b=SxGp8xnDvTvvTlpjlWa31g3Y7U0Mdy8nY1xxep/pyAZGjnWln8ToKIX35KId1X1yXozeQgbx58t6SF+5fIK/bw31kbOnliOyvo8D4m+hl1Ci5DZgV6f+WuXIjlcxlOxxPn8ihoiaZcEtW2Sr3nCZ4MqW7/mM+5nLxEro9BpeHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498328; c=relaxed/simple;
	bh=GlTnsop7ApwiywgB9THBhr6Urbgq53/K36v52VYfJQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpRIL97lIbSafSIvofVCoULoUBsUWJC4UV2/8W3cOfHIMJ/1fCl2Ch/YbcJKKkEragfdHAXmewYc2A29J2ZsFliuEdy78cJ1KGVtA03u9PCGPs3gQShYIOlbQw6MU8rnYejHHgjl99qCzJbpiFK2SGAwd37bXcfWLtVjQECL7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOVYwkUJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOVYwkUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731498325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CKW8CR6Fb8Bg3eQH6Bgf6iQyB26CWhO3p4AbA9JLAFI=;
	b=aOVYwkUJaEB/J3UGyMhd08MJErswViO70RJ8l8AgFqRvEwH6ASB0b3inqDk6Yhacq8eAt3
	EEu7em4MjNiCb6mtdx1g/tuvu+Hf2d617EZLTCoEZBkHVO7URi7WTgOLroCjewsR/qkjrz
	S7GDw+w09OqNM5g+FLXEWzkTwAX7DyA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-WilH4FjuOtm7dlzjaLPMvQ-1; Wed,
 13 Nov 2024 06:45:23 -0500
X-MC-Unique: WilH4FjuOtm7dlzjaLPMvQ-1
X-Mimecast-MFC-AGG-ID: WilH4FjuOtm7dlzjaLPMvQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D17E719560BE
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:22 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FE15195DF81;
	Wed, 13 Nov 2024 11:45:21 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	williams@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 0/3] rt-tests: cyclictest: Support idle state disabling via libcpupower
Date: Wed, 13 Nov 2024 12:45:06 +0100
Message-ID: <20241113114509.1058593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Tomas Glozar <tglozar@redhat.com>

v2:
- Pass CPPFLAGS and LDFLAGS to feature test make
- Fix indentation (4 spaces to tabs)
- Avoid calling set_latency_target() when --deepest-idle-state is set
- Sort command line arguments in alphabetical order
- Add no_libcpupower make option to disable libcpupower dependency
- Update manpage with the new feature

Tomas Glozar (3):
  rt-tests: Detect libcpupower presence
  rt-tests: cyclictest: Support idle state disabling via libcpupower
  rt-tests: cyclictest: Add --deepest-idle-state to manpage

 Makefile                    |  15 +++
 feature/Makefile            |  12 +++
 feature/test-feature.mak    |   5 +
 feature/test-libcpupower.c  |   8 ++
 src/cyclictest/cyclictest.8 |   3 +
 src/cyclictest/cyclictest.c | 205 +++++++++++++++++++++++++++++++++++-
 6 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 feature/Makefile
 create mode 100644 feature/test-feature.mak
 create mode 100644 feature/test-libcpupower.c

-- 
2.47.0

