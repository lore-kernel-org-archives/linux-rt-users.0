Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266591A3154
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111923; cv=none; b=LTBOZZPt/49+TytYCnoE2DJBD88PhVlimUuunBdoFqV0yxvl3GbFV+OrqMwzISRUX/Usw6xFGf83jaFT7L80Hc7CpD6ff4ouvYSk4J2So2pj+wx/U2ZlfCy4bg+YGNiGrTsQHYYmXnwWVuDI2odVE/cT5xAtEoiaekc68eomB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111923; c=relaxed/simple;
	bh=on8EXEtMNlUzyl7oiNqy45hgThIyD47GivvfyNEpd+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSE5yTPMxk349xIjZUjZbjBpof1syI4gbi6CUN9SUFdeUfl83Jk+I+pYfOUCpYdEKVUCMUWR2gY1YdQLVWPoHpyuG4lUKgLXFpMaNFivqyHbrhx2FuOLOsCHbOoxvGxid+59lep/PhzJr6xJIVreTfSo6D1ZI36vw4r5HIdCajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zct+xcq2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zct+xcq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772111921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ELpuHJLPJPkt3gGzkbX2rhUZ2wDzAkC+JlyXDN+8XY0=;
	b=Zct+xcq2j+/fCo0QFwYWfXp9KPA9Hvym4p5ubRpDbOayuNqOUmF5hsugYHfka/WeNysOeY
	wx5B1YpbVORz1shusJDqmmHwNFj8Hbo12Td/M+tf2MZzgWOGZ0e7WyRMCmjl66LnOZcRsW
	hHTrVBRkjQPBCdn6YqUA6tEOl+cT77c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-Pyp3f9fXPsCEZVEmszqLkg-1; Thu,
 26 Feb 2026 08:18:39 -0500
X-MC-Unique: Pyp3f9fXPsCEZVEmszqLkg-1
X-Mimecast-MFC-AGG-ID: Pyp3f9fXPsCEZVEmszqLkg_1772111919
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED12818003FC
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 13:18:38 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8F0719560B5;
	Thu, 26 Feb 2026 13:18:37 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rt-tests: cyclictest: Fix -A long name in manpage
Date: Thu, 26 Feb 2026 14:18:28 +0100
Message-ID: <20260226131828.234378-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The cyclictest manpage gives the long name for -A option as --align,
however, the proper name in both help message and getopt_long() is
--aligned.

Use the correct name in the manpage.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 src/cyclictest/cyclictest.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 6becd19..ff2cb96 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -17,7 +17,7 @@
 cyclictest \- High resolution test program
 .SH SYNOPSIS
 .SY cyclictest
-.RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
+.RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " aligned " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
 [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
 [\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
 
@@ -47,7 +47,7 @@ field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets
 * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,
 if specified, must be a single CPU number.
 .TP
-.B \-A, \-\-align=USEC
+.B \-A, \-\-aligned=USEC
 Align thread wakeups to a specific offset in microseconds
 .TP
 .B \-b, \-\-breaktrace=USEC
-- 
2.53.0

