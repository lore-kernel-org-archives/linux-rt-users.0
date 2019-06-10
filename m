Return-Path: <SRS0=SGFR=UJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646ECC43218
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 20:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339E620820
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jun 2019 20:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZf3koNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbfFJUwo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:52:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38347 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbfFJUwo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jun 2019 16:52:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so7288266oie.5
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jun 2019 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WHn2nagzQwLb+1g15tnhy8D69l9E2Gu5mUEqQ5Kn1e8=;
        b=rZf3koNx3lXkqSX+VRQi4Jo/bXtL7PaIS9a9ZkWFxlma7pWOTqm2irKlUXcXobVnN0
         eVp4upAmdT2TO6FqtjMjchsueoTJU9hLz6BUundpQuBWY0FaFLLGAAxNXGVl8Md8klwE
         ZgArm0JVcxiI12cAL+qYv2JGPPImwKOM/fbzdGtNYwjn5MJkr0isLRKrKuzZdh2Q+hK/
         Eqtht793jEi40ee8GncDIHbB9Ri2r6AShYomKgjmksKzBpKrKx0hGLAbda14Hj7BPcwV
         ySN6rnyN5n01uLuAWJmukLhXUKqehnlptst0uipt4qIwJnFBgBqUHIUoxAlYbVcBcUmq
         y+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WHn2nagzQwLb+1g15tnhy8D69l9E2Gu5mUEqQ5Kn1e8=;
        b=m68SaAB39ikFAUdX9gioq2ckUiO6feun2iax45zb+yWOBVFIGZzwyrdvGSK8DXWEwm
         Hopglfu8TezmdywsWu31nrUMDVoQJTUUOTk18bKFfp+a+aWvBixjDbNZY7Ncylzissbi
         uJJH5/EvmTLbFENYzGTTg67bihmUWQ53z3yIHYJd7b/4pHKi9kv3IlNpUciygfD2vSUx
         xJqYZ9ub1HrttRSpeiyirj9DozVcEbAkgpwecXXIXOgeUTVjN2LtdOPQ5Yb7m2PkmCZr
         C0bcGvFXN/q28s9Nhccp0EW5G6/xcO/rypL4FL1Ew+WX5WY0gsh7nO009+6q0ldTvF3l
         nC+g==
X-Gm-Message-State: APjAAAV3pP2ZdrOvJI/jH6VYHMXWt/a4hsA+CBgdHXeAls9nLCjG62cI
        ypY/mmhv0s+Ve1m1+rTvmk3lAs6oaYSN6m3S3ZgEjR+Jpfc=
X-Google-Smtp-Source: APXvYqy2Bwk1LRAd+LorzdVd6MjLB48OsIepMQgIPZwGJKEVbX4lDqp3Jd141fdiA9b+pt0rm/h1qNc7Ry9ho/VyJBc=
X-Received: by 2002:aca:bfc3:: with SMTP id p186mr7295937oif.107.1560199962985;
 Mon, 10 Jun 2019 13:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
In-Reply-To: <CAM5Ud7P2U2F8eTmm8geKomo2XEOP0MwDsdvp9Zxq-Xk3VhwZxw@mail.gmail.com>
From:   Alec Ari <neotheuser@gmail.com>
Date:   Mon, 10 Jun 2019 15:52:32 -0500
Message-ID: <CAM5Ud7OHEJd6ec798ryWH2LbQz3AYu+Zb68BY4GL_KF+toJfcQ@mail.gmail.com>
Subject: Re: EFI_STUB doesn't work if PREEMPT_RT
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I should note, I'm using this PREEMPT_RT kernel:

linux-image-4.19.0-5-rt-amd64 (4.19.37-3)

When building the kernel myself, I used the linux-5.0.y-rt git branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-5.0.y-rt

Alec
