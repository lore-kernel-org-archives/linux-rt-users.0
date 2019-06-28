Return-Path: <SRS0=OCyy=U3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C668AC4321A
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 06:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9993E2086D
	for <linux-rt-users@archiver.kernel.org>; Fri, 28 Jun 2019 06:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJKlctcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfF1GFY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:05:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40888 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfF1GFY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Jun 2019 02:05:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so5083076qtn.7
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jun 2019 23:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=E+T/QzURGUpcgb9CQyPWwTmYEyHDVMThR195zUj1KVw=;
        b=WJKlctclikYTznpELiMXV1DE5gsCdqA+cKInXAe/vMb92HtLuqPMBg/8tFkdCusG1S
         o5Qa8MTsHooqAzg65xYJW8A3gAO2W5z1UXpKT/otVn8Zy0AwEVNLojK67GljYLr9VbOg
         6fOm5x3peBgXGwvVZcJR2RzFl6hALD6WKecVvxqUEnj9nBe3A66PY68QwXN6e3LvR5Xq
         90StYkY2W7JDktbi+o/jzlJnLAWWIq0IBWmBPIaEoevx2oG8JpN1cNuWzLZCmpwpL+Gq
         BmrmMzzh3oCatjcqacaGv3wXf/Xy9l5gyGE72SuOhEMwhwAMfvPQD5QYF1xklTrjN6Hy
         8UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E+T/QzURGUpcgb9CQyPWwTmYEyHDVMThR195zUj1KVw=;
        b=ANQGM7y9awjcDCyDO61EXiWAhBWwJBh2OwzDH8cIw8TVgkKv7R/2LphUE9Nv0nVoTM
         Am0FRgf4yWTaguffNCfVbzNuLCUp+15gZtbLXaPBnU+Xo32V5ekAVdUHP+BljPZYY+Kb
         RqGtpUr2/CWinB+A1MrZAw9GCbJla0ZR3FGahsek7vDUqeKuRHef0HFp9Xpg58KOqyhV
         eeijNuqbeN2e486U9Ifj5TdUFtNI8XE8Cyz1crosCpC2NezDXJgZ/Paxe9CDP/HtMhfw
         wkVPd/2iBQgX18uOvrz9ztZdSwZM0AFeNacjgRuWpwb+BvXHXq+cLLvDwzT8GC+Goq9L
         H8IA==
X-Gm-Message-State: APjAAAXDCc6IN8SgvZHDiZycAPQ3OIdB/+i/9JxQtWSE/iYTa5lmSVlE
        U4tdx8JvfJPMApBKdXXB9Ah8cdIrSLga6lYXD+MK/vby
X-Google-Smtp-Source: APXvYqydy7o5Egj4l6qlNu5KKR6oaVfaIxTgz/ai+pbe5+EY8y9zTF5OBKaua0owE5GBuvrX6paLrWg2YrLeMoZJNao=
X-Received: by 2002:ac8:2f43:: with SMTP id k3mr6710908qta.179.1561701923787;
 Thu, 27 Jun 2019 23:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
In-Reply-To: <20190626161843.2c6r2dxeoxeyxce7@linutronix.de>
From:   Arve Barsnes <arve.barsnes@gmail.com>
Date:   Fri, 28 Jun 2019 08:05:12 +0200
Message-ID: <CAJjrzcVMJRya42sZbVsiiHh2dv=Wuy-OouqesfjxUMG9bK1LkQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.0.21-rt14
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 26 Jun 2019 at 18:19, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Dear RT folks!
>
> I'm pleased to announce the v5.0.21-rt14 patch set.
>
> Changes since v5.0.21-rt13:
>
>   - Fix a "scheduling while atomic" in zswap. Patch by Luis Claudio R.
>     Goncalves.
>
>   - Replace a fix for for wait_for_completion() (introduced in
>     v5.0.14-rt9) by an alternative version as suggested by Peter
>     Zijlstra.
>
>   - Major futex/rtmutex surgery. He Zhe reported that glibc's
>     tst-robustpi8.c triggers a BUG() statement. To address that bug the
>     hash bucket has been made a raw_spinlock_t.
>
>   - Two x86 FPU patches from upstream to avoid fallout on 32bit and with
>     CRIU.
>
> Known issues
>      - rcutorture is currently broken on -RT. Reported by Juri Lelli.

This does not boot for me, using the same kernel config as for
5.0.21-rt13, which works as normal.

At boot it seems to hang for a while, before throwing an error, so
this seems to be a timeout problem of some sort.

I don't know if this helps:

Call Trace:
 d_alloc_parallel+0x1c9/0x410
 __lookup_slow+0x66/0x150
 lookup_slow+0x31/0x50
 walk_component+0x1bf/0x340
 link_path_walk.part.0+0x2c1/0x540
 path_openat+0xa4/0x1590
 do_filp_open+0x8c/0x100
 ? _cond_resched+0x10/0x20
 ? _kmalloc_track_caller+0x167/0x200
 do_open_execat+0x76/0x190
 __do_execve_file.isra.0+0x6ad/0x890
 ? kmemdup+0x20/0x30
 ? umh_complete+0x30/0x30
 do_execve+0x1c/0x20
 call_usermodehelper_exec_async+0x17b/0x1a0
 ret_from_fork+0x35/0x40

Regards,
Arve
