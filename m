Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31915C88CB2
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Jun 2023 18:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjFLSgP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjFLSgH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2023 14:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39198
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686594923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uC+EwAd9HK5so6LHPTKJJhn4Na8Pw4i2QlUyAuZJk00=;
        b=f5vaptG6Mq6dlEJv9gJ15DxQPOJN6Js1TO20f9g981jRW6ElZ4516Mff0uZZ/Qb+m0IY0K
        INB7+hamUp0wF1pU7qBMFrdpf5i9/AVvRImfjdDr56cxpm2GbWjvE+YghoXUQHEIcG8Jea
        5KyR3ADNiLJ7pdCfeFkLMfHP37ycG64=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-3-bGGbUbOaiVFC2rutuwmg-1; Mon, 12 Jun 2023 14:35:22 -0400
X-MC-Unique: 3-bGGbUbOaiVFC2rutuwmg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6260b40eac6so2537476d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 12 Jun 2023 11:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594921; x=1689186921;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC+EwAd9HK5so6LHPTKJJhn4Na8Pw4i2QlUyAuZJk00=;
        b=kzGhqvbVTomBicBm9AUAPKBAB3wfYlR8UcolQJJq3EtSgu8ozPvpzdNQvV7i5Vh7Ts
         bdthU8gAO1VAaPat5jVron38pyf3v95IHD3klPf4FvkiQnl/DdnT2bcLz3WXcMEYVfCj
         qJhZsOpIHVOKtloxplKIUVTH9T/r5ZoKN5VF0a8JYri+OEEmSiMpfH3TJVbRshHHG9qO
         fztUQGPCoubwILaAQ5omCmPvolrIU2C17qxbLt8ACbe7WtYkhj2AbGTixpFl1fDWUVOL
         ILdkNgZCFrIycb3q9255NblBIuC1hZzDZpQtlBj/mO1ea0xaJi9/vIqoutgz3GRPAL+e
         XWfA==
X-Gm-Message-State: AC+VfDxRomXli190aFnjqdhSYHFdFmDkCRJNMK6zLdXdTw6+50l4k3Am
        F5SkYdYPtTn/S2ddAusRD/aRGxeKgIybXamJ9mcrh8+GLDhdsaNekNP+ev5a/lKuS4Q3fHgmhET
        yMlSay7RZkZntxX6B+QzmmnkjRlw=
X-Received: by 2002:a05:6214:519b:b0:628:7a68:2649 with SMTP id kl27-20020a056214519b00b006287a682649mr12861053qvb.3.1686594921272;
        Mon, 12 Jun 2023 11:35:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ717groeYsnBFGsIEEY7VyFkxXWmAPSiQpsb9XRDUOq3B7UnVe2kjeE8/GCbdX2CP+R2zSLpA==
X-Received: by 2002:a05:6214:519b:b0:628:7a68:2649 with SMTP id kl27-20020a056214519b00b006287a682649mr12861042qvb.3.1686594921059;
        Mon, 12 Jun 2023 11:35:21 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id h23-20020a0cab17000000b005f227de6b1bsm3383644qvb.116.2023.06.12.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:35:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:35:19 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 04/10] rteval: Use f-strings in kernel.py
In-Reply-To: <20230601202734.813515-5-ashelat@redhat.com>
Message-ID: <b7eeb420-3c57-d187-f56d-c732168335cf@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com> <20230601202734.813515-5-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Anubhav Shelat wrote:

> Use f-strings in kernel.py
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  rteval/sysinfo/kernel.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/sysinfo/kernel.py b/rteval/sysinfo/kernel.py
> index f2e9d72ac2ef..ba5cadda40c5 100644
> --- a/rteval/sysinfo/kernel.py
> +++ b/rteval/sysinfo/kernel.py
> @@ -47,8 +47,8 @@ class KernelInfo:
>          policies = {'DLN': 'deadline', 'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
>          ret_kthreads = {}
>          self.__log(Log.DEBUG, "getting kthread status")
> -        cmd = '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('ps')
> -        self.__log(Log.DEBUG, "cmd: %s" % cmd)
> +        cmd = f"{getcmdpath('ps')} -eocommand,pid,policy,rtprio,comm"
> +        self.__log(Log.DEBUG, f"cmd: {cmd}")
>          c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
>          for p in c.stdout:
>              v = p.strip().split()
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

