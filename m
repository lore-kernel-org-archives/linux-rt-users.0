Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F873C47082
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5419F6127C
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 21:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEaVau (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 17:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231571AbhEaVaq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 17:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622496546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Pgu1WeDIZxse9Mv97uoe7mVRCHpblEk/SFb6SubcR8=;
        b=NRwwhVLaw6Q4u+T/0z8JgAfjwvq2mrPZ9XfxxboJzfq5niD+BZgMvvBpV47Av33IqIMeCf
        /FEWiMI1+gwVQApcsZBRgd63d9FOV39zhjmr2ynxo9mUdYUdvl3k+pR0s6cdZQwO9H31zL
        khYVrUTxxiCmSYECEy3RoMR/RRgtKUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-jnYrsUEUMN-s90mQKwANmw-1; Mon, 31 May 2021 17:29:04 -0400
X-MC-Unique: jnYrsUEUMN-s90mQKwANmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A88E71005D51;
        Mon, 31 May 2021 21:29:02 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF5505C1B4;
        Mon, 31 May 2021 21:29:01 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 251C53C0179; Mon, 31 May 2021 18:29:00 -0300 (-03)
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        "stable-rt@vger.kernel.org"@redhat.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 3/3] Linux 4.9.268-rt180-rc1
Date:   Mon, 31 May 2021 18:29:00 -0300
Message-Id: <20210531212900.37969-4-lgoncalv@redhat.com>
In-Reply-To: <20210531212900.37969-1-lgoncalv@redhat.com>
References: <20210531212900.37969-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.9.268-rt180-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 326e314b799eb..df629541e5443 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt179
+-rt180-rc1
-- 
2.31.1

