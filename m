Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC10113AD25
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Jun 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670467; cv=none; b=e9YXzRMzJpYUweI4tIQtb2NF8obAbuqZ8sAoMB/D81JWhBiZyZoz37aC8fWBX2gOr4wG5uOqcrktfF+X3ZaorxDjSVBuT2ExCvIm7f/nLPTDXreot35rJVW2+Tdlj9e38HvaUH3kbQb43SCh67pQrbXahsr+mYiHisSn6k0QyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670467; c=relaxed/simple;
	bh=rFnWL/RaDOSTQkU6hQMVaQbc3DQjAhLEEQ/wT/CeQ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4eddlQiSTroJn52K0FPfgrcCKHBfxIdPZu2+TW3Lq0oSAxOfKVJ/NcpmAa9EBhz6rVG65JvDMd2LcCKCuBdvTCHyhSnLf7FPWZh8TbmEkuD+GiPIP8WnHvqlLbkhrFftVM7wd5DvgdmO/x1jA1c9x9VIw2tJklytbpz90OETP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGuWhu4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGuWhu4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717670464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2XvwsXv15KZt+yYJPRqVKhNXNiIwPceVEcHYwpVWDxY=;
	b=iGuWhu4Hal+3bHC49CdtkvH9Jdu3L5sEecXmnXWzLYenOBaPHLiZl0Oq5er3eipX7KiLSM
	8a+Ak2QYVzLQzgvFPNXDe1wOSRyaVAtfhyWuXQ67vEaTRN6aYkvemNREfJjAWZZb83/TEB
	Gl4z1XTlcN5PyR7RjaXPW8JWaSeCSN0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-9zfg4BoNOZucFKhuYAhL0w-1; Thu,
 06 Jun 2024 06:41:02 -0400
X-MC-Unique: 9zfg4BoNOZucFKhuYAhL0w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 047271944D3C
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Jun 2024 10:41:02 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.68])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C22261955E87;
	Thu,  6 Jun 2024 10:41:00 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Avoid passing None cpulist to measurement
Date: Thu,  6 Jun 2024 12:40:54 +0200
Message-ID: <20240606104054.111997-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Tomas Glozar <tglozar@redhat.com>

When rteval is called via the command line, cpulists for both
measurements and loads default to an empty string and are further
processed by parse_cpulist_from_config. However, this is not true when
rteval is used as a module: in that case, neither the default
command-line value is used nor parse_cpulist_from_config is run, leading
to None being set to the config property of measurements which is
explicitely passed down to the corresponding cyclictest config property.

The issue was introduced in 64ce7848dfab ("rteval: Add relative cpulists
for measurements"), where the check for None was removed from
the cyclictest module, assuming the value was processed by
parse_cpulist_from_config.

Avoid this by calling parse_cpulist_from_config with an empty string to
get the default cpulist to pass to cyclictest module if cpulist is empty
in the measurement config.

Note: this is a workaround, in the future, parse_cpulist_from_config
will be called properly in one place only instead of being scattered
throughout the code of rteval. That will also enable relative cpulists
to be used when calling rteval as a module.

Fixes: 64ce7848dfab ("rteval: Add relative cpulists for measurements")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/measurement/__init__.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 11bd7b0..fda618d 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -148,6 +148,13 @@ measurement profiles, based on their characteristics"""
         modcfg = self.__cfg.GetSection("measurement")
         cpulist = modcfg.cpulist
         run_on_isolcpus = modcfg.run_on_isolcpus
+        if cpulist is None:
+            # Avoid passing None cpulist down to measurement module which might
+            # not expect it
+            # Note: None can appear only when using rteval as module, not when
+            # being called from command line; in the latter, cpulists are all
+            # processed by parse_cpulist_from_config already by this point
+            cpulist = cpulist_utils.collapse_cpulist(parse_cpulist_from_config("", run_on_isolcpus))
 
         for (modname, modtype) in modcfg:
             if isinstance(modtype, str) and modtype.lower() == 'module':  # Only 'module' will be supported (ds)
-- 
2.45.0

