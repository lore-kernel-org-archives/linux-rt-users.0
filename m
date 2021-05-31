Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA5C47080
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 15:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5964B6128A
	for <linux-rt-users@archiver.kernel.org>; Mon, 31 May 2021 15:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhEaPap (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 31 May 2021 11:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234663AbhEaP1n (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 31 May 2021 11:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622474697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4JcYhWe8fmp3R5gpBfuApjCZLko+hwnxUS+X7YLgb84=;
        b=a4YZXeRCX8TrZV1OAcJvl93MCvdurbxw8+Ywbqm9zNphYF4/eDLhivQ9vG22P5joczimec
        +jfopatkeiy2BwiO0pNqaIUwg4zxWFSUbap31EZZXeBRGgiwIW5OFrR2IbIN6cjSjRr2df
        V94OQk0l+gEl5o3gx0MIpnTFoAkzR2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-dcUBGinZOB6OVHW4wm3kKQ-1; Mon, 31 May 2021 11:24:54 -0400
X-MC-Unique: dcUBGinZOB6OVHW4wm3kKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D6DE8015C6;
        Mon, 31 May 2021 15:24:52 +0000 (UTC)
Received: from wcosta.com (ovpn-116-128.gru2.redhat.com [10.97.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA3006062C;
        Mon, 31 May 2021 15:24:42 +0000 (UTC)
From:   wander@redhat.com
Cc:     linux-rt-users@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, rostedt@goodmis.org,
        Wander Lairson Costa <wander@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netpoll: don't require irqs disabled in rt kernels
Date:   Mon, 31 May 2021 12:23:23 -0300
Message-Id: <20210531152325.36671-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Wander Lairson Costa <wander@redhat.com>

write_msg(netconsole.c:836) calls netpoll_send_udp after a call to
spin_lock_irqsave, which normally disables interrupts; but in PREEMPT_RT
this call just locks an rt_mutex without disabling irqs. In this case,
netpoll_send_udp is called with interrupts enabled.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 net/core/netpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c310c7c1cef7..0a6b04714558 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -36,6 +36,7 @@
 #include <net/ip6_checksum.h>
 #include <asm/unaligned.h>
 #include <trace/events/napi.h>
+#include <linux/kconfig.h>
 
 /*
  * We maintain a small pool of fully-sized skbs, to make sure the
@@ -389,7 +390,8 @@ void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	static atomic_t ip_ident;
 	struct ipv6hdr *ip6h;
 
-	WARN_ON_ONCE(!irqs_disabled());
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		WARN_ON_ONCE(!irqs_disabled());
 
 	udp_len = len + sizeof(*udph);
 	if (np->ipv6)
-- 
2.27.0

