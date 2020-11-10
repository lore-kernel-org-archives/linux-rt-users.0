Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486ADC388F7
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA47320797
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Nov 2020 18:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q80g+HRr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ydB3Jhej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJSAn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJSAn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 13:00:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449A7C0613CF
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 10:00:43 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605031241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SYAcSCRHt2Be+t6oj72tdgBivksqJ6SRgXiQ8uKpa1U=;
        b=q80g+HRrgZFcSzi5slBlnVsj9FMWZGC+GNKQu8AUNnlEb9CoVl2WkG6kyT4B35GQnj1wgH
        +52bokM1Kl063GukiV8PsnVsoL+2h2+Tl/PJvVa5bZ4cBFgOIlmruX7H+NBo0o1a0F6nXZ
        nKYXNfPO8xVKhNCBTeTSmytLv0GoyEsSZR8HK0IM6CmvMxhGwe5eH/vZwInyJRoibptQxB
        iyIbqOV5Qbe8jbsekMs0nYEuIv5UsoEw1C+VrVdregj1cV6NMA0md1EoeVWfhYSP3HhjNp
        me7AMvxkdQZkQsdmadsn/ShJVdt/mP3X4eYbqzoRFYKaFL9MK5rZGYmREmyF2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605031241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SYAcSCRHt2Be+t6oj72tdgBivksqJ6SRgXiQ8uKpa1U=;
        b=ydB3JhejIThMxvR4Ji/TlVkjrGt3BhVRkXyVFr4UfxrgUy/+v/zStLOqE7anbT+g+C9p9x
        FqG/FbkouHnR7WCg==
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <wagi@monom.org>
Subject: [PATCH 0/5] rt-tests: Mostly signaltest clean up
Date:   Tue, 10 Nov 2020 19:00:31 +0100
Message-Id: <20201110180036.859080-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Patch #1 is old, I noticed it it is still uncommited from last time.

Patch #2 - #4 is cleanup of signaltest to get it to work with the break
value argument so I could trace.

Patch #5 is only for Daniel and not for merging.


