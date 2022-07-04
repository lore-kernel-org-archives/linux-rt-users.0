Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0479C43334
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Jul 2022 15:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiGDPC4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGDPCz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jul 2022 11:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A121F6339
        for <linux-rt-users@vger.kernel.org>; Mon,  4 Jul 2022 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656946973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbPVFg5HfSLExs8n8PnCNX+mcFJDkOgFSN/8HExwOpA=;
        b=fGKwC9sD834OKPdgPbmNQG60hMcTPrZmypmXCSNyVSiy/3Qcnda8v1VyyuLv+37omUjOd+
        HVjq8e1bcfh9gCdlFgnVF4aZN8cpZuHy0iS1cqz3YorM5bJZmKOhvidHzrUUCwhKFBxgbs
        YvE/Tu3jotq5apfWinVJmWZ6x+YLrJE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173--1ehdFw7OveDVj8Vad6Hxg-1; Mon, 04 Jul 2022 11:02:52 -0400
X-MC-Unique: -1ehdFw7OveDVj8Vad6Hxg-1
Received: by mail-wm1-f69.google.com with SMTP id r128-20020a1c4486000000b003a2b44d876aso677046wma.2
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jul 2022 08:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbPVFg5HfSLExs8n8PnCNX+mcFJDkOgFSN/8HExwOpA=;
        b=1NSyMhiMeUdqkMda+HG/JI3SjwgUo0atxTjxLZRRM0+s9++Nb8ueMpfKlPZ0fXOEbm
         not+iuXhmcffKTv0qxcz9uau0+htBOmC69h+Bae+s9ANBhEyzQ45jiqCcMNlaGyVywC5
         MTm6xGUgtjoyzR9GwlnaaTJt17PQYcQIoB+s3kFD6WpsQMgzHCgL0HXITXGRF7Dp3MQi
         uGFPonpkp/pkPLvoBWnduKo2D7AOEYPGXHjAZiTYPakCUk6F9dBGYePdiJXuFKESW4Ux
         043NrS3oJHLHNcttsEafHRcPJYWoxTahyB3GvLk5WrnWmSeeFdrrZ9BdavxajbtpZ52v
         apiQ==
X-Gm-Message-State: AJIora8z1VfzydVsqjbTa6aQ8CBCAAookOhF/7YvzTuDhafBjl3Xd167
        HgwWjPmO8nfBIBPJCPDe1n0U55n4ggZ8vbkkFtytLISiEz9NjOI85BbLmB3nWveSGYPnqmvmXnM
        QJj73lrpZEZ7x3QXexqiPpernxA==
X-Received: by 2002:adf:e702:0:b0:21d:6900:ea1c with SMTP id c2-20020adfe702000000b0021d6900ea1cmr6477190wrm.620.1656946971562;
        Mon, 04 Jul 2022 08:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPzYr8Iuz4JWFuy/bxMQLAhayVyp/s0V3e6xRbpAesBg1i9PcXXW7Pw7n7srJq66M4b08TZw==
X-Received: by 2002:adf:e702:0:b0:21d:6900:ea1c with SMTP id c2-20020adfe702000000b0021d6900ea1cmr6477151wrm.620.1656946971326;
        Mon, 04 Jul 2022 08:02:51 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003a04b0bcb43sm19451631wmi.40.2022.07.04.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:02:50 -0700 (PDT)
Date:   Mon, 4 Jul 2022 16:02:49 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christopher Lamenter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <20220704150249.rwxekvj7nlarja6b@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220703123109.3770204-1-atomlin@redhat.com>
 <CAB=NE6VYhoXbS2TYN_+TP1P+C5kbnNBNr2vr8V9Fs2dvm6NL5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=NE6VYhoXbS2TYN_+TP1P+C5kbnNBNr2vr8V9Fs2dvm6NL5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon 2022-07-04 07:55 -0700, Luis Chamberlain wrote:
> Aaron, thanks for the patch! Your commit log however reads like an
> optimization but it's a fix that needs to go to Linus, as such, can you
> update it to explain clearly *why* it's a fix.

Hi Luis,

Sure - will do.


Kind regards,

-- 
Aaron Tomlin

