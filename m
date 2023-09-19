Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E34CD3435
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Sep 2023 04:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjISECw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Sep 2023 00:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjISECv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Sep 2023 00:02:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB0DFD;
        Mon, 18 Sep 2023 21:02:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-578a3069f1eso748741a12.1;
        Mon, 18 Sep 2023 21:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695096166; x=1695700966; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alx+2MuWN41HhyE2x8kbrjTxvAUn40IVJk0e71UdPo4=;
        b=ErRrOR/FqIoNNMuwtHKaGmg35bbxikZOT42pG1a9yfAYat/gw0cGd4Xdh+JRnUR3wc
         vIocA5JqiTOzFHHfat75DwI7ix7NTOrOQOissZkncoceRyuVidX0IHORAaz9S1xxxKWN
         tPQZL6iMt94To5JdvCm8he5eUpy7qvvo9aFXHQFOLTpEmUUAcGdxkoED0mXw8NJV55PF
         W7WIHJHIGQNHntlYEZzSThJuVd0dFxj4MYiFkKJ0agBcTBY+FMsLWADqd9MSsu+WVAl/
         926ry6ZwPGBzSGAeLh7x2etf6CPf+3kxw2OgRxeeaUDGcRnuIm0NCif5YcI3JPRm4HeP
         jHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695096166; x=1695700966;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alx+2MuWN41HhyE2x8kbrjTxvAUn40IVJk0e71UdPo4=;
        b=Xo7AHTsNAJMemJ6C/fTvwQAKGJUgDOxdcaK+KIbyoQhd+bvaeUqyPjizRqSwXSynhA
         wsIFYTDRIUe7ubGiJ+sxMY8BSqI3umnolExqMJcJgK07sGjqorJvKV45hAJAOIS0WRdY
         QccWM5jiBwMqtqZXU7Dpw/YHHXMM+Bv/KIRo1EfTZ5DdAEpd0jj25K6SALvgFMNUu2b8
         1EALuzI6aY6LQHXmY5mfKwNc0ltxedX2jbeMfs3JtWXTv6w+Ej7h4LPwWEEzonwXYAk5
         mL7f/W++imWS3ZXchIAaaIyoVZEUwsP59ZCHIszcY5TQO/v92pWWTtrh4sCtEyc0v6kQ
         GLuA==
X-Gm-Message-State: AOJu0YyQc4/RKNbe4xo3vfKCYgdk2uj2wvEK51+2B0VkAPwLKDDQXdoU
        h/JBIITk5jnSJPhrxKsMkLI=
X-Google-Smtp-Source: AGHT+IGWNxO5IbS2lhd33UVyJK93tGxLypjLjrUvmIXcHYHrcvpQV72dRDq3ROAtaLn8Df2QEy4YEw==
X-Received: by 2002:a05:6a21:9989:b0:140:253b:b658 with SMTP id ve9-20020a056a21998900b00140253bb658mr11243738pzb.57.1695096165688;
        Mon, 18 Sep 2023 21:02:45 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a26-20020aa780da000000b0068fe6ad4e18sm7798708pfn.157.2023.09.18.21.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 21:02:44 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:02:41 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Clark Williams <clrkwllms@kernel.org>
Cc:     stable-rt@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Please help backport 3c107f36db06 selftests/net: mv bpf/nat6to4.c to
 net folder to v6.1-rt
Message-ID: <ZQkdYYWScEnqagU1@Laptop-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Clark,

Is it OK to backport 3c107f36db06 ("selftests/net: mv bpf/nat6to4.c to net folder")
to v6.1-rt? The selftest always failed[1] with error like "./nat6to4.o: Permission denied".
The issue has been fixed and backported to all stable kernels except v6.1-rt[2].

https://datawarehouse.cki-project.org/issue/1758
https://datawarehouse.cki-project.org/kcidb/checkouts/104785#issue-1758

Thanks
Hangbin
