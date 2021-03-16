Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48ADC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 01:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF26500A
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 01:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhCPB5o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Mar 2021 21:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhCPB5f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Mar 2021 21:57:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27BC06174A;
        Mon, 15 Mar 2021 18:57:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mm21so69488110ejb.12;
        Mon, 15 Mar 2021 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mZONlEy59OWMKG3t+lg7eRVboIUI1y2SSKzs63Sul+M=;
        b=cCoRD2RehfuNj1k/N8CaHFbOvX3DnhBJfxsa3eaqwgp1NhyfzshaY9xPxqskidrsn+
         VGFkQOBHOHmywzQYAuOsw8WowchrbIVPFVWCTCOQ5uooPQ/joFuAH5Bw+Odhlq+/+WgX
         US/KgMVz1la9iOVPMt5HfxaZzvSXcWjw0vy/ItSkbIBsplOrU+vWWzmZxXE6RuOgr9Me
         Y5uYrRvhzfizz979GZBGbF7FNy1ZrPSkYUsrM2UTywehZaVgwFAAkuDRQuOo6tT6cCbA
         mksDn1EI+PSUS9CQbXjRA8RApG6/aCoRc1zPLTrZt0eLmQmHUhWsFJO4iyogzAayIj8c
         Ribg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mZONlEy59OWMKG3t+lg7eRVboIUI1y2SSKzs63Sul+M=;
        b=QFbl05li1U+MMzfMbR2loDNqRZWk6Hznf6JgJV4nEP2SEAg13P6VWZ8JWyi8EL/2jm
         JcyNSBAjbN5c6mtQ0f3TAWzAusS2tDEoObF1v5ahFb92/NHBbflVRrlIRGSjEidqIGZp
         8D0sVYlctkhXhP4Va4OksaDXLSGjYpooX7JjVEmzotvmIZFZzYHZJdw9sFLe1wBhaxl+
         gGqjSjZSm5fQjOrAoagkpnimg6VpEWHdYyfuvhBc40oVsIIY4wThahElVwI6IUXHNUDX
         6EGt6TYms84g4AINS9euJwMzD21fSyziO84E9KhRgPtseMC9ocqKL6xg93G2eY39ZY/V
         fP4Q==
X-Gm-Message-State: AOAM530Abpvy/Wgv6v4T6mZpq5di04R7wsJsISwe8Esv2s8JBo+lrZLA
        rGRsVVTX7C0qTfa6UhsDxjnn//arw6me4TI6ACxtid9K
X-Google-Smtp-Source: ABdhPJzIE0o06RAMf1hvJutLISY35iGwzV4aScMmHGmaUclbLMaPGpATbqR1a/ghSocw5EWassY7UBcZUqMRr3DU7Xc=
X-Received: by 2002:a17:906:b0d8:: with SMTP id bk24mr27593301ejb.252.1615859853946;
 Mon, 15 Mar 2021 18:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjoAST=rQ4NmGkVjqxi3iNqPg2MmqjCdr6=8smUwryX8A@mail.gmail.com>
In-Reply-To: <CAOuPNLjoAST=rQ4NmGkVjqxi3iNqPg2MmqjCdr6=8smUwryX8A@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 16 Mar 2021 07:27:22 +0530
Message-ID: <CAOuPNLgXqqH7yxxPfHecSMdrJkAnASYgyzLDqduZxYBVKhzi2g@mail.gmail.com>
Subject: rt-linux mailing list and discussions
To:     linux-rt-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,
I just want to know which is the right and active mailing list for
contributing and discussing about rt-linux and preempt-rt related
changes.

Thanks,
Pintu
