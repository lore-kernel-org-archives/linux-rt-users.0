Return-Path: <SRS0=m88/=7S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BDBC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 10:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEE52075B
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 10:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNbyLPCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgFEKMm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFEKMm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jun 2020 06:12:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5122C08C5C2;
        Fri,  5 Jun 2020 03:12:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y13so9490399eju.2;
        Fri, 05 Jun 2020 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gmla3jz6Kkr9uVaBKzvCnpBi+8IppeZfJDcPG5ZX28U=;
        b=WNbyLPCRsJmf1YlpyWo1p7SVjWu10iT+AetIv5DsyVOLJfZ4Nk5sopUPSo3dKsGrU1
         0jSDv1crDK7hxBLc5oGC5m30fmptu5zJLK+9lUC7dgv8w2pxN25Vjbr5TJK3EorEIsi1
         VgoIWkA2W9M6DcN0M27tm8/1/aMgGtBFSul5+ZXl0zDsBGBYvJnAigWMWaxJgI+s3V5f
         6ZDmPRzAw6nEMJ/xIoFMVqm9TrZqK0eN+ZpkYecJmyZuOb5kU/Nw7yTQCivwfzF8cR9M
         QkOyfu7omWazlrN49f6Q5cpf34OMvyuxMtsubcIBCKWoNGDevE2QuiWYjtE6vFKdhVo2
         B1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gmla3jz6Kkr9uVaBKzvCnpBi+8IppeZfJDcPG5ZX28U=;
        b=E/7M08P6HhExOXytnFWMu9lycMTZoUrgerdOeYDN3F3p3sqX3zA/oXMR9NgCYRb4BA
         dSnAg556lGArARYfZtMUbN1sWfrjbYF+pm5deTJcvAzEmHMshQa1G5UtuknFtBN/cibH
         u/qpAjwnkhyOFbjYwQq6f3AmiyhJeMKoj1w8TgAFKdQlemLVqZ2ODa35WZwaaTknyeWZ
         YxoQ7aIjhz7bUEsrdON2iNbRopH+XZuIl9wgJONJTDEAjxxQQBdZJNgcgoXPHwz5yFAQ
         JaMt7sLHJgZwI7ecgQws+V9knbQ5zBJkZOmzSDEsTfgAeXXV7UOCWOMgZvN+CM7irrmc
         3OCg==
X-Gm-Message-State: AOAM533/M4JCIVVn6SK0H3rUo9Cmxj5gbIkQiI5Acivy2YVaGOXGS0z2
        Fl+o7FQ2i915SDBPlu0nsxfkHguPPKM66cAzT0o=
X-Google-Smtp-Source: ABdhPJxtUUhL5yN4OVcYr8Ri88ijWHipQ1pLLHkzK1pCS6nlAamgs/eIS5Qs17Y0fonXqMGA7PRFrzF29Mb4sYrdqv4=
X-Received: by 2002:a17:906:198d:: with SMTP id g13mr7814691ejd.281.1591351959507;
 Fri, 05 Jun 2020 03:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com> <20200605032014.GA4455@paulmck-ThinkPad-P72>
In-Reply-To: <20200605032014.GA4455@paulmck-ThinkPad-P72>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Fri, 5 Jun 2020 13:12:28 +0300
Message-ID: <CA+h21hrR8OER0E7tve04w4WJur03YmMMQ=Tk_kDfAkpysBPjFw@mail.gmail.com>
Subject: Re: stress-ng --hrtimers hangs system
To:     paulmck@kernel.org
Cc:     linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Paul,

On Fri, 5 Jun 2020 at 06:20, Paul E. McKenney <paulmck@kernel.org> wrote:
>

>
> That agrees with my interpretation of the stall warning message.
>
> On the rest, I must defer to others.
>
>                                                         Thanx, Paul
>

Thanks, always good to have a confirmation from you!
FWIW, the system has survived an overnight run with
sched_rt_runtime_us set to 80%, I don't know if there's more to it.

Regards,
-Vladimir
