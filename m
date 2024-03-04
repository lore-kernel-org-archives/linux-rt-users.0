Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBC1EB3C
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587023; cv=none; b=TM7NbbL0Ovf1+BqW6JGa2m21l/Copoq0986UuvV2VqdWISNoS/zcz4MFrX99vTIAt+HxIUSpjdugUs0S1TK3TOGu6EloW6ex+jjaRhg+3NAjVq4dISjn1F09J9JQMaKyWUaMRxu5QZbnDPD9/yX/pdRbJss7HYEo2vk2g3rTMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587023; c=relaxed/simple;
	bh=BByDr97fyzS6ATSAcsqmR0lK4061B0mRb4GkgByzlvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW1UI7fG6/L0tPpN8hTlQ5EBiT56oICpYHqurdKRUAw/nExzo9KhGN8cYzC/5MIOxA78XIb3U8r11xU2cRzOaTlcmuVcRABMV//11xHpXqPZvlxkcJoVm2NC0IajqRP2qSDKefXxjgcROFw/CX7kEoIlQt6jPzgXMa19bMU/fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBROIf1I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBROIf1I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709587020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5Wo0vp+4CitWwyz9OXjz3lSnHN+VdmA+STzQB+2+90=;
	b=YBROIf1IXfnarcMkPPHZulH1PK11gEPyIhNf9O91KxrtnuBqJMW3+anoBmnqUDJ7YBJdx/
	5Im102Qm2+UOV7/VismcPu2QzRRNci5s4gVTbW5PPXlUglH5PdA8aV0aMVoCE9xHKkI6Ja
	lUu9XCj5Thva+nDLYJxF0jC7A6dqkLs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-60Ai9ItjNG6rIiHKngijXw-1; Mon,
 04 Mar 2024 16:16:59 -0500
X-MC-Unique: 60Ai9ItjNG6rIiHKngijXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1D5F386A0A8
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:58 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8A20FC03380;
	Mon,  4 Mar 2024 21:16:58 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 5/5] rteval: Remove 30 second "settling" period
Date: Mon,  4 Mar 2024 15:16:55 -0600
Message-ID: <20240304211655.20174-6-crwood@redhat.com>
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

Waiting for 30 seconds for loads to "settle down" adds unneccesary delay
to very short runs, besides being a giant hack.  Load modules already
have the opportunity to do setup beforehand.

Even if there are a few seconds before the loads get to their expected
"heaviness", that shouldn't meaningfully affect the output except for:
 - very short runs where you either
   - don't care about the latency because you're debugging rteval itself, or
   - are debugging a latency that reliably shows quickly, in which case
     consistent behavior is enough
 - latency spikes that only show up during load startup activity, in
   which case measuring it is a good thing
 - minimum latency values, which are not really the point of rteval.

...and the 30 second delay is *especially* useless if loads are disabled.
Currently there's no official way to do that (as far as I can find), but
it can be done by disabling all but stressng in the conf file, and not
supplying stressng options on the command line.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/__init__.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 72e3412a860e..2c1dc1a7a22c 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -194,8 +194,6 @@ class RtEval(rtevalReport):
                 nthreads = threading.active_count()
             else:
                 nthreads = None
-            self.__logger.log(Log.INFO, "Waiting 30 seconds to let load modules settle down")
-            time.sleep(30)
             measure_profile.Unleash()
             measure_start = datetime.now()
 
-- 
2.43.0

