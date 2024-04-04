Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029C60ED0
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Apr 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218598; cv=none; b=GJoiLtRUyMaMtEN1/pBYAosQuwn2kKblv7ev+3pv4PLV/sjt3TSWYiXUGbtVhH5ZXMhLegJ0PleWZakBuMOtA/vyjV4qRJFPUKcsDViw7VI+GADvkEXa6mz1pNxNqGJSQplpOxJsBeUpva7YfWf6kpf5uhXENUEwBwCr+mIVr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218598; c=relaxed/simple;
	bh=lRBdPeBYerhGFWoTtpXT274qmcriQ/kZMXmugmzc2EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lcpg2exeltKWvhMJfzWuVzeKwxLaarAm3WIy8XLtOr57kXJ6fN/ObhiLYjWU0v4QGOkqaNLNbu73nsOU6WPHHWncmZzN8kpFUkEJby+KCgebM6XkOxbSPoqqWqrj2ER9GKziPy4c66rgl15uty+mLr6TnipdfvCV2rhDpEnRXoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpDr67r8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpDr67r8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712218595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6dyR9e0yp91RsSvxgdpUWwdA/OjsiOSJJzyg3iHDZ9c=;
	b=YpDr67r830l4qRB6/SczFbr1waSlBwIrX0xm/9tb3mws0zYN/FOhmcX/DUZAD5ySE89vE0
	PyZFHgawRROVs47RDyrxiHZvVUvi5b51iQ9RLsq9SP13n1U9qOW+GEAq718RhBWHx8lOWq
	rpl1pzsnOBK7GmasMPpgtzE1RVc5hAo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-9ziYvlt_PAWPmiE7Tz9HlQ-1; Thu,
 04 Apr 2024 04:16:33 -0400
X-MC-Unique: 9ziYvlt_PAWPmiE7Tz9HlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D16253C02718
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Apr 2024 08:16:32 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42C88C017A0;
	Thu,  4 Apr 2024 08:16:32 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] rteval: Add relative cpulists for loads
Date: Thu,  4 Apr 2024 10:14:38 +0200
Message-ID: <20240404081438.252394-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Tomas Glozar <tglozar@redhat.com>

Relative cpulists were added for measurements in 64ce7848 ("rteval: Add
relative cpulists for measurements"). It was observed since that this
feature would also be useful for load cpulists, for example when the
measurements are performed externally and rteval is only used to run
loads.

Add support for relative cpulists also for loads. This works the same
way as for measurements using parse_cpulist_from_config, only difference
is there is no --loads-run-on-isolcpus option. That is, --loads-cpulist
now also takes lists with addition (+) and removal (-) of CPUs against
the default list, e.g. +0,1,-7,8.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval-cmd | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index a5e8746..2ef6cf4 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -339,29 +339,32 @@ if __name__ == '__main__':
 
         ldcfg = config.GetSection('loads')
         msrcfg = config.GetSection('measurement')
+        # Remember if cpulists were explicitly set by the user before running
+        # parse_cpulist_from_config, which generates default value for them
         msrcfg_cpulist_present = msrcfg.cpulist != ""
-        # Parse measurement cpulist using parse_cpulist_from_config to account for run-on-isolcpus
-        # and relative cpusets
+        ldcfg_cpulist_present = ldcfg.cpulist != ""
+        # Parse cpulists using parse_cpulist_from_config to account for
+        # run-on-isolcpus and relative cpusets
         cpulist = parse_cpulist_from_config(msrcfg.cpulist, msrcfg.run_on_isolcpus)
         if msrcfg_cpulist_present and not cpulist_utils.is_relative(msrcfg.cpulist) and msrcfg.run_on_isolcpus:
             logger.log(Log.WARN, "ignoring --measurement-run-on-isolcpus, since cpulist is specified")
         msrcfg.cpulist = collapse_cpulist(cpulist)
-        if ldcfg.cpulist:
-            ldcfg.cpulist = remove_offline(ldcfg.cpulist)
+        cpulist = parse_cpulist_from_config(ldcfg.cpulist)
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

