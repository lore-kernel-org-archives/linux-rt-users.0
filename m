Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79E8F61
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587021; cv=none; b=EQyerg8wWU1SNQYHTPwIMrMF8l4xx8LCb0eRK7pXWkKhKQ4qEXUSMm8MRU4lBJvSVaG8hcsZkFpd74q1dcmEBwB43qoQvdNnZoVJoTsY6HWNIT8B/RshbWQYCEKUvXhCmdqXdyU+e8OC+3YHFq0/dWHS1UyQm7Iby0r4lc0IMZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587021; c=relaxed/simple;
	bh=amX7ROSPBroEl6QJ10Qg+PPDne2YoDdStpEvIRV6iTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U18G92x1c/cCRbxpqMT+SjV0y/a5YEzso26Uu3ZMqhIFnmWlnpJs5jp04Y8/AhiVK8/R4TeSaMP0eYHJCJxgRxj/grOq3kV2VwPqRMu6SRSc/4b1PU6WxhcSPw62gjw9h25JJHHjXqJpuXZKXEGOo5R6OBCcfzBPuX/2XHYsryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3I0Cd5H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3I0Cd5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709587018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZVEozivbfPbjRB8m5ztbjFg+sHf1PJf7fomGuA6a2I=;
	b=G3I0Cd5HdMq25GkIK6AeDCO2Dj6RcK0m9l4HQOBBJWjkRSpt9rBNTkZcZdBG3JKInZIcD6
	8GdMSwRKNJZ5qRkRyu1NXAoD3q0SWDv8dBluF4G5kj1PAUfYYVmXZ8q2VsxCBOz3rwZIzG
	W8iuRXqstYKvlxLDS/MjcEXJqNQcZYA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-1WjKgdkkPEWJvh7EqOjJ7Q-1; Mon,
 04 Mar 2024 16:16:56 -0500
X-MC-Unique: 1WjKgdkkPEWJvh7EqOjJ7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82EF8386A0AA
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:56 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C8E8C185C1;
	Mon,  4 Mar 2024 21:16:56 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH 0/5] rteval: Fixes and speedups
Date: Mon,  4 Mar 2024 15:16:50 -0600
Message-ID: <20240304211655.20174-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Apart from the first patch, these are mainly motivated by a desire to
make development on rteval more pleasant.  With these patches, a one
second testing run takes around 14 seconds on my laptop with standard
loads, or around 5 seconds with no loads configured (except stressng
without the enabling options, to prevent the default loads from running).

Crystal Wood (5):
  rteval: default_config_search: Return None on failure
  rteval: kcompile: Fix path lookups in _remove_build_dirs
  rteval: kcompile: Skip mrproper, and re-extract if clean fails
  rteval: Break out of main loop faster on interrupt/stoptime
  rteval: Remove 30 second "settling" period

 rteval/__init__.py               | 15 +++++------
 rteval/modules/loads/kcompile.py | 45 ++++++++++++++------------------
 rteval/rtevalConfig.py           |  2 +-
 3 files changed, 27 insertions(+), 35 deletions(-)

-- 
2.43.0

