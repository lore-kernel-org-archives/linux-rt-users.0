Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD42003D3
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498333; cv=none; b=Iy70lUBgL7JegQL5uFQ6tGSunhCTJLZXwAtkT4fvpXuYjiFvyOHUyVedqpjgM2wHYBbdOSi4waMSRFVoQ4SBCUWqGoxpaC+weJiTxp9io8QzB+SX8dwKr8dCvXyf3Iucftl8/QPlOFCEecFoVTPNVYFtEc/nOc1yYs4Pv/an0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498333; c=relaxed/simple;
	bh=+s0VVJIPXENwxTz6yiZN7Z9zGBzmh0F0yhtqdzQQF3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBLbDs/mGn9wIJSXUs4kvJ+hdV6zsg+TtFLZLNVWW3i3yZ3CGJts3WRzXT83AjgsJ/jV+Aw8zwHgXUZyWD2VnomvR4WLIap6awYUFkmvEPdagzhzILmOu49sHL36IErKaBmi7uVvr7JSEaRcSsPB1QAjTsxUkJ3iOq+o54M01mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5XQIP4T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5XQIP4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731498330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwveC9ZcnnF0LAnSrrGRa8JQnDGnMvW98kScPPxaqH8=;
	b=B5XQIP4TITWC90LelUcX4RmVuThmzCv4MXmeQ4T8K9dh4zSHYos3jvqEtNoj/cEQmAFCUx
	qOfYEMT342ZnS6LuIQyk/GSOATLQf+RAbe1Ani8zbUYZexygaXUe4wedqicUmMUwg74hCY
	w9aS5+hO8+mIGctCR89FyQ7U2T0ZhcY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-gDiFjhS_PiKSFI12-9zUmg-1; Wed,
 13 Nov 2024 06:45:29 -0500
X-MC-Unique: gDiFjhS_PiKSFI12-9zUmg-1
X-Mimecast-MFC-AGG-ID: gDiFjhS_PiKSFI12-9zUmg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 531B5195395C
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Nov 2024 11:45:28 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E514419560A3;
	Wed, 13 Nov 2024 11:45:26 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	williams@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 3/3] rt-tests: cyclictest: Add --deepest-idle-state to manpage
Date: Wed, 13 Nov 2024 12:45:09 +0100
Message-ID: <20241113114509.1058593-4-tglozar@redhat.com>
In-Reply-To: <20241113114509.1058593-1-tglozar@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Tomas Glozar <tglozar@redhat.com>

Update manpage with the --deepest-idle-state option.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 src/cyclictest/cyclictest.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 2ccdfc1..6becd19 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -60,6 +60,9 @@ select clock
 .br
 1 = CLOCK_REALTIME
 .TP
+.B \-\-deepest\-idle\-state=n
+Reduce exit from idle latency by limiting idle state up to n on used cpus (-1 disables all idle states). Power management is not suppresed on other cpus.
+.TP
 .B \-\-default\-system
 Don't attempt to tune the system from cyclictest. Power management is not suppressed. This might give poorer results, but will allow you to discover if you need to tune the system.
 .TP
-- 
2.47.0

