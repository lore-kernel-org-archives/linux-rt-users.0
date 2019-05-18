Return-Path: <SRS0=xO9Y=TS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC74C04AAF
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 May 2019 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1222087B
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 May 2019 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ietaJiHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfERQ1r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 18 May 2019 12:27:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40345 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbfERQ1r (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 18 May 2019 12:27:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id d4so3884420uaj.7
        for <linux-rt-users@vger.kernel.org>; Sat, 18 May 2019 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6XA1DC3gHnj+izQfKSX0Mwr78JnzIMK0cjbsYwQbEo4=;
        b=ietaJiHj18mI/l13gnEjz0rfg0jI1Hpk8IQ7djbauFztIYWrVqLVu96Xndit8luNFa
         BOS7ObuCUUMceGRgKPRPKDvKNUggRgtBDelfVaSef1yei0s/Fpd/cIGvD7OrsGBMefI2
         17qOV+SnOqqpOScQD8wYr5h6/DuQb0zG/dDPQi3yAcM8FFjiJh/B8kFCctG0NcoywjL3
         Wjba7JD421TkAzFbzEzOGaQs8vUDl78+2oYRrFPpwq76MZhPyvximD2pYmOneRi2CQf1
         cygGksy5IW/FymF3mLX38bo2n5wKjxA14NPfCCPxdwZAPJaOLjguCX3gxs+TvIP1Wz0A
         LqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6XA1DC3gHnj+izQfKSX0Mwr78JnzIMK0cjbsYwQbEo4=;
        b=QWodQ6WPSjgmc2SMGWoIv58fnf+fnmt4Y3lxG61cJPN5x8Fz5kyCbfRIVehJQSjdPb
         J8HuiN9ZzVJcMa5UwZy7UITCiKnWcIOW0nZAXX0HTN3ltKZcDjFbFDIs7Z5loufpLccc
         as9UPccUqr1fNZ+xws/QTM1TRtz+5OAvZvN5VnPqx0oZwrJUPON45vw0q7L0CfwwS/bm
         pa4jm2CYYu/URjAnvAGQmhrI4hcWVQtqjyeQltpmh3fHaWGnUPjzL8EU5S/Ek57Npgdl
         HyT8pqckyBLjpJdf964jrbcqgIl8KgTYiI8EFkdOY00to73oe2Sb/F3+ealgs5pyxlbR
         XKkg==
X-Gm-Message-State: APjAAAUNA+n9FsQGNjojjfIw/gsLeDyf4neBQHbc2AFk0Amj+Q1UjkcK
        hRfi+YWY4GoU81hx6Z3byyEQHca5S2TgzW/k3TBZeMVYXEY=
X-Google-Smtp-Source: APXvYqw4K71BlKOEs2FgReLHTumd+RfU8lvMkrTpZGzW7Es0Stms2/Ct2zx2/d28YGMfT5LAa5bmPY7TfGQZOHD1a7M=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr3954926uab.40.1558196866049;
 Sat, 18 May 2019 09:27:46 -0700 (PDT)
MIME-Version: 1.0
From:   Shawn Landden <slandden@gmail.com>
Date:   Sat, 18 May 2019 11:27:34 -0500
Message-ID: <CA+49okpOX5-N33BLPEEeBTW4Wcn7sBWog7cBNT=ENLvOZ_MKVQ@mail.gmail.com>
Subject: Allowing SIMD in kernel mode without disabling preemption
To:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I ported the x86 approach to allowing SIMD in kernel mode, even in an
interrupt, to powerpc[1], but I couldn't help wonder if it would be
possible without disabling preemption.

The scheduler just has to check the per-cpu in_kernel_fpu, and if it
is set, save the fpu state of the kernel thread, similar to what is
done for user-space threads with use_mode().

This way WireGuard would be fast even on preempt-rt kernels (it
currently turns off SIMD on them). Other crypto in the kernel is
woorse, and just unconditionally turns off preempt for each block of
data (look at arch/x86/crypto/chacha_glue.c ). Note that
kernel_fpu_begin() disables preemption, but I don't believe it has to.

Is there any complications with this approach that I am missing?

-Shawn Landden

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-May/190704.html
