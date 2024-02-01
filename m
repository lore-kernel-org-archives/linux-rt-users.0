Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B67C6D1
	for <linux-rt-users@vger.kernel.org>; Thu,  1 Feb 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809880; cv=none; b=NvaRhdECW25s+95wdrLQFrVMl27YUQC3qbcotBMs5+/69N8CRuA2+q0zY6ZnvFakeox2leb7Pf1xwn6a9FkLniE4HpcbdvSh2r6OR/9IeZz+zL7QKHmEpO87NKBScHYd2DfCsrtYMEmhPkccTuhOOgpav4X8hqmnNjFALodq1v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809880; c=relaxed/simple;
	bh=bd+L7G8WbdDLqBCXceGLnJfHplcDRhMOxjw2E86wrds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BAHkLjqvQI9dxIhmA0EtRyzf1iJbMZBvADV058zDXoN1DOUWeX3Bg2fDivXCBdrThkggJaq0gbt7bJoGZW8UEiC9JoSNhEJ4L1bRZvNupJCIuL6Hf6OHvhy0SoosHHw1/2eU71KZTvPLBGU0T98xM4ucf3MILKAjH9CWlV/EHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ngmp0qg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ngmp0qg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706809877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bbBw+oolO7+LyFRr9J8IGScnob6tdzOJdyauROTPVXg=;
	b=Ngmp0qg2DPJ9TJPXmk+xaydWJdPdVFYCkmzSsrCqxZSmd86smdcysZTJ3cqGFOIXCB8HsV
	CN/QckAMsK4Dcc9Nh8bUFszjoPenW8z88rCciXX69ReNc6O0yfhqeegGz9HIA+F50/qG38
	Bnq1yu0Vq5wJoM9aHvN1o2nfN5FkyfM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-KBKoj7yFMqep9fZbAxIC2Q-1; Thu,
 01 Feb 2024 12:51:16 -0500
X-MC-Unique: KBKoj7yFMqep9fZbAxIC2Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFBD13C11A03;
	Thu,  1 Feb 2024 17:51:15 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 78DB43C2E;
	Thu,  1 Feb 2024 17:51:15 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 6C48A426A2C87; Thu,  1 Feb 2024 14:50:54 -0300 (-03)
Date: Thu, 1 Feb 2024 14:50:54 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Chuck Newman <chuck.newman@hpe.com>, John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: oslat: convert to nanoseconds correctly
Message-ID: <ZbvZ/l9zKjU8Frvy@tpad>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


With buckets of size 1us, accounting for measurements in the
[1ns, 999ns] range are done to the 2us bucket (while they 
should be accounted in the 1us bucket):

    001 (us):	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    002 (us):	41916187 41937649 41938461 42029055 ...
    003 (us):	969 985 958 972 964 986 970 961 973 ...

Fix this by doing a plain cycles -> nanoseconds convertion:

    001 (us):	43287555 43086678 43087427 43109974 ...
    002 (us):	983 987 985 975 982 960 993 961 992 ...
    003 (us):	9 6 7 13 9 22 3 21 3 3 8 8 10 11 3 55


Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Reported-by: Chuck Newman <chuck.newman@hpe.com>

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 4bdca64..13e887d 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -334,7 +334,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
 	uint64_t extra;
 	double us;
 
-	lat = (value * g.unit_per_us + t->counter_mhz - 1) / t->counter_mhz;
+	lat = (value * g.unit_per_us) / t->counter_mhz;
 	us = (double)lat / g.unit_per_us;
 	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
 		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n";

