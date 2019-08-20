Return-Path: <SRS0=0hJj=WQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58785C3A589
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 06:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2025F22CF5
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 06:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZXaNsEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfHTGnT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:43:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52522 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTGnT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Aug 2019 02:43:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so1566912wmh.2;
        Mon, 19 Aug 2019 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0XAzeGSJHGOFWxURHAOeVeqy4oMuwXyuhlisAQdgna0=;
        b=HZXaNsEL8FCCPpoPnqPTf47Mly0iJP3FPoxn1xkOIV0e+NDUZZzSP6md8ZoMl3t7XF
         iDya0/hf8f6Dbe1S75noAW0jeq1omgFaD23GJ9sSotnQu1C5Jki6ZOvoY6qEcTh0p5G9
         KBGjgcpcIjE/YeklbegBZpp8+c7WoXIiwDmHzNiIDkvN57ZQkRbGeVLSpXsSYnn60ekH
         v7gpqjNk2zH9CPCfnhN5qqtzH45rT1W3btLlMqJBR48ouSajV4Y68sbSh6hym1HbjwK2
         1mpOb+wMfwKvYSsAP5sa8UiywXEU1WDg6xzsqg4HDDZe6VnrCryrJVpGGzvKNsjbhtyP
         1utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0XAzeGSJHGOFWxURHAOeVeqy4oMuwXyuhlisAQdgna0=;
        b=WnlWuipd1HaafnAkDwzYzBR8Xda479tyOUe/AUZ/pL3mz38rftYoId6JX8HAGgUrR5
         ACo4ULSWn3Q35MHX85wKT07+sNraDHKkhBCnVMnDE/PaSxX+LxMj2eUKFqdGMZD75otJ
         dBirnbaxJzlOgNJnjZ7rjPV2fW/byD49TRw83EmsO4T73LGpDjkQdIrxX0I+1Z6zhbsz
         f7wDu7aNENolOruGuq4jxij2O75nvnTLtVUjJ7n51Z3f/i0TbE3ERZAOWlcvpFaU0D/u
         CkDNXVbtMABYFSseHKUA12trwgz1wh4PZ5XmPzplA1X8+JK3JVEtHWcL/QUMfFNg9DO/
         hDdQ==
X-Gm-Message-State: APjAAAUABXeS+qU78DmKM2gWYPmKvxbIT3TuuDeamCrALj6ZmPb1asjB
        EHwNVCXsJ8rnppBoTF1JVDg=
X-Google-Smtp-Source: APXvYqx9jTVPh7Q3QPN80Pj0XZW1XRowf0FTlGCKaCIZGil7Xt976TZ4+5X7yd1NLmm5g7rpOQmHTA==
X-Received: by 2002:a05:600c:2192:: with SMTP id e18mr1970515wme.83.1566283397357;
        Mon, 19 Aug 2019 23:43:17 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id c15sm48432264wrb.80.2019.08.19.23.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 23:43:16 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:43:14 +0200
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, tglx@linutronix.de,
        bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, williams@redhat.com
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190820064314.GC6860@localhost.localdomain>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
 <20190819155721.05c878f8@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819155721.05c878f8@oasis.local.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 19/08/19 15:57, Steven Rostedt wrote:
> On Mon, 19 Aug 2019 14:27:31 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > The following BUG has been reported while running ipsec tests.
> 
> Thanks!
> 
> I'm still in the process of backporting patches to fix some bugs that
> showed up with the latest merge of upstream stable. I'll add this to
> the queue to add.

Great, thank you!

Best,

Juri
