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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AE1C47080
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65466127C
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 22:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhEaWty (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 18:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232286AbhEaWtv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 18:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622501290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvRDSspVLhhkzFiiiTeHXwtwbHiXULzCzQJT9Vi3lhA=;
        b=c3+yEsP5GqDLMF2tJH6yQphtMEP4kzFPCeFKogyoy+d9w1/ngEc3253ZbyuiBrMjpnmkhw
        KaevSx3NNZYFwHzuf2R6RWHyS8eY1FGqk6DzJyo2N6tO24hmRLaHy+jcNps3PeR0LHGoDE
        0IT8FrzFXMP0yBJaWhLsz6MXdO+/+5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-69wCvGp0Mx-oewxyn-gilg-1; Mon, 31 May 2021 18:48:09 -0400
X-MC-Unique: 69wCvGp0Mx-oewxyn-gilg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741F480293C;
        Mon, 31 May 2021 22:48:07 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07119100EBAF;
        Mon, 31 May 2021 22:48:07 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 4A8293C0179; Mon, 31 May 2021 19:48:05 -0300 (-03)
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
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 3/3] Linux 4.14.232-rt112-rc1
Date:   Mon, 31 May 2021 19:48:05 -0300
Message-Id: <20210531224805.45914-4-lgoncalv@redhat.com>
In-Reply-To: <20210531224805.45914-1-lgoncalv@redhat.com>
References: <20210531224805.45914-1-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

v4.14.232-rt112-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 9969a4b69fade..80c07f1b2fd78 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt111
+-rt112-rc1
-- 
2.31.1

