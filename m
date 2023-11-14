Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E02A3E483
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyNeBPQA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD3130
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699964302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O49raFKhV2l3Lm2MUtiSwyCUQU+pwdmME00aUukjVFw=;
	b=FyNeBPQAuIiaJlb9fF2FvEWnmeCLWz6MmBFo/Oy+otckQMcasNZ/27wYLbDya0fMuRe1Rc
	02Q7YVssTP4q1Z7h6++11FJU92onXLggugp/7UdHYXXY6XtMQ6TkBsNdwyhsPFVeiUJfOm
	6oXVM5jF5XtNipwwWEEPYymCAkYcEN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-izvGdBlCN8mW4onI7e4oUg-1; Tue, 14 Nov 2023 07:18:20 -0500
X-MC-Unique: izvGdBlCN8mW4onI7e4oUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF98085A58C
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 12:18:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1793C36EE;
	Tue, 14 Nov 2023 12:18:19 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 0/3] rteval: Refactor CPU list logic
Date: Tue, 14 Nov 2023 13:18:05 +0100
Message-ID: <20231114121808.154654-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Tomas Glozar <tglozar@redhat.com>

The main change of this patchset is the removal of the CpuList class, moving
the related logic to a new module rteval.cpulist_utils. Motivation for this
is further explained in the corresponding commit description.

In addition to that, there are a few smaller fixes in the first two commits.
These can be merged separately from the removal of the CpuList class
in the third commit.

Tomas Glozar (3):
  rteval: Refactor collapse_cpulist in systopology
  rteval: Minor improvements to CpuList class
  rteval: Convert CpuList class to a module

 rteval-cmd                               |   9 +-
 rteval/cpulist_utils.py                  | 125 +++++++++++++++
 rteval/modules/loads/__init__.py         |   7 +-
 rteval/modules/loads/hackbench.py        |   9 +-
 rteval/modules/loads/kcompile.py         |  14 +-
 rteval/modules/loads/stressng.py         |   9 +-
 rteval/modules/measurement/__init__.py   |   8 +-
 rteval/modules/measurement/cyclictest.py |  12 +-
 rteval/systopology.py                    | 190 ++---------------------
 9 files changed, 170 insertions(+), 213 deletions(-)
 create mode 100644 rteval/cpulist_utils.py

-- 
2.41.0

