Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07DD1C680
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587021; cv=none; b=iIQObSdmrkHT5LEytXgaAU79siSUCCBQasnumuTbeWoNsr9HIZ6a+dzzO3tG03YwlgMQU2g+ktrUgt8stDRHFGxEc2N/zY20eElImN1sCJrI+WbA6Cl0Xgp2Z2JkB+3AJWpmH1SkB5Bl3Q4RYkVF7vwRptVXawTsk/9konLnNQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587021; c=relaxed/simple;
	bh=jEuY/3ck8v+1Hm7T4GuvHEq2zZ8VKFpPPyUCO0Hm2jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Br7LE3gMZKM93YcS+v7yp3ZMuC7l+chXZ31euVi0K7L95mxsMshPo945+S+csxuhvuVjABnBWxvV9UGfaUcugQTz2OFYz8NDUvibXq/qsxLp0zyfLxJAWWL4f7oHOOJOqAOXsrfzdzX6ptUfKGjFWGwy4RfoxXFFQgN7tL182ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAr+a8o8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAr+a8o8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709587019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/Nr4O9GMGjvDWMvuENkLm9jMH0tOPerFOKerhozOC8=;
	b=FAr+a8o8DGpfXkyXkuQkTleQSOMBkZg/8IrcJ1kUhFoNVLb7oE7aybhaI5AV4dLJ459PcG
	iYaZDpMOC42fZefMHDdJ0kXaJNDZ6/56zXxlPI/ccZRy2Fna8mbNg05AvtJVpVVG5G+N8B
	Unm9z6tPmUTi9W5ARoSslPe2v7MgHZE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-saPJ16IDPpecR8iBYQqgUw-1; Mon,
 04 Mar 2024 16:16:57 -0500
X-MC-Unique: saPJ16IDPpecR8iBYQqgUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02FA5386A0A3
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:57 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F419C185C4;
	Mon,  4 Mar 2024 21:16:56 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 1/5] rteval: default_config_search: Return None on failure
Date: Mon,  4 Mar 2024 15:16:51 -0600
Message-ID: <20240304211655.20174-2-crwood@redhat.com>
In-Reply-To: <20240304211655.20174-1-crwood@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

If False is used without checking, it will be interpreted as stdin,
hanging rteval waiting for input.  OTOH, None will cause os.path.exists()
to throw an exception, so we need to check both the name and the existence
separately anyway.  However, this is a better failure mode than hanging
on stdin if the user of the filename fails to check both.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
I found this by trying to use "make install", which fails to install the
XSL files... apparently data_files is deprecated.
---
 rteval/__init__.py     | 2 +-
 rteval/rtevalConfig.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index ca018f6fd8b8..5d43615af5bb 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -76,7 +76,7 @@ class RtEval(rtevalReport):
         else:
             self.__mailer = None
 
-        if not os.path.exists(self.__rtevcfg.xslt_report):
+        if not self.__rtevcfg.xslt_report or not os.path.exists(self.__rtevcfg.xslt_report):
             raise RuntimeError(f"can't find XSL template ({self.__rtevcfg.xslt_report})!")
 
         # Add rteval directory into module search path
diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index 030d4205efab..e62da25119a6 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -46,7 +46,7 @@ def default_config_search(relative_path, verifdef=os.path.isdir):
             if verifdef(os.path.join(path, *relative_path)):
                 return os.path.join(path, *relative_path)
 
-    return False
+    return None
 
 
 # HACK: A temporary hack to try to figure out where the install dir is.
-- 
2.43.0

