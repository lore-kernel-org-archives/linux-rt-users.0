Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47833C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Apr 2022 08:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359406AbiD0IdV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359401AbiD0IdT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Apr 2022 04:33:19 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED12D1FA48
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Apr 2022 01:30:08 -0700 (PDT)
Received: from zimbra35-e6.priv.proxad.net (unknown [172.20.243.185])
        by smtp6-g21.free.fr (Postfix) with ESMTP id AAC2778034D
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Apr 2022 10:30:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1651048206;
        bh=B9qTb2KXsiQNBJx9Y8DlBiuvDAyJencmeZ4oyE1RU5E=;
        h=Date:From:To:In-Reply-To:Subject:From;
        b=q9Mhkg/GfSuO7XWqpabSpiDHUhaYXpAEUkXkWK5dBtZzMZYTwGONbGVNcWrHkZog4
         vm2MxvEyxAxzKHo26zQctbNAZbyktirUosOG7phhJWEduiNZhXAaux5NU3L2g15jDg
         PEzrS+/bafE8HTwrk6tXk34yH/xvJGvrScvhSK58mExdOTAIJaW62BUvGFHolFaljO
         TOYL2jmQWMBjp+8QiWMtqlVOgn+X9i2V5RlNloqJ/foUPZ7DovPU4NzHmJe1QOVg/e
         sFtg2SEiFFiZD6d0PHroWHDNHh2n3V/f6gZ8I6lZtuhmPNs7DCBPu+cN7NaU7EdEvJ
         ue9qdzx6Oi3ww==
Date:   Wed, 27 Apr 2022 10:30:06 +0200 (CEST)
From:   ycollette.nospam@free.fr
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Message-ID: <762097346.1053386669.1651048206470.JavaMail.root@zimbra35-e6.priv.proxad.net>
In-Reply-To: <164875304500.974121.18336996246209199283@puck.lan>
Subject: Problem compiling 5.10.109.rt65 on Fedora 36
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2a01:e0a:244:b080:249c:e6cc:8f26:fa90]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC100 (Mac)/7.2.0-GA2598)
X-Authenticated-User: ycollette.nospam@free.fr
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

I am trying to compile 5.10.109.rt65 on Fedora 36 beta using gcc 12.
The compilation fails with this message:

 Auto-detecting system features: 
... libelf: [ on ] 
... zlib: [ OFF ] 
... bpf: [ on ] 
No zlib found

The same build succeeds on Fedora 35. zlib-devel is installed in both cases.

Do you have some hints about why this build can fails ?

Best regards,

Yann
