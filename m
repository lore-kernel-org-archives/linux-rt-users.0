Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EDAC4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3E1206C2
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odFIWw2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfIQOMp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:12:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38092 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfIQOMp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 10:12:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so4145183qkc.5;
        Tue, 17 Sep 2019 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mlX47Ex8hsCM3e/jGUFMyWoTbU1E/bacKMTtTwQUI5M=;
        b=odFIWw2JEoCJ1+S0damfwSrXQy/P0mzi1ExCba4dxt1466qNpq1ix2OfcSDlpKpyLk
         56QhilmivGYaH3l0IHCqotF5hXcMCKU4E9w0aJkTtRFU05clhVVMZPTXt4Qb8nafa2QX
         X8QHdA+WUogbcFSZjDeRj2NQpCvwJpM8VrVppBm7tgScAzGZF6sM+Qln+9v248UryVpd
         TOgB19FllqB6kvZ7HmMBFkOAOhnnh8POYKl/A8DnT3N5t+tR8keA9okaW4eaglonENYa
         T7Y3UqdloLiqxlRy2jMq+DESYajcy4iMMQU+MvIHQmhp/eEkKTjdDlZZeOZx2FA0Tq/N
         ax0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=mlX47Ex8hsCM3e/jGUFMyWoTbU1E/bacKMTtTwQUI5M=;
        b=WhnA+Dy+cZuJ/z5BQFZypZNBjhYDEWMqayB4yVUP2G8/avmedukGFkDtMkt6r7Vlh3
         Ok9vND3CoqnHK9N1jZggCqoneAbZCcQVd6PbfLAvbQLaaVgWZFf6b6Rddi2Um6PaVrlw
         GtSxgMPBeV6xvKIgXcJmD55sGuY1QOCAWZ2GUna3X/BhlOjZNSWQddE3zU0D3jbn1bB7
         o2y2ypl3I5ab+ejmOzEsTaQpBV+3lb78oCIRXw4sZC0esyKsT2sCt/IH4GLsUPajXhP8
         oEP6PqBRVbnjh7MlAlAeriTX99UI0nayIJ5zZmc9EZq0/PtgxRyWOCLNV6vMOFjXNqyu
         jiTw==
X-Gm-Message-State: APjAAAV6x2znJ6jihx8SR4FpfxB4NmrN//dKLme61qLTc9IqHh+9qRyL
        7PVfBlP2oe5pKvuh5VI2Sac=
X-Google-Smtp-Source: APXvYqzQyBndlALrFP26BUU7ZlJ+0iMTmhkVrQyzNNc26aXq6vivij1L+PFPHpPlWE+JNWEXaWq/pA==
X-Received: by 2002:a05:620a:12b6:: with SMTP id x22mr3947897qki.495.1568729564206;
        Tue, 17 Sep 2019 07:12:44 -0700 (PDT)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id 92sm1222693qte.30.2019.09.17.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 07:12:43 -0700 (PDT)
Date:   Tue, 17 Sep 2019 16:12:36 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        sebastian@breakpoint.cc, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h
 directly
In-Reply-To: <20190917102436.tn2faq3hcdadybgw@linutronix.de>
Message-ID: <alpine.LFD.2.21.1909171611190.3853@planxty>
References: <20190903191321.6762-1-sultan@kerneltoast.com> <alpine.LFD.2.21.1909162356500.10273@planxty> <20190917102436.tn2faq3hcdadybgw@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 17 Sep 2019, Sebastian Andrzej Siewior wrote:

> On 2019-09-16 23:57:32 [+0200], John Kacur wrote:
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Hmmm. I remember this thing came up years ago in the Debian BTS and then
> that backfire module got removed from the Debian package because there
> was no need for it.
> Just to clarify: is there any need to keep this module or do I mix up
> things?
> 
> Sebastian
> 

The cost of carrying the code should anyone wish to revive this is very 
small, and it wouldn't take much effort to get it going again.

It could go either way, I'm fine with carrying it for now.

John
