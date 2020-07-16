Return-Path: <SRS0=vtwn=A3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E20C433E5
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8355A2074B
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jul 2020 13:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+CHDMGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgGPNEZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgGPNEZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jul 2020 09:04:25 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20995C061755
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 06:04:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c7so1733266uap.0
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2020 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oi4DIrXnzNzQ5ZyA1cvK/p3EIijpd8ykpkJ+JZfklOk=;
        b=R+CHDMGszW+/cumSKs6oY3KunQsv+l0cu8CoJ1eyarc/5vG6hHy7BvFDHuSw3uSJLe
         vFr/QRA1gIYxbUt7zJUmTluI3Zw+rfW+y0gkmqrzo9lfC2/dQfW5DBd7dypbU2xgVJfi
         L0IFCVIdpzf+O7NeL/VE6kx3GhV1PeGDGj8zYVfQMO6mRvxNW7QaID3Kz7fN726ZtI+m
         mI6WAjAPO7gdyCuRp7Mu6C4853dNTnlO+/tvybQHeH1K1PaMoAEqn5LWdA9yqE108QDd
         glLQKUvcS27gr202xjE7NHKxHQcHUqBWgXcYYHb08/QFuwJL0yfPJ4yq1ChkF7IeSLDq
         GnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oi4DIrXnzNzQ5ZyA1cvK/p3EIijpd8ykpkJ+JZfklOk=;
        b=sOs2WXyJF3NNHIAa+RRxT77jUa21aCPbfNtQNwZgx+aXZ0jZQoF+F7qqvGsCNld8vH
         fp7FIq+RTtKOjYdJEfwBq7Tl9B5GbwehB0EJGv6pjM2Rj+Kcx1GHRS39c1EF6KqL93ft
         NnQPlHufW5bGasy2rZ8pWBGlHx2qUXZDRJDKwNvHxqQ3YRJ9YM+ADtVu0sbTQVCNKbv1
         hkSPoU7IRkRwBql7JGkcESuo7/KeVn4zohK9PyTL+/4yNZCnXALNv+TULuaIJzEEh4Mw
         PqQgrJeK6AVlhdlLSDn6gv5ibze8MBPyq7DnkxWZqasHcmYIysB/103fsZ7v3xKK/Yyq
         wIlw==
X-Gm-Message-State: AOAM533SuAMfrdrULCwrtWcjTZRAMVqnokNUuiMuSULNl+IT1uTDGcrA
        bTTm29hKzxks6wusYwaPfW6gn6JTlp/M7b3jGJgcxvyH
X-Google-Smtp-Source: ABdhPJzob9llZOr5+NOSWzWehlMOV+u2CGpQfysu/ut5OYGAuqH5DBeK8r2PhzdiiSnX5GPB5uaq4HyMZK0s57Z6C0A=
X-Received: by 2002:ab0:7811:: with SMTP id x17mr3127867uaq.140.1594904664208;
 Thu, 16 Jul 2020 06:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFpOueS0rvys4Q81D3HEYX2U1vM808qQ4w+z6QxCWi1KJBGXXQ@mail.gmail.com>
 <20200713212054.2e675557@oasis.local.home> <CAFpOueRmBfzhPFb-q_pB1xpCQq4Cuo7rCCsc2eUPsGdaei-+3A@mail.gmail.com>
 <20200715153632.3f9dc5d3@oasis.local.home>
In-Reply-To: <20200715153632.3f9dc5d3@oasis.local.home>
From:   Itai Handler <itai.handler@gmail.com>
Date:   Thu, 16 Jul 2020 16:04:12 +0300
Message-ID: <CAFpOueQ1g1puaDBnmda6ZXq4sEXBjOBHr=m09-DEX9EvdwAQPg@mail.gmail.com>
Subject: Re: aarch64 boot time increases with rt
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Steven,

On Wed, Jul 15, 2020 at 10:36 PM Steven Rostedt <rostedt@goodmis.org> wrote:

> To rule out that this may be an issue with the function_graph tracer,
> can you also try it with:
>
>  ftrace=function ftrace_filter=worqueue_prepare_cpu
>
> And see if the function tracer shows anything.
>
> /me just looked at the code.
>
> Yes, the function tracer is set up to trace really early, but the
> function_graph tracer is initialized by core_initcall(), which is much
> later.
>
> Perhaps try this patch (note, it's from latest mainline):
>
> And retry the function_graph tracer.

With this patch, the function graph tracer doesn't work at boot time.
Please see the log below:

# mount -t debugfs debugfs /sys/kernel/debug/
# cd /sys/kernel/debug/tracing/trace
# cat current_tracer
nop

Note that I tested it both on 5.4.47-rt28 and 5.6.19-rt11 (but not on
latest mainline).

Regarding the function tracer, you were correct: it can trace
workqueue_prepare_cpu
without any issue.

Thank you,
Itai Handler
