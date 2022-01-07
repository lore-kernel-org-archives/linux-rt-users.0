Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C0C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Jan 2022 02:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345316AbiAGCPL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345308AbiAGCPK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Jan 2022 21:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641521709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrYXyJ7QBFhCYeLjDtYNF4VC+c+Lpn756lQ3ts75Kjo=;
        b=g6CGKC3jwBaJmR8e7dm7k4cB5pevxiBpPLlFY2RvCNx+rHbhSfuIf+brTSmT7O4NEu0zPe
        UV2WIoF4hDTCUKXIWVphVzV4VlIO+J/6pDQHefg0xncfZiNux0auPpz2uhJ3sOzueUP6iv
        EvjI4mOpqgAf1c70DeTogRtj7pVzxzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-a2dNKw5vMGCMB8uVfdDbgw-1; Thu, 06 Jan 2022 21:15:06 -0500
X-MC-Unique: a2dNKw5vMGCMB8uVfdDbgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F6E78015CD;
        Fri,  7 Jan 2022 02:15:05 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.8.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D2F2100164A;
        Fri,  7 Jan 2022 02:15:04 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A9F6A3C0048; Thu,  6 Jan 2022 23:15:02 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 3/3] Linux 5.10.90-rt61-rc1
Date:   Thu,  6 Jan 2022 23:15:02 -0300
Message-Id: <20220107021502.1121597-4-lgoncalv@redhat.com>
In-Reply-To: <20220107021502.1121597-1-lgoncalv@redhat.com>
References: <20220107021502.1121597-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v5.10.90-rt61-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 66fa05e70f292..c040746653492 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt60
+-rt61-rc1
-- 
2.33.1

