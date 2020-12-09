Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CBC4167B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD92233EA
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 14:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbgLIOxD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbgLIOwz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 09:52:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D3C06179C
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Dec 2020 06:52:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i9so2051747wrc.4
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Dec 2020 06:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8B63CdA/mRT8RO3l7gAf79HFX2FaCdIB/HywCX4XINw=;
        b=FYMgce+eZibf5yzoliI0r7tMr9W4JEwA95+OcIwL/9vZauhXQ+9k8Om2Jlj3OAkkQp
         N5bK1A3Hw6Up9bdT+ot7lYont8QnneacAbUIvCXcD9ZgcvEkBfvvLd51E7snhHbTYA6W
         hHwZB7lPkV1VD9eFA+NFHckGmmy/fnoIsQN+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8B63CdA/mRT8RO3l7gAf79HFX2FaCdIB/HywCX4XINw=;
        b=K/LPPiULqa7cCV92mn5Z2YgN4KNwda9+GhPRPO3HL5oK95kz0OF4eaVv0jkckYGrQp
         0eOakrFr3ZhIHcLnDOxldnvb3Wy9gHbZmgktVqNBANWVZRVu03M8sSWbDNnSxZnH9Dzj
         k+ovuNVujmG1cAijdWWpduMun4L+7+Ewwtj7qfIbZE8vwG1AQ7+r96/0AtzDBpONGXUR
         MDoljbV+Ytacl866teiiv7ui9E2IxeqVoghFiW1doPwQyehx2LpRsOSSiLk04ZtMBDuJ
         72mGNROe4TY06wVEL9xO7WE3HFY7FhtVGcXN7TGXYTWbVc3XxTan8b4qXC43cOtl9z80
         I6tA==
X-Gm-Message-State: AOAM531wnowlt+GHPzD1C6PSRptt1E1VdCGuEDaqj3ayaSfQBaEA31ue
        TgRH7lZczF7BUPwX1Z8m5742/kTlQF7i6f9U
X-Google-Smtp-Source: ABdhPJwrS/p3e9ysk2dI08RtwuFRzCtLqaqaSWeKSAOmwoxMMEWcrzGWSCnrZ/Zd2unz3jtUeEBPPg==
X-Received: by 2002:a5d:6250:: with SMTP id m16mr3154057wrv.400.1607525533379;
        Wed, 09 Dec 2020 06:52:13 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 189sm3831957wma.22.2020.12.09.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:52:12 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-mm@kvack.org
Cc:     lkml@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, akpm@linux-foundation.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH 0/3] z3fold: stability / rt fixes
Date:   Wed,  9 Dec 2020 16:51:48 +0200
Message-Id: <20201209145151.18994-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patchset addresses z3fold stability issues under stress load,
primarily in the reclaim and free aspects. Besides, it fixes the
locking problems that were only seen in real-time kernel
configuration.

Vitaly Wool (2):
  z3fold: simplify freeing slots
  z3fold: stricter locking and more careful reclaim

Mike Galbraith (1):
  z3fold: Remove preempt disabled sections for RT

 mm/z3fold.c | 191 ++++++++++++++++++++++++++--------------------------
 1 file changed, 96 insertions(+), 95 deletions(-)

-- 
2.20.1

