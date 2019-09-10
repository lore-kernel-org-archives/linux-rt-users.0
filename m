Return-Path: <SRS0=sUiU=XF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A02EC3A5A2
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E1221019
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Sep 2019 12:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfIJMCe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:02:34 -0400
Received: from mail.thorsis.com ([92.198.35.195]:35292 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfIJMCe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Sep 2019 08:02:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 6969324F7
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Sep 2019 14:04:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ibsu0lCHeLTj for <linux-rt-users@vger.kernel.org>;
        Tue, 10 Sep 2019 14:04:00 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 553FC4B26; Tue, 10 Sep 2019 14:04:00 +0200 (CEST)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Gene Heskett <gheskett@shentel.net>
Subject: Re: [ANNOUNCE] v5.2.10-rt5
Date:   Tue, 10 Sep 2019 14:02:24 +0200
Message-ID: <36472109.XBoHfvBAoT@ada>
In-Reply-To: <201909100733.16783.gheskett@shentel.net>
References: <20190827105542.qxvtteirkh55i5ly@linutronix.de> <201909100733.16783.gheskett@shentel.net>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hei hei,

Am Dienstag, 10. September 2019, 07:33:16 CEST schrieb Gene Heskett:
> No such file or directory?

Go to https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.2/ and pick what 
you need.

Or use the linux-rt-devel Git tree and look out for the tags 'v5.2.10-rt5' or 
'v5.2.10-rt5-rebase'.

HTH
Alex

