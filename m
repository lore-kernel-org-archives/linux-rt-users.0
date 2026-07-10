Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15741166B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690755; cv=none; b=g4laZCOn6BQi3wewEvGORE+/Nev5FmJ1UR4UMmoe0MgzOX3iXLvfOgWji8ZW0fRRIAxHbuDqpzO66Qh1bZS0jPXJ1XFCxzYksfszRROmn/uU22dSwBiCzf+q3/tuP+xCHV//C53Br3nhb8yTYYKJfCyxoQyC3jJeGWbO8fBP6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690755; c=relaxed/simple;
	bh=mak1QVpjxTm4ahONOPcwQ9ehbB/5YJsAsar9W1HfC2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Novrz86GjqejEIbPMmHKlDRafDULicwn1eHT/KXp+tv5DH3J50mtrEE/enogerxrtiRaTacydjCAP8lRD98XXeAa+Eb3m8dvGxrXxMd7XYg2DP6qS6WSh6sh6IaSBfpFAyS6ZWr9EEzzIopWf1AdCgItodepy9p/xCezs1GQnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGmfWQDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGmfWQDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783690751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbRsKaSuFm1TlsfpUl6w6aX21ijlezloRiqYannEDsI=;
	b=LGmfWQDyJQUnrJHoUWMY1aJOHl12h5BQIfpwjOMLDqUJ+XePhZcA8WLoUfxj8C5ZOA8Vzo
	EnrNIsJYaWyx8wxsQwzhLNqn7km1wnNWnLYshdfvsWXg9+MvC3w2pywgOSxxZTVGB9FT0d
	367SNPkrtI6zHExcwNB8fhiCUH/Gyhk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-mFucx2T8MWmy_AjJUvY6gw-1; Fri,
 10 Jul 2026 09:39:10 -0400
X-MC-Unique: mFucx2T8MWmy_AjJUvY6gw-1
X-Mimecast-MFC-AGG-ID: mFucx2T8MWmy_AjJUvY6gw_1783690749
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 202E01955F15;
	Fri, 10 Jul 2026 13:39:09 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB595195608E;
	Fri, 10 Jul 2026 13:39:06 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: williams@redhat.com,
	jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
Cc: juri.lelli@redhat.com,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 07/11] tests: dump log contents on assert_log_contains failure
Date: Fri, 10 Jul 2026 10:38:06 -0300
Message-ID: <20260710133810.72398-8-wander@redhat.com>
In-Reply-To: <20260710133810.72398-1-wander@redhat.com>
References: <20260710133810.72398-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

assert_starvation_detected and assert_boost_detected already dump the
log file before calling fail, but assert_log_contains does not, making
failures harder to diagnose in CI.  Add the same log-dump pattern so
the file contents appear in the output on any assertion failure.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tests/helpers/test_helpers.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/helpers/test_helpers.sh b/tests/helpers/test_helpers.sh
index 20937a3..a2db0a9 100755
--- a/tests/helpers/test_helpers.sh
+++ b/tests/helpers/test_helpers.sh
@@ -209,6 +209,8 @@ assert_log_contains() {
 		else
 			log "    Pattern '${pattern}' not found in ${log_file}"
 		fi
+		log "Log contents:"
+		cat "${log_file}"
 		fail "${message}"
 	fi
 }
-- 
2.55.0

