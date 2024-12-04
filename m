Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7520C02A
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326898; cv=none; b=eoK1u+l4ZrhMNr6ez9/q+9bbwYVwTINcmRqJMajez3FrBmtY9NR7jrHhxHqlvD7xLsI9r0uCiLA7N7A6ZD/5F9G+hWilfViV15kXfdre4l2UPExNG6ljrWKr2Rjpv1AMxQRGhuSnxwutirp9YQv/uWNO2c0FPiY09++/5XlwGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326898; c=relaxed/simple;
	bh=B3Vpn0tEwYnaauWjgLUjZy8GZ6krx5bkMuTdBtbUwb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfGp711ZGlr3niz3yzZBFjcewmwTrclI/noJAYs4mmUOskb+ava52Dq5QXtS7d8lLIkkJ6UbAz7jc3c/0unMQbEk3vPcL870k9M/74xiYrkMqVA8IFzcfnoqUke+PDDQjK96YzlZ0QbGe8ppSBnNK/qJTbVnQ+R0w9CZaMnZ3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVXUfkoD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVXUfkoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733326895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P9GRxxHR7+Snf9vn9D8fCBeieuaWrGc8yxdS+gffBgc=;
	b=YVXUfkoDaLKDdwuvgPdI0dItP+bSkZxuv9Zv7k14eUXb09YKCURSQy5eKUx88TwWR7XkXO
	VRDCWbU6WwTrbzGDGc1KyRhUO9mA0A25YQ1raQECxRJ6pJJx8Fz34ZIMpUgNzacgdOg+22
	acHehyz8L6DyGsEXuADKyw+YobWN2q4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-LxWwChjSNs-5FWo3J_N1OA-1; Wed,
 04 Dec 2024 10:41:32 -0500
X-MC-Unique: LxWwChjSNs-5FWo3J_N1OA-1
X-Mimecast-MFC-AGG-ID: LxWwChjSNs-5FWo3J_N1OA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF9D01955EFD
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Dec 2024 15:40:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 009DC3000239;
	Wed,  4 Dec 2024 15:40:51 +0000 (UTC)
From: tglozar@redhat.com
To: jkacur@redhat.com,
	williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/2] rt-tests: libcpupower feature detection fixes
Date: Wed,  4 Dec 2024 16:40:02 +0100
Message-ID: <20241204154004.560615-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

Two bugs were found while trying to build cyclictest with libcpupower
support inside an RPM build. One bug prevents libcpupower detection
when there are spaces inside OBJDIR, CFLAGS, CPPFLAGS or LDFLAGS,
the other bug breaks linking against libcpupower when LDFLAGS is passed
to make.

Fix both those bugs and unbreak RPM builds with libcpupower support.

Tomas Glozar (2):
  rt-tests: Put variables in test-feature in quotes
  rt-tests: Handle -lcpupower flag outside LDFLAGS

 Makefile                 | 4 ++--
 feature/test-feature.mak | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.47.0

