Return-Path: <SRS0=0v2v=3E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DAEC32771
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jan 2020 18:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD5724656
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Jan 2020 18:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedgreg-com.20150623.gappssmtp.com header.i=@embeddedgreg-com.20150623.gappssmtp.com header.b="FtiiVDE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAOSGm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:06:42 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34550 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgAOSGm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Jan 2020 13:06:42 -0500
Received: by mail-oi1-f180.google.com with SMTP id l136so16299765oig.1
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jan 2020 10:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=A2ZLv3PFMK+vF2+bw/8jGnAKzCq2nW1tiIdL10ntXeU=;
        b=FtiiVDE0knDKiPRz4zQWBl+lQpNHWZINzoR/uAioaLiI7wgbKL4HWMPmFHdaG172A2
         UozGDgOjMvRACIq0A5xPBe+5/JxS5lhy/Qt1INuEoBMeRUdrtTHrTHA47nVGstZlhY63
         6SB3R029386flGAdgyVOAPHzMWeuW7rAm01U54HyPZYIKe/yLhpZFQuRCjHjKiflua6v
         CwSigQew832QKMtXurJdMQfHdQgfUmIUs8QDUROQpDS90/i6xPPmZG5QqI3cO4cF3o54
         mXxUhoCVujGQOBF8w4ycQGV4qg2k50BL0AIR3zV38lGxu87JCUe/Bs7/zcy3Bvp6RxKu
         6qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A2ZLv3PFMK+vF2+bw/8jGnAKzCq2nW1tiIdL10ntXeU=;
        b=nvtGsjcOlU61SrEfbSQYGzxIYQ+vhWwwr79VliYhet4MPfxAj/KaSEezWh/IyZXNeg
         s3ieWKjyiAI7LfzPKW36lhT7cBriNd77zz7pw6fLyCEfm4dLDETrFhS1q2DxZuMStsHe
         2ho4MzxlPptMUCIe42ck1Ca4ZqiaILCNTdO8DL1ykcLNzeDeqEjmdI7G+UfWRQYaIlM7
         OBr5/bJSynuskUy/gh9grcB1FNIeKispCXjeFzjYV8H+0bbLHtmCsiD8+dCxCRflbn00
         kQE7rEgkeSdM9KferWMQ7CiqFln0uq7Ky4rKKehbGH7dL0WeOlexCWKNAi/ks36hkA+f
         mNpw==
X-Gm-Message-State: APjAAAXPl0HKpDmdYZOsJHsp3uYBQ8H2PcfDVur4YZzgJsyfyTeFbWpU
        UOfhBD/DmyYzlBvxBDqrGcs7vY25bSw3+Zga5PBMgYMo
X-Google-Smtp-Source: APXvYqwVuUnhnPJqDEJdj+2/xz3zvsQ1EM440y5hDLi4RtOfz/hwpakQdlPL7UkJ5qF2zyogy+7U83mKQfys9cMLgdc=
X-Received: by 2002:a05:6808:3d0:: with SMTP id o16mr835902oie.79.1579111601575;
 Wed, 15 Jan 2020 10:06:41 -0800 (PST)
MIME-Version: 1.0
From:   Greg Gallagher <greg@embeddedgreg.com>
Date:   Wed, 15 Jan 2020 13:06:30 -0500
Message-ID: <CALLqZ8QK5kJqwxZ-zze-OcwFCAWY5gDOmy_UwqUm89HE3rZ_gQ@mail.gmail.com>
Subject: Any maintainers or developers looking for help?
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi RT users and developers,
   I was wondering if any RT maintainers or developers that are on
this list need any help with tasks that they haven't had a chance to
do (documentation, small fixes, testing etc)?  I've been working with
RTOS's, Linux and C for the past ten years, I've contribute to smaller
open source projects in the past.  I'm still a novice when it comes to
working with the open source community and I'm reaching out to the
list since if possible I'd like to work with someone to start.  I know
that not everyone has time to help but I thought I would reach out and
see if I could help someone clear out some old tasks that need to be
completed in exchange for some help getting started contributing to
the RT project.

Thanks everyone for their time and sorry to spam the list,

Greg
