Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637E258CE7
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532272; cv=none; b=YWDZFxXLyiPvBHDBLFqTslaCzzKH/43ZTNse7Kz1H3Q3WcFQQ5a1f65c8G1pPIS5h7A1gq9HTrNya3aDv6XjM15ioNAhpLWUe4lkgjw3yeH02IU+/RUrx3z/zQzkpm00IBjRbANl46uI6+1VWlSKYG8ZZo/Dpfgpt5pDu8ltp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532272; c=relaxed/simple;
	bh=/4y3qEN+mWeuWz5F16zCHdPXOz2yXWXv6TQfcViDxos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/gHJp3L4U8sM7IBFd4kOjn3hUF0FFRc7twXHHPzuZdiwFyxK+/5UWnvVqUNwNjzNV4nTxXpwO1PGw9zc1aZRDviyVSknuOlVma0XL8/2ExJg4zRyfY0ms15ge8K+ebfvA2QQ5alTxCnKxdNfRDhvMqPJ9YAIVtMjkhFkeHtftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUVv+XJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUVv+XJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762532269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wXsAas3GuTEEjWJb/GjALvUrvADHGo0FtAC4xq7Feqw=;
	b=NUVv+XJBg6rTlEBHdq74BLnLVn05HtwczK+Lr1eOgKirkSPNcExpeK3GiXvJXvDWXA3nn/
	+zYjgzLpvDre2nAOf6ExCq2/kqh19FnNSBOweQ4XG2eOEe39g1yKZQtUvE7twXSQNX8gxn
	+hK+jHc0XmYodyYNKbsSEnCavyYPrhA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-kkfZTBEjPfaWx7ZNtSIhqw-1; Fri,
 07 Nov 2025 11:17:48 -0500
X-MC-Unique: kkfZTBEjPfaWx7ZNtSIhqw-1
X-Mimecast-MFC-AGG-ID: kkfZTBEjPfaWx7ZNtSIhqw_1762532267
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F8AC180035F
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 16:17:47 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC8463001E83;
	Fri,  7 Nov 2025 16:17:45 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 0/3] Improve Makefile robustness and explicitness
Date: Fri,  7 Nov 2025 13:17:25 -0300
Message-ID: <20251107161729.320087-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch series introduces several improvements to the Makefile to
enhance portability and clarity.

The first two patches add checks to conditionally use compiler flags
-mno-omit-leaf-frame-pointer and -fcf-protection, preventing build
failures on systems where they are not supported.

The final patch makes the test invocation explicit, so `make tests`
successfully runs.

Wander Lairson Costa (3):
  Makefile: Conditionally add -mno-omit-leaf-frame-pointer
  Makefile: Improve compiler flag detection for -fcf-protection
  Makefile: Explicitly run the 'test' target in the tests directory

 Makefile | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.51.1

