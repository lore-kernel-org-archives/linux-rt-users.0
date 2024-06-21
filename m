Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488AEEC6
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936293; cv=none; b=Sf510mbJy2ZBYr/khaSIZXzHbhkyYV8NIP3RLNxzvvecyigeRg7zD5ijeG7bUvFpDuEG1rtA6dcuWIClVPoFRoULDVEa93Vz7l10d1YmwPX5pa6FztVUvh9P6Jm7hezWJkjFlOB6OVM+Mo3ScEJSvc/C5BXH0ixyMKLXvrXEcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936293; c=relaxed/simple;
	bh=RkuIBXvErjndec5ulPd2F5zmjRdTAWJl1l/hH1x5gDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IMCOFGKjBR1ZjHfAsyiApNkrTo79r+WbB4AcVP6tKHGsvqxCqvPbdCyyvt9U5ZW+mOEtG0KexV1qZAlQTEklLEQ2zIj2H1F1IIJUTYdsuLTucIWe3WwDEvc8nZ7laWqqXhDJ7NFNfLJLkSymip5+owpijBPklbGctTyWpNutHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnNE8Ut3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnNE8Ut3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718936290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mwxwU1h2hA8rQ18q6/RPX5rO3Z7Ab3zef985gCVveDA=;
	b=VnNE8Ut3+V0GhQR/OkRFSXKn05v0XERIrk+Lwv6rpCLpuDi27a3C8nkyMH3NqXjRUW6eOj
	AyjJjMCujnbrMbXxTKY6apZ1v4Rm+v2AcZqjJv/NgTvnNPrUXU8RV+3jdXXoefMmfiGnq9
	A/ooI5eE5MZsP8QSoJ8oKzQ0OfmD0iM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-vtjhfNH6M9iUHy_3dajDmQ-1; Thu,
 20 Jun 2024 22:18:08 -0400
X-MC-Unique: vtjhfNH6M9iUHy_3dajDmQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C2101956086
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:18:08 +0000 (UTC)
Received: from p1g2.hsd1.mn.comcast.net (unknown [10.2.16.179])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA4F019560AE;
	Fri, 21 Jun 2024 02:18:06 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rteval: sysstat: Convert base64 data to text before wrapping
Date: Thu, 20 Jun 2024 21:18:05 -0500
Message-ID: <20240621021805.2086489-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

As of Python 3, b64encode() returns data, not a string, causing this:

Traceback (most recent call last):
  File "/home/crwood/git/rteval/./rteval-cmd", line 413, in <module>
    ec = rteval.Measure()
         ^^^^^^^^^^^^^^^^
  File "/home/crwood/git/rteval/rteval/__init__.py", line 246, in Measure
    self._report(measure_start, self.__rtevcfg.xslt_report)
  File "/home/crwood/git/rteval/rteval/rtevalReport.py", line 63, in _report
    self.__xmlreport.AppendXMLnodes(self._measuremods.MakeReport())
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/crwood/git/rteval/rteval/modules/measurement/__init__.py", line 190, in MakeReport
    mprep_n = mp.MakeReport()
              ^^^^^^^^^^^^^^^
  File "/home/crwood/git/rteval/rteval/modules/measurement/__init__.py", line 62, in MakeReport
    rep_n = RtEvalModules.MakeReport(self)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/crwood/git/rteval/rteval/modules/__init__.py", line 559, in MakeReport
    modrep_n = mod.MakeReport()
               ^^^^^^^^^^^^^^^^
  File "/home/crwood/git/rteval/rteval/modules/measurement/sysstat.py", line 83, in MakeReport
    data_n = rep_n.newTextChild(None, 'data', "\n"+"\n".join(textwrap.wrap(data, 75))+"\n")
                                                             ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.12/textwrap.py", line 384, in wrap
    return w.wrap(text)
           ^^^^^^^^^^^^
  File "/usr/lib64/python3.12/textwrap.py", line 356, in wrap
    chunks = self._split_chunks(text)
             ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.12/textwrap.py", line 342, in _split_chunks
    text = self._munge_whitespace(text)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.12/textwrap.py", line 153, in _munge_whitespace
    text = text.translate(self.unicode_whitespace_trans)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: a bytes-like object is required, not 'dict'

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/modules/measurement/sysstat.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/measurement/sysstat.py b/rteval/modules/measurement/sysstat.py
index 57194a2b5f45..d4646c1646f4 100644
--- a/rteval/modules/measurement/sysstat.py
+++ b/rteval/modules/measurement/sysstat.py
@@ -79,7 +79,7 @@ class sysstat(rtevalModulePrototype):
         fp = open(self.__datafile, "rb")
         compr = bz2.BZ2Compressor(9)
         cmpr = compr.compress(fp.read())
-        data = base64.b64encode(cmpr + compr.flush())
+        data = base64.b64encode(cmpr + compr.flush()).decode('utf-8')
         data_n = rep_n.newTextChild(None, 'data', "\n"+"\n".join(textwrap.wrap(data, 75))+"\n")
         data_n.newProp('contents', 'sysstat/sar binary data')
         data_n.newProp('encoding', 'base64')
-- 
2.45.1

