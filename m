Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge7jBefR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC910D3
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Nov 2023 23:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700724287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8hk4Kg1X7keafzS7FaW8v8cynuJqlH3hpyac+cQxphA=;
	b=ge7jBefR/mMk5dd4G8udTv40u+UorvvnKVy7frrwHnau7AyJmShrRLxZBPnD9zJ1bCtGsk
	w+K9mc4RxJfwUsFtTXwIHTkGILLGjKnWvUK6/mkzM60j7phDkAGLBoOmvpHw4Nkxzm6hrO
	lPqdCCt7IqFqEQ0mRojBqtwhM09j/ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-DXF6XnhDMnqGVIsNJkNsAg-1; Thu, 23 Nov 2023 02:24:43 -0500
X-MC-Unique: DXF6XnhDMnqGVIsNJkNsAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76EAB8110A0
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2023 07:24:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D16492166B26;
	Thu, 23 Nov 2023 07:24:42 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 0/3] rteval: Refactor CPU list logic
Date: Thu, 23 Nov 2023 08:24:33 +0100
Message-ID: <20231123072436.270267-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Tomas Glozar <tglozar@redhat.com>

The main change of this patchset is the removal of the CpuList class, moving
the related logic to a new module rteval.cpulist_utils. Motivation for this
is further explained in the corresponding commit description.

In addition to that, there are a few smaller fixes in the first two commits.
These can be merged separately from the removal of the CpuList class
in the third commit.

v2: First patch ("rteval: Refactor collapse_cpulist in systopology")
broke --measurement-run-on-isolcpus because the new implementation of
collapse_cpulist does not allow for string cpus in input. Changed to
always convert cpus to string when passing to collapse_cpulist.

Third patch ("rteval: Convert CpuList class to a module") was missing
replacing the old calls to CpuList functions with the new cpulist_util ones
at a few places, causing rteval to fail to run with --*-cpulist option. Fixed.

Tomas Glozar (3):
  rteval: Refactor collapse_cpulist in systopology
  rteval: Minor improvements to CpuList class
  rteval: Convert CpuList class to a module

 rteval-cmd                               |  17 +-
 rteval/cpulist_utils.py                  | 125 +++++++++++++++
 rteval/modules/loads/__init__.py         |   8 +-
 rteval/modules/loads/hackbench.py        |   9 +-
 rteval/modules/loads/kcompile.py         |  14 +-
 rteval/modules/loads/stressng.py         |   9 +-
 rteval/modules/measurement/__init__.py   |   8 +-
 rteval/modules/measurement/cyclictest.py |  12 +-
 rteval/systopology.py                    | 190 ++---------------------
 9 files changed, 175 insertions(+), 217 deletions(-)
 create mode 100644 rteval/cpulist_utils.py

-- 
2.41.0

