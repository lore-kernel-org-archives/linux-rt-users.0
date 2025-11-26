Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD418CC13
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198754; cv=none; b=CHeTWML+3NZMmWV6k/ghhAgrF6xipjskpW2/At+gI7SF+NIR+qSJklIHdaFefne1bSaaYmiky/hBOCb/PepJOFfD/37T5byz6reQcQXtnqNTm5TZiB/dOwsDFKPPZkD64WAEaW6MVM6jdCt/7J+vilsebSTP5+P/0fNpa+3FWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198754; c=relaxed/simple;
	bh=qe/CQCbSZKyIM6v3ktS9JP1znHz3nYQergRjY9nLlCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MBiHCl/Q3tUkU1c/fG++cUgR74211ehLYT9dUhS6sR2q7Re2bEnEfLKR3yhQuvsRdFkLjQZrKhVitCAVMBylU9Cxyb/+dj40tBBc3p7EAPJFRw3FDFIyWfIOQPKZyrHxvGdnsruDYUw7ElTrBO3i2wjbWkUyy+ZofqZOBrP6SIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwWbwofN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwWbwofN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764198751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tWgkyCjTXh4lgScoF96EyIwk635hQiyrY0o0PL7nqBQ=;
	b=VwWbwofN7MfvUGI/yn+Tklb90MwxR7mzdpOyZTLf0DPO0TVFCtNViz1NgrZZUt7Eks2iqW
	w112kKM3kCdOW+sfl54amvQaDq3vMun4xfTLnjhN6OlmUziA+5c121gZAvkGlGeQvhHwpw
	XZEbg94AMMBCvSVOmAsA3gTtlFV1iCM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-q8oME8zMPfyM_gkGSUFGhw-1; Wed,
 26 Nov 2025 18:12:29 -0500
X-MC-Unique: q8oME8zMPfyM_gkGSUFGhw-1
X-Mimecast-MFC-AGG-ID: q8oME8zMPfyM_gkGSUFGhw_1764198749
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D2541800343
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 23:12:29 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.22.64.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A35071956056
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Nov 2025 23:12:28 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH] rteval: do not require wheel for building
Date: Wed, 26 Nov 2025 18:12:12 -0500
Message-ID: <20251126231223.100316-1-yselkowi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Setuptools 70.1+ does not need wheel at all; older versions would fetch
wheel when building wheels (but not sdists).

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
See also: https://github.com/fedora-eln/eln/issues/284

 pyproject.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pyproject.toml b/pyproject.toml
index 9fc681f..4ea8a78 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -1,5 +1,5 @@
 [build-system]
-requires = ["setuptools>=61.0", "wheel"]
+requires = ["setuptools>=61.0"]
 build-backend = "setuptools.build_meta"
 
 [project]
-- 
2.51.1

