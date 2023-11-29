Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PczxHBZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F6170B
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Nov 2023 01:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701250625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wh0PcDW0euxXzEA/2HFLqS/sxjGc43widCSv24UbTcU=;
	b=PczxHBZ+IekK6ecvSOdq02Y04/Dl3FtrKy40HVANO8h/EUipKt++hnKty/xj241tHUOaS5
	0+hofVGaHGvhg1aiGwCTrQHnoetE3TYVIlPQxepYOXQiURgAJ+w0oVeDgBoGR7q0WAUGt8
	bOKXqmxyUNAmW/wN1rEcA+kBB6tf+HY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-8sweOgw2N2uaRLZdzW98LA-1; Wed, 29 Nov 2023 04:37:03 -0500
X-MC-Unique: 8sweOgw2N2uaRLZdzW98LA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D8208526E2
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Nov 2023 09:37:03 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.244])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A54EF40C6EB9;
	Wed, 29 Nov 2023 09:37:02 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/4] rteval: Add relative cpusets
Date: Wed, 29 Nov 2023 10:34:53 +0100
Message-ID: <20231129093457.17984-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Tomas Glozar <tglozar@redhat.com>

This is a follow-up to "rteval: Refactor CPU list logic" patchset. First three
patches contain some cleanups, most importantly the removal of CpuList class
and moving the code into a module rteval.cpulist_utils.

Fourth patch adds support for relative cpulists for measurements, e.g.
--measurement-cpulist=+1,2,-5,6, for details, see the commit message.

Tomas Glozar (4):
  rteval: Refactor collapse_cpulist in systopology
  rteval: Minor improvements to CpuList class
  rteval: Convert CpuList class to a module
  rteval: Add relative cpulists for measurements

 rteval-cmd                               |  31 ++--
 rteval/cpulist_utils.py                  | 161 ++++++++++++++++
 rteval/modules/loads/__init__.py         |   8 +-
 rteval/modules/loads/hackbench.py        |   9 +-
 rteval/modules/loads/kcompile.py         |  14 +-
 rteval/modules/loads/stressng.py         |   9 +-
 rteval/modules/measurement/__init__.py   |  11 +-
 rteval/modules/measurement/cyclictest.py |  52 +-----
 rteval/systopology.py                    | 223 +++++------------------
 9 files changed, 252 insertions(+), 266 deletions(-)
 create mode 100644 rteval/cpulist_utils.py

-- 
2.39.3

