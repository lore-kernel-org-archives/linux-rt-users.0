Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A253A262
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Mar 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716236; cv=none; b=Y8OtaDRqPRn5Hi/CoqzeNqC/RyZM4Hq47IhOo5idzfZtLuxL7JQklmNQzQGAucF6BUkuKN0U5DRCL1l0CwlyUkOSNbJL0y4F1xgNVSubRWiRupxpeuZXvbMnJ/G/YbNSKHYVcW2H3Ihw4sjKi2GyCke7opfJtbweoHyjgkJ02D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716236; c=relaxed/simple;
	bh=itMY1tVTeY04lYiqRiJfDdzBTJw+pOAUVdpqCYQtsHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfED4mmeVGLGvRqV+Xbp0HIbqqvSi77RMgfZeo9U9sHxwJyGpMiURP5Xps9MuldHmUhFe45edfEOmw6aSj+104wjLXkU/PPfVHvTfS+7tpYckI/JdjSSabTZl5BwQ8f4JAtmpmFyEiu48BAP0YqTKyFGmxbOSovM1/nx7Lva8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ejhr2RDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ejhr2RDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709716233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bHccx0Ktyc5dEbdIo+OQL01HWiZC4ffGfKY1iYVDkbQ=;
	b=Ejhr2RDy2Xlq1bSM6TQCGsywo/u2C9Cd+McX142i2Ohs8ddmq9s2OgkE4tVpwTSaSHD0e5
	bDDYnqiexJ2BDpoJxYKW/1rfTOnjR5YC0EgXgcRaRGY9tZnyC+iQfLhJyui5HkX3x7h/Lz
	Kpe7lXEdp1icxBo/yiFN2wB7NJLsdl4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-iojlGIN5MuS2nejo8gXilw-1; Wed,
 06 Mar 2024 04:10:31 -0500
X-MC-Unique: iojlGIN5MuS2nejo8gXilw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A370E2802267
	for <linux-rt-users@vger.kernel.org>; Wed,  6 Mar 2024 09:10:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.180])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C272B492BFA;
	Wed,  6 Mar 2024 09:10:30 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Add relative cpulists for loads
Date: Wed,  6 Mar 2024 10:07:22 +0100
Message-ID: <20240306090722.147221-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Tomas Glozar <tglozar@redhat.com>

Relative cpulists were added for measurements in 64ce7848 ("rteval: Add
relative cpulists for measurements").

Add support for relative cpulists also for loads. This works the same
way as for measurements using parse_cpulist_from_config, only difference
is there is no --loads-run-on-isolcpus option.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval-cmd | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index a5e8746..8572022 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -340,28 +340,29 @@ if __name__ == '__main__':
         ldcfg = config.GetSection('loads')
         msrcfg = config.GetSection('measurement')
         msrcfg_cpulist_present = msrcfg.cpulist != ""
-        # Parse measurement cpulist using parse_cpulist_from_config to account for run-on-isolcpus
+        ldcfg_cpulist_present = ldcfg.cpulist != ""
+        # Parse cpulists using parse_cpulist_from_config to account for run-on-isolcpus
         # and relative cpusets
         cpulist = parse_cpulist_from_config(msrcfg.cpulist, msrcfg.run_on_isolcpus)
         if msrcfg_cpulist_present and not cpulist_utils.is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
             logger.log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
         msrcfg.cpulist = collapse_cpulist(cpulist)
-        if ldcfg.cpulist:
-            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
+        cpulist = parse_cpulist_from_config(ldcfg.cpulist, run_on_isolcpus=False)
+        ldcfg.cpulist = collapse_cpulist(cpulist)
         # if we only specified one set of cpus (loads or measurement)
         # default the other to the inverse of the specified list
-        if not ldcfg.cpulist and msrcfg_cpulist_present:
+        if not ldcfg_cpulist_present and msrcfg_cpulist_present:
             tmplist = expand_cpulist(msrcfg.cpulist)
             tmplist = SysTopology().invert_cpulist(tmplist)
             tmplist = cpulist_utils.online_cpulist(tmplist)
             ldcfg.cpulist = collapse_cpulist(tmplist)
-        if not msrcfg_cpulist_present and ldcfg.cpulist:
+        if not msrcfg_cpulist_present and ldcfg_cpulist_present:
             tmplist = expand_cpulist(ldcfg.cpulist)
             tmplist = SysTopology().invert_cpulist(tmplist)
             tmplist = cpulist_utils.online_cpulist(tmplist)
             msrcfg.cpulist = collapse_cpulist(tmplist)
 
-        if ldcfg.cpulist:
+        if ldcfg_cpulist_present:
             logger.log(Log.DEBUG, f"loads cpulist: {ldcfg.cpulist}")
         # if --onlyload is specified msrcfg.cpulist is unused
         if msrcfg_cpulist_present and not rtevcfg.onlyload:
-- 
2.44.0

