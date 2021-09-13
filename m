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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274D0C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 05:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E981160F9B
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 05:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhIMFku (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 01:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhIMFkt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 01:40:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900D6C061574
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 22:39:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n4so5049360plh.9
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 22:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8aMNdhDPLzilLTw/dCOLP+x/Qav+HZdOknxDrcisro4=;
        b=T++JBEOxK9ttmFu6ca7XTPBFkRG8h3M0BFjvSbP+TMFLvWfi5AfYYho7qLGFs7sl6g
         Giw7TsLq21+ZSDeMw8+s7bgCKZh7pms7Faa2lF9Ws464U5QAGdWXYklkeKpUa+GTph+6
         iPqAJoztl3vxrIgbmgx/NvJk5AecJO8IbdCxE3nyTA9raEjFI6NDONa4zi0SeZk2/IEl
         c6NoKUki7zGgWavy8SyotaMkURbUmSjQL11jQTm5ulj0yT0WrTnVXwMjtQWsPMorpCuY
         wPGXXCjTHd9pO81vWUJV5H42LH8kePaVktUkPhGlxoFOqMu2mjTECaW9Cyx1PhXF6PsG
         sWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=8aMNdhDPLzilLTw/dCOLP+x/Qav+HZdOknxDrcisro4=;
        b=lLbP+hm7n+Pn8KR48jDu2QRBAp5OE5Mx4tnU9/8EUvMYpgMApeqieQ/PBu1u9wTRex
         oYPlGxmGWv44GLPSuerhRdJfyIOYPsTKRyZ2hjm3ounfIEjjZgjm9ca/Sx2Qe74E/FFK
         A7ZgnLxuUO28vOHEOtw50VVDxOpBmw2INqgyvAynJXUE76ayZgmEcasUdVfrzQcIr1xQ
         E5mfsDExxONeMEhVkJkBz7g6LN7QEpDQyC2hZ8qdOJGTM4lT6xx5CFt86Jojpnun0EAc
         xDt/x5aUD/E/28Oh0fV9IMkMSUpTrz86rh4jmNSOZ3NCZqM3t8VYlYzVRwidOEw2mSKG
         aT+A==
X-Gm-Message-State: AOAM533+LYMmbNtMETUI1+HUGacHIZFVgFCXVB1lSy8n4+2MaVNFVskc
        lGiwbUj+I9sabsNphh/Eq9o=
X-Google-Smtp-Source: ABdhPJzZI1G1CNJOz3MI0/IGCzaRrjg811LfojMZtn6HYxvjS2fTStzzejwJ8HVeijnPiSiJDbjw5A==
X-Received: by 2002:a17:902:834b:b0:13a:347b:8a00 with SMTP id z11-20020a170902834b00b0013a347b8a00mr9124545pln.54.1631511573964;
        Sun, 12 Sep 2021 22:39:33 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id r4sm5286104pjm.50.2021.09.12.22.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 22:39:33 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/3] rteval: Only process warnings if dmidecode_loaded
 is True
References: <20210909130314.6109-1-jkacur@redhat.com>
Date:   Mon, 13 Sep 2021 14:39:30 +0900
In-Reply-To: <20210909130314.6109-1-jkacur@redhat.com> (John Kacur's message
        of "Thu, 9 Sep 2021 09:03:12 -0400")
Message-ID: <87pmtd9gq5.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> If python-dmidecode is not available, then you can't test hasattr
> or you will get a NameError. Simply return instead.
>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  rteval/sysinfo/dmi.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
> index bd397360096a..80cf3c723b36 100644
> --- a/rteval/sysinfo/dmi.py
> +++ b/rteval/sysinfo/dmi.py
> @@ -42,6 +42,9 @@ except ModuleNotFoundError:
>  def ProcessWarnings():
>      """ Process Warnings from dmidecode """
>  
> +    if not dmidecode_loaded:
> +        return
> +
>      if not hasattr(dmidecode, 'get_warnings'):
>          return

Tested after purging python3-dmidecode package on Debian.

Tested-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Thanks,
Punit
