Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A7BE78
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2024 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117172; cv=none; b=ZVGFU8+Y5EKi7Mvz3k0ZWvEPVovPmqJLzij2ERBCs5eVR5tnfZaLRD80ovVPSAkT4tYbPl1VkDZvWfm+d2o7XTd3w8QPowXhrTpnfTDiGF9Wq2f94KJb92qWiIbz+j/eZamR7B/I9JK0Tru1uOS4bYqTh5cWkxkrHyHdXIQa8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117172; c=relaxed/simple;
	bh=urfvLW7xKZxMBR8qcTGKmCnF4eiFIcb3IEnafBksesg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+9O68eRUsV6bQTEu6Eketzx57KtMnmAG3Fx1hJfbPObu6X8XmEpoYdDNuqzJzbe1ZPlIwPpkjD34Srk+MTfw4QFATqUpJfTGQLCOkG+2f0tH2386B10fpIL9Bvq/UVr1RVUI9bQXRnWu8Aun4vlNWKQC/MhIse8dO1Pb45qTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXk6GPLa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXk6GPLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718117169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jrm6BDNxaQqnkAzyVS6RVtWU11INF6pCjc4mUochorI=;
	b=XXk6GPLa3fpn49Qo+kUW+8S5u/IbcsVngs+chbj9cNo10SI3XTpIsGbL3rkPKH9nDhRcHO
	uEd/dkP3SVIaBHcBqRF5FyQVTshxtjEnshl3y/1FlPJW7N/c0ZS4l0SPUzSy2XPITif6UU
	onq9WNXikNRWdkp+yccytRlvcSBmCls=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-zvrBC0aGPe-gPzUZF7rqdA-1; Tue,
 11 Jun 2024 10:46:08 -0400
X-MC-Unique: zvrBC0aGPe-gPzUZF7rqdA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 929091956096
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Jun 2024 14:46:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.85])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AFF319560AA;
	Tue, 11 Jun 2024 14:46:05 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] rteval: Fix -aNone being passed to cyclictest
Date: Tue, 11 Jun 2024 16:45:53 +0200
Message-ID: <20240611144553.185624-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Tomas Glozar <tglozar@redhat.com>

When rteval is called via the command line, cpulists for both
measurements and loads default to an empty string and are further
processed by parse_cpulist_from_config. However, this is not true when
rteval is used as a module: in that case, neither the default
command-line value is used nor parse_cpulist_from_config is run, leading
to None being set to the config property of measurements which is
explicitely passed down to the corresponding cyclictest config property.

After 64ce7848dfab ("rteval: Add relative cpulists for measurements"),
where the check for None was removed from the cyclictest module, rteval
passes "-aNone" to cyclictest when being used as a module.

Call parse_cpulist_from_config with an empty string to get the default
cpulist to pass to cyclictest module if cpulist is empty in
the measurement config.

Fixes: 64ce7848dfab ("rteval: Add relative cpulists for measurements")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/measurement/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 11bd7b0..43c0fda 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -148,6 +148,9 @@ measurement profiles, based on their characteristics"""
         modcfg = self.__cfg.GetSection("measurement")
         cpulist = modcfg.cpulist
         run_on_isolcpus = modcfg.run_on_isolcpus
+        if cpulist is None:
+            # Get default cpulist value
+            cpulist = cpulist_utils.collapse_cpulist(parse_cpulist_from_config("", run_on_isolcpus))
 
         for (modname, modtype) in modcfg:
             if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
-- 
2.45.0

