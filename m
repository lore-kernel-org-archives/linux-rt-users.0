Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87AECAAD8
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Sep 2022 20:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiIPUF6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIPUF5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Sep 2022 16:05:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F11986727
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Sep 2022 13:05:56 -0700 (PDT)
Date:   Fri, 16 Sep 2022 22:05:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663358754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/CpW9yjYIlm74xasgX9nUbAOuab8lYt8Os54csP+ZA=;
        b=gotPXLFvGZ1qlj1r2UvAcmvIXFYapmUkFBTbFXfK4oqQC4b7dmDAqdm3Yy+816Xq58CqWs
        oE7B7Jsr++juA3LsSGoSW2E4rX85XsYHTfg9TYTlws7rnqga6uNCxJoigjZxJzeQBSx6zx
        rCNHnFUdHJBRNuIbA/oLp2MB2BmWlYoOZYYwQXqGcos2VuzbFoobKI7+VYXaD8FsKm85dI
        JtyJHkek61uXsf+I7pJOqmAgdk+wxVH1w3qjBbeDJm2MXJWXFghbbJOZIlbnLmDDkMPS8l
        WZgtLOm90XxyXRFRzGpz8IxYYvE1eNw8xqggKRAbQQ1rH4IIfm1QNcoF1gzT1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663358754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O/CpW9yjYIlm74xasgX9nUbAOuab8lYt8Os54csP+ZA=;
        b=1eVqowP/7uwyqtV/gM40XEfAZMHrUpAGs/Lzd13nn0wIT0nHMO9l98IUTRYDw0PzuJbnqp
        4H9FMpXy4PDbdLDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Danilo Cezar Zanella <danilo.zanella@iag.usp.br>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Exception in function_graph tracing
Message-ID: <YyTXIUjq9tmFPTDi@linutronix.de>
References: <CAAxUTH4zpibkhOS+NPzcYsXFqx1bJfSU19gdt0eCAOrpWAkinA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAxUTH4zpibkhOS+NPzcYsXFqx1bJfSU19gdt0eCAOrpWAkinA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-09-13 16:21:27 [-0300], Danilo Cezar Zanella wrote:
> Hi
Hi,

> I'm getting the following error message when I set the current_tracer
> to function_graph. Procedures:
>=20
> cd / sys/kernel/tracing
> echo function_graph > current_tracer
>=20
> Then I saw the following message in the console.
>=20
> Unable to handle kernel paging request at virtual address fffffffc
=E2=80=A6
> What is going on?
> Am I doing something wrong?

No, not as far I can tell. It looks like the function_graph tracer is
busted in v4.19 even without the PREEMPT_RT patch. The function tracer
seems to work.

> Thanks
>=20
> Danilo

Sebastian
