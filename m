Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5D19922A
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924753; cv=none; b=UfFeFqili5Gg4bJui9FXwIh3++9mkG0l04DX+D4HRO9pNbkLV2g0OfZ0coHQWvxnJ4L9Sef2jRGAjyS8NYcSnLLQrbBUHOcBoWkwMOJKG2vxlaNutjugtPU4+4BDBZUUjd1kO9AQv9+73sRHj8CpFwhgd2O/lKtHrj+WmIQPYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924753; c=relaxed/simple;
	bh=aSKpRK29OH+m3teLQYxKxqVByv3GyEch8N7yP9jdMy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6PIAHDe1+7hgAYi7aHf+NK9xL8U+W1+NO4uYcV038UJAEXMcdCX7vZeedwXOVJHt0CU1JxlP0tDaPVgNA/c2QFu6FinqV5k3ceCOVQemuhtQFm97P6Ba4pFKK34Pvsv9HkamaXDqEhiJ0w1mAd8UW9XNVajzAeI5aYd4bbOOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fd8KQDoC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd8KQDoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721924750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dX5FbFnmEcxf1PTIlUFnFvlnUO3PaRDA5x5RsgtuhM=;
	b=fd8KQDoCJku2zioIy0BEjUKNTMIuAqEyga5yFN6tkl2U7JW887oEB9IJczSSZEy3bS1MJc
	72xO+Ldy8M3UI2p1w13FdskWan5s5mK024ym5/7Kq5/FJCrWp+MWcixFiag8GWGP1nIiRp
	8jn1aE9vQ/EG0sqbsOdqGbdUrqP8aWs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-fwL4ckcTPSq_rhmeiz2Wng-1; Thu,
 25 Jul 2024 12:25:49 -0400
X-MC-Unique: fwL4ckcTPSq_rhmeiz2Wng-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B20E01955F4A
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 16:25:48 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.15])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 509D5195605A;
	Thu, 25 Jul 2024 16:25:47 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v4 3/3] tuna: require -i option for cstate
Date: Thu, 25 Jul 2024 12:25:32 -0400
Message-ID: <20240725162532.1890461-3-ashelat@redhat.com>
In-Reply-To: <20240725162532.1890461-1-ashelat@redhat.com>
References: <20240725162532.1890461-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

