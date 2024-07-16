Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C819AD8A
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jul 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157575; cv=none; b=B4MayjafO1UER/ZAWQEshW94RvPj8+ld2oxV0lOqY2ZwMcPe5a8Nl5Esi/D1WlyUA36HaG3RaxQqPpFg6pV7lEELuvB6qXpnP7J0lAO6DMloNq13Sbc0xvBIla3NDx7VLMzQHCsKOe2R930ubd+HSCPRq39HCgaLrkP5Mr6YvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157575; c=relaxed/simple;
	bh=aSKpRK29OH+m3teLQYxKxqVByv3GyEch8N7yP9jdMy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTxQUQ4i5FjzqRwu8mAoV5rabOzjSVzn5Varq8XdGBPmHMD9WqMnNmnz+SUzcDiNM+1Ohg2QZgoG8KaqT5FbcWT5SAsoFzzad+7CTMZJnl7AMPGBVEAfWj/866dZU0N1DVWjN+/mhtjQkFss1eVwTL+XWu6cbzL2VZ/720147+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYuAAR+1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYuAAR+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721157573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2dX5FbFnmEcxf1PTIlUFnFvlnUO3PaRDA5x5RsgtuhM=;
	b=MYuAAR+1d9/TGunSDcYqgh7HEYzOvjN51Hc8lBr0Ms684o4W6WLlXXI7b7YzOf8QKvKo0s
	UE7xKC3bzaf91VLYfbSbo38pQJA6GVRie85tCOk160Fk/Or9DBU6XXU7mh1tredFCR8kHU
	7Wx1EgnbHeV+Uakja6tzxv+sVfFATMs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-u0GdEYoVPCmFEEfI54MB_w-1; Tue,
 16 Jul 2024 15:19:31 -0400
X-MC-Unique: u0GdEYoVPCmFEEfI54MB_w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 661891955D59
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jul 2024 19:19:30 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.8.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22E3D300018E;
	Tue, 16 Jul 2024 19:19:28 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 1/2] tuna: require -i option for cstate
Date: Tue, 16 Jul 2024 15:19:19 -0400
Message-ID: <20240716191920.607678-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Previously, user could run cstate subcommand without specifying cstate.
Now the option to specify a cstate is required.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tuna-cmd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index b6f94182241f..5a7e795e3bea 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -224,7 +224,7 @@ def gen_parser():
     show_irqs.add_argument('-q', '--irqs', **MODS['irqs'])
 
     cstate.add_argument('-c', '--cpus', **MODS['cpus'])
-    cstate.add_argument('-i', '--cstate', **MODS['cstate'])
+    cstate.add_argument('-i', '--cstate', **MODS['cstate'], required=True)
     cstate.add_argument('--info', **MODS['info'])
 
     what_is.add_argument('thread_list', **POS['thread_list'])
-- 
2.45.2

