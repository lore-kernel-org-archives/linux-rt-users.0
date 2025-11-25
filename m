Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC027286889
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764068577; cv=none; b=feoGQ/R2or6sKR1qP+SRwPuH/ZQG5BO3nSOq/vQVwvbegqgPjFFv25/ZOqpywZbZwFIo8M2QVSrNg0Jh6Io/7l8AZ/PD5H6l1+MLxtqLhSDUDv1av7HadmlFHdwOfW1XDFmaG6kpEXUZdKXlqgvVE6/REsb0QmRLSDP5XlFeN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764068577; c=relaxed/simple;
	bh=wmIV/fmz62Ab3/o05DRcBWYoMt8z9Tpku5JVRCVvnIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2+KmQ0XgfIxZTqpxgpp85J6mkN7OqG0FT2oa+q23LN7zXNsqiJGzKWO0yHTTZJHlE2U76X/WNv+JoGmgKwFNjpTGMQkkjrFWAUTRNrBGSGAz+KX3BaIy8Pt6hqPR9WvBhPmTc97RvxHvOltlXY9gnzcp0fm+gQmFIpiQeuoXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asO0MHtO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asO0MHtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764068573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6PuQu6QFsjfsqoHwFRlVcvD7saAeIZqfDipVsr2E/j0=;
	b=asO0MHtOCWrnVAXTQJ1jVo75X/hVjOXlHWRvc5WGvIGRzsJe64E9GzYkAVfvw7xlQyF8Qo
	uS0SEEuxE0EIc+VOt7hgWnW1oW6Iz3kIJlksOurC5PSlgq2vlusYId9XdJlrP4z8ZZr35s
	cUT8BTW75Gro9WrvhVmT9lNOc32WsGg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-hkHWFOLXNAqXaY4QDehmoA-1; Tue,
 25 Nov 2025 06:02:51 -0500
X-MC-Unique: hkHWFOLXNAqXaY4QDehmoA-1
X-Mimecast-MFC-AGG-ID: hkHWFOLXNAqXaY4QDehmoA_1764068571
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20C9C1954B0B
	for <linux-rt-users@vger.kernel.org>; Tue, 25 Nov 2025 11:02:51 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.228])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C97EC19560B2;
	Tue, 25 Nov 2025 11:02:49 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/2] rteval: Move unittest.py to tests/unittest-legacy.py
Date: Tue, 25 Nov 2025 12:02:38 +0100
Message-ID: <20251125110241.277542-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We now have a tests/ folder. Move unittest.py there, rename it to
unittest-legacy.py to prevent conflict with Python's unittest
module, and remove the now empty directory unit-tests/.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
This is a follow-up to [1], in place of patch 2 and 3. Patch 1 got applied,
patches 2 and 3 required changes following the merging of [2].

[1] https://lore.kernel.org/linux-rt-users/20251107134749.257350-1-tglozar@redhat.com/T/
[2] https://lore.kernel.org/linux-rt-users/20251107182645.19545-1-jkacur@redhat.com/T/

 unit-tests/unittest.py => tests/unittest-legacy.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename unit-tests/unittest.py => tests/unittest-legacy.py (100%)

diff --git a/unit-tests/unittest.py b/tests/unittest-legacy.py
similarity index 100%
rename from unit-tests/unittest.py
rename to tests/unittest-legacy.py
-- 
2.51.1

