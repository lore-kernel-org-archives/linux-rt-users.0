Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29198C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 May 2022 23:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349338AbiEKXXV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 May 2022 19:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349292AbiEKXXC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 May 2022 19:23:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B322A8A6
        for <linux-rt-users@vger.kernel.org>; Wed, 11 May 2022 16:19:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652311183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwVUL4BmngtW9b7VtyfXKdAtTlSO+OLvKSAXi2GFoTU=;
        b=RzncLUo8jrV8gdiBFvgEBsU9XZO/hA+kmIlN4yUu2yRoz8zAvkcBYo+WkuGnuyub1i0IqW
        GmCQ8hI98Pg7rqbXJDxrPQm/lxad4m7kQEFP0iY6oaib3q+KaPadh1xH9xLzBqM2bxbskq
        cDv7jGKp4F+JWFAPAK0dtHqNMKY3iThca02Mb9eXeqiwMtBtenGoTJ2OSX9WPeHftX1SV1
        QHA0xziOeHBfOp9xU6BfSqd9ujSC5xKMvLspUKCGcYOM2Jes8WlhpYmy3d7TJALMV9WIKG
        WKF2ToQA7fyzfL/3D0TMpQthOV+deDWMoAwPHB+VntdzsopzrPEVyK1ux0oVCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652311183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwVUL4BmngtW9b7VtyfXKdAtTlSO+OLvKSAXi2GFoTU=;
        b=MnGcAGzxkut/wFHqVrQRbytIyrkra+u8OJrF5YUe1UizeDMTRbCEcwZrqfSVbvQDltuKae
        iRonZXCoDyHJvQDA==
To:     Yimin Deng <yimin11.deng@gmail.com>, linux-rt-users@vger.kernel.org
Subject: Re: Oops or bad page in page_alloc.c
In-Reply-To: <CAAh1qtktzZQxXp_t43YhxL6FZTS58rn_xvK2Zrq33-s3=j_sGQ@mail.gmail.com>
References: <CAAh1qtktzZQxXp_t43YhxL6FZTS58rn_xvK2Zrq33-s3=j_sGQ@mail.gmail.com>
Date:   Thu, 12 May 2022 01:19:43 +0200
Message-ID: <875ymby7w0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, May 09 2022 at 15:40, Yimin Deng wrote:
> I encountered an oops in isolate_pcp_pages() and a bad page in
> get_page_from_freelist().
>
> linux: 3.12.37-rt51  (CONFIG_PREEMPT_RT_BASE not enabled)

The 3.12 kernel series went out of maintenance five years ago
with version 3.12.74-rt99.

    https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

> [18857089.275357] CPU: 1 PID: 10357 Comm: appmon.sh Tainted: G   O 3.12.37-rt51 #1

    https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html

Thanks,

        tglx
