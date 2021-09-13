Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C3C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 02:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8566108B
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 02:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhIMCzI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 22:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbhIMCzH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 22:55:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A25C061574
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 19:53:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 18so7440670pfh.9
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 19:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FPUAGtbwbn4kjBuCZISa6fV/xHEVlcFRDihnGPxqm7o=;
        b=jWHuU9wHSkt+CCZdihQR8hucyMXjEO/S4fhnFMZU7Lq5O8uwBcHBf6lVtAdqJXPM+g
         Ndps/Or64GbVxTjY1c/fcNulWk9b2N5C+eFML8DIB1Tb1hJrykR8KQfS4Ks/eS7co3GN
         sDWikAdR8fmIslNK83XMSPaM6/7s3577j3u988xh9zkUSoS++V150n5bkP3oNPlCyxK8
         LzLjOueakql+KPJLSQGMwcqztRXIkeOLSqqMvJb86N1cPpcnzqnjpTfcRDLnK7+SelGz
         3Lhq/bTN+qxN3L3GkZVv9kqmzcy/uGpvvoFqF+W0F/4NHh/PBMPY3xH///Q6473JfelK
         MZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FPUAGtbwbn4kjBuCZISa6fV/xHEVlcFRDihnGPxqm7o=;
        b=I3fSQLxakKkBHlohyqpp29uIfgdmhH71u8za2MuUVLD8lAm2QzroOVzJW6hAKN+4hV
         AF9zHibjYq9OHIU/qqbSxfqjKz5YvkIuw9lTY3lU3GFiBxKbmWY/ne4Z29kudsjH3Pyh
         Cm4eZn39S3YU6SEl81wKKSrHwUFd5zFrZ+p4UtFhriobW+0oE0Ucvrrk+a8c7kHD8ubS
         pShXxyV2oKGpwzj6D/9IV6Sp9YdV+EqWzwxoic6LT78xP5LtbfOzrdpjRRjMony3lG6d
         sV+/OxcZ1Eaf/vk5IhANVdberiFxhEqUDyQUZcY/TrD/RBsxRgpVQXvD+xD7T1oitjWb
         jGEA==
X-Gm-Message-State: AOAM533hAnaeLKXCWNWyJ/jaZ1SLvyVxSHIqoDVQmND5xNy393/em5Yu
        lzw6l2dblaYdDquU+/Nc/xsfoFa1RLU=
X-Google-Smtp-Source: ABdhPJwPCUIs1jmUxjgeBuuqkFOQbu1mwCCBIwYLCt+2xbnahtU/C6f4Zt6MRb4YaUJtDGSkj2xhzA==
X-Received: by 2002:a63:798c:: with SMTP id u134mr9239492pgc.479.1631501632130;
        Sun, 12 Sep 2021 19:53:52 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id f8sm1937834pjs.43.2021.09.12.19.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 19:53:51 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH 2/5 V2] rteval: Construct a 'model name' on
 architectures that don't have one
References: <20210912154538.255217-1-jkacur@redhat.com>
Date:   Mon, 13 Sep 2021 11:53:49 +0900
In-Reply-To: <20210912154538.255217-1-jkacur@redhat.com> (John Kacur's message
        of "Sun, 12 Sep 2021 11:45:38 -0400")
Message-ID: <87tuip9oea.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

John Kacur <jkacur@redhat.com> writes:

> This is based on an idea from Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>
> On architectures that lack 'model name' in /proc/cpuinfo
> create 'model name' Unknown when creating the per core dictionaries
> in cpuinfo
>
> For arm, we can construct the 'model name' from the
> 'CPU implementer'
> 'CPU architecture'
> 'CPU variant'
> 'CPU part'
> 'CPU revision'
>
> Suggested-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  rteval/misc.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/rteval/misc.py b/rteval/misc.py
> index 0dd361ff19fd..c1d2a972430d 100644
> --- a/rteval/misc.py
> +++ b/rteval/misc.py
> @@ -77,6 +77,27 @@ def cpuinfo():
>              info[core] = {}
>              continue
>          info[core][key] = val
> +
> +    for (core, pcdict) in info.items():
> +        if not 'model name' in pcdict:
> +            # On Arm CPU implementer is present
> +            # Construct the model_name from the following fields
> +            if 'CPU implementer' in pcdict:
> +                model_name = [pcdict.get('CPU implementer')]
> +                model_name.append(pcdict.get('CPU architecture'))
> +                model_name.append(pcdict.get('CPU variant'))
> +                model_name.append(pcdict.get('CPU part'))
> +                model_name.append(pcdict.get('CPU revision', ''))

Is there a reason to use an empty default for "CPU revision" but not for
the other components? Maybe a left-over from original patch.

> +
> +                # If a list item is None, remove it
> +                model_name = [name for name in model_name if name]
> +
> +                # Convert the model_name list into a string
> +                model_name = " ".join(model_name)
> +                pcdict['model name'] = model_name
> +            else:
> +                pcdict['model name'] = 'Unknown'
> +
>      return info
>  
>  if __name__ == "__main__":

With the above comment addressed, fwiw -

Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Tested-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Thanks,
Punit
