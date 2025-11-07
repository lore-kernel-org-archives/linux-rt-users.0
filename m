Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C56309DCC
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523287; cv=none; b=RDK158K0MDuQgzoA5IGOhZKZH46ocIZmymImgZsLbwVcE5Wdn/Ea7Ogke4s7O4SOp8fbGqbm5ziCDbQeC+HAiseY5Gn2UekU1dgYH3yc5wAt7Nbc4Tl/q7oFuFxbFkGvyGUZlbHfPN+bXQamlFJdN9VuY/KO9x2q2k+jYwDJa9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523287; c=relaxed/simple;
	bh=yEwVnQmINVLTFVbIQkX2fnAowT+bmzMYjd6gbrGo5kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8oVqLM5OCUeQ7tKxx8DNEhJEBhD8TdULNA+bNgN67g9R+6ZMR4aJs/eEOo9kJHyrwCEQ0YSO1bxaayexFV7VistsuOORROAsIYIeH3iCg0VtC7ru3QWfN/WH5e1qjQTkl7JXw+V2QUveQPpbpZJ5cWPKWHm0ZIa0Rqii4QRDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKs/y7TP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKs/y7TP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762523284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOgkgym0EZ28MPDcUHm+Ot+FA6gEHmeHm7hbuM8rS7Q=;
	b=BKs/y7TPgKnrs9F8yx4XZsEp+bEvdh9d6pxtIru6/5azj+SRue6kREnYl76oqgZ8u2JA6i
	T4hMwGsYMkfU+GUbzRtydasAVdn7+p++oJkefR7DptvRFDQzIzgS5LRetDqkSTHU/qXKy6
	EccItPeFiS4vJxvFgqmnVVObAiBYins=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-cmARqGmtNFO_OblrObTqng-1; Fri,
 07 Nov 2025 08:48:02 -0500
X-MC-Unique: cmARqGmtNFO_OblrObTqng-1
X-Mimecast-MFC-AGG-ID: cmARqGmtNFO_OblrObTqng_1762523280
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0EC519560A3
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 13:48:00 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.228])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C0333001E83;
	Fri,  7 Nov 2025 13:47:59 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 2/3] rteval: Move unittest.py to tests/
Date: Fri,  7 Nov 2025 14:47:48 +0100
Message-ID: <20251107134749.257350-2-tglozar@redhat.com>
In-Reply-To: <20251107134749.257350-1-tglozar@redhat.com>
References: <20251107134749.257350-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We now have a tests/ folder. Move unittest.py there, and remove folder
unit-tests.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 {unit-tests => tests}/unittest.py | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {unit-tests => tests}/unittest.py (100%)

diff --git a/unit-tests/unittest.py b/tests/unittest.py
similarity index 100%
rename from unit-tests/unittest.py
rename to tests/unittest.py
-- 
2.51.0

