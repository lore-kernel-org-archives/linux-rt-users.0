Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D211C6AB
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587022; cv=none; b=NVW6jHgCmDtZXIjvIR+TJVXbpZVlsJSl28/MEZvnk4xx7td0XntjI/XR5NpaW4uDmNKYnUqL1vtqDfSgem1pmJiVr075mqDRFqZtg0gnflBgpldrcFvKQWHgK9nLgG7WALNYLBXtVa2HvCISEsQGxjgSvM8cWY5ron9vKlO8GNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587022; c=relaxed/simple;
	bh=6u4bYi66EpqtJVfGAEsOtHbjFWhPEmsaPKO7W5NPq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay1AWWENISSsnRBnoDRSuGKqNqXtdXpPiCwigIc92kGhI+6DoD4Jti2RBT3E5x/TGuL0ajcP0wS1eO/9WMtC4YOqgLYSHHrmWrfj/S8sRi4H1+QM5No0SXcwBgURwX8vyMUjxAV0YQSAtFnrC5UNp6rjzt6EozeoehD2jW6tWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddHrBeNs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddHrBeNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709587020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTyiSh6xED5lK0+1SnDSYcpOt7/tJzJITOQf8DXLxew=;
	b=ddHrBeNsFFICl4cJKSrCjWsQgG9DLF3CnGiHsyOFbOhc2QJs7YIdCB9cmdTjVxZpMZ/mbI
	PgYszINWw0sh3IiVOJtEkLgPth4pBda9w0gHVXO9X17MwyvpLpuXxYrZFROrGeIAhmz4J6
	xvVDXw8BjnXYdommOozarJC6iXtbshA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-SNIlLbKHNFyypGBX-yn1Cw-1; Mon, 04 Mar 2024 16:16:58 -0500
X-MC-Unique: SNIlLbKHNFyypGBX-yn1Cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D81D83B82C
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:58 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15877C185C4;
	Mon,  4 Mar 2024 21:16:58 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 4/5] rteval: Break out of main loop faster on interrupt/stoptime
Date: Mon,  4 Mar 2024 15:16:54 -0600
Message-ID: <20240304211655.20174-5-crwood@redhat.com>
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

Waiting up to a full minute for rteval to stop on ctrl-c can be
frustrating.  Likewise, if a very short run is requested
(e.g. for testing rteval itself) rounding it up to a minute is
not polite.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/__init__.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 5d43615af5bb..72e3412a860e 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -32,12 +32,11 @@ RTEVAL_VERSION = version.RTEVAL_VERSION
 
 earlystop = False
 
-stopsig_received = False
+stopsig = threading.Event()
 def sig_handler(signum, frame):
     """ Handle SIGINT (CTRL + C) or SIGTERM (Termination signal) """
     if signum in (signal.SIGINT, signal.SIGTERM):
-        global stopsig_received
-        stopsig_received = True
+        stopsig.set()
         print("*** stop signal received - stopping rteval run ***")
     else:
         raise RuntimeError(f"SIGNAL received! ({signum})")
@@ -208,8 +207,8 @@ class RtEval(rtevalReport):
             currtime = time.time()
             rpttime = currtime + report_interval
             load_avg_checked = 5
-            while (currtime <= stoptime) and not stopsig_received:
-                time.sleep(60.0)
+            while (currtime <= stoptime) and not stopsig.is_set():
+                stopsig.wait(min(stoptime - currtime, 60.0))
                 if not measure_profile.isAlive():
                     stoptime = currtime
                     earlystop = True
@@ -238,7 +237,7 @@ class RtEval(rtevalReport):
             signal.signal(signal.SIGTERM, signal.SIG_DFL)
 
         except RuntimeError as err:
-            if not stopsig_received:
+            if not stopsig.is_set():
                 raise RuntimeError(f"appeared during measurement: {err}")
 
         finally:
-- 
2.43.0

