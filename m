Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B194D8A3
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jul 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157586; cv=none; b=QxbPEjbiBgDfbFyZU/kzj2EuwzW203O2i+T36GsQIMhjtAQcbY020cF4llIRkHWqBPGhQbE9Nmn9QNkg7ArtZLJXcw1NasqnZahj7W6qjwyT7JY9H97RBoy5+vnJ2carMlwIWBc3qA0Xh2Zv0nd8LhU0R/krqTgO+0Sd8T6rnoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157586; c=relaxed/simple;
	bh=oyPwugTeFXV4/pBLJ0GfIYHVJVuuOvpqkO7V3FAvbP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlUrZmHftL67pFMM8KbWQY+cD+Q6e7BwE7Ff8HDxrXWvjU1WeQZ6ovqnJAI8D1c66ZJIbI89q0ZXBMdIxw+KMasTYMSri+lbj9njtNiBVEXnG5OrUhzGFuJ96RI4MrwmtXsAxA2Ysc4k8M4+ceLXyg+rUA0Hi6ezGamad9Vaf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mf+vp7tu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf+vp7tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721157583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFzYfUhoiMDkbgH7OYRAfS2FtotoYJLLcT8KkbtITeg=;
	b=Mf+vp7tuGNvarFl1hs9xRXvKb7zZwtj7MbIpMCZltZ4DQyL5rwERn32wNXOaqLBM6G8fOc
	cDLEqjozbn++BDtPISs1m8y39AU3WbL1KVBscXYC8vTMGUOarhcHyKIluwlIopBknMFAF7
	czAPzlbksfDVV//OF8HjVQE5T8QjhIU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-wNuUMK2MNym0daKC1FX2nw-1; Tue,
 16 Jul 2024 15:19:41 -0400
X-MC-Unique: wNuUMK2MNym0daKC1FX2nw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA17D1955EA7
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jul 2024 19:19:40 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.8.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC7083000183;
	Tue, 16 Jul 2024 19:19:39 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 2/2] tuna: added SPDX licence for cpupower.py
Date: Tue, 16 Jul 2024 15:19:20 -0400
Message-ID: <20240716191920.607678-2-ashelat@redhat.com>
In-Reply-To: <20240716191920.607678-1-ashelat@redhat.com>
References: <20240716191920.607678-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Added SPDX licence for cpupower.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tuna/cpupower.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tuna/cpupower.py b/tuna/cpupower.py
index da869420eb6f..1a8296553ed8 100644
--- a/tuna/cpupower.py
+++ b/tuna/cpupower.py
@@ -1,4 +1,5 @@
 #! /user/bin/python3
+# SPDX-License-Identifier: GPL-2.0-only
 
 import subprocess
 import argparse
-- 
2.45.2

