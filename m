Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB50C43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 20:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1558206BF
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 20:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lofmTLn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfFTUYC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:24:02 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:46202 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFTUYC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 16:24:02 -0400
Received: by mail-ua1-f52.google.com with SMTP id o19so2096238uap.13
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=odgC3csqf9apdrL5gEE3knm1hUjHgQ8cyxL/Nv/bQ3M=;
        b=lofmTLn5A0UucCMnDiJFC/zdfDF1t2Hm9eIJvyNbxE95cZy9yQmCr1CaSm/KS7mcQA
         F00Ond/4Em4QIql1t2XnZvYFyRKKrywY5xrrnB2uCFgM0A9QWjT1N1Iw5yTocsGgDhn2
         0vxEwAUBTC7+BMPqlNLwhdmIy9Cyj31QCbrPk1dvysls+Ayx5mewsPUa1gIEV2niJnh1
         31yA+GnoRX9d/5mNbGBdra2KHPzQBvMdhDz5JotsA6GyWDtpK3cpTpY0N+Ao5OX2lVkE
         IuMkIAlBVJkpX7t3u+KeS2f2F9NAu71zQY90BCp/L2w+SX51xcTrEH6AD0PFm116ERbO
         8RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=odgC3csqf9apdrL5gEE3knm1hUjHgQ8cyxL/Nv/bQ3M=;
        b=TCc+lixLN5rHzphqL3rFVDIZMblwHj6HhFC83h14ewUAHvjLcTAARglCKuF+nNK8Iy
         qskJiDfqZWHrn84P35ZixVtIRH5oMfQ5INf1yd8Og+1hsTuDG0Ec9To1rSoSjfpzjfWe
         hg7d6t/5jsyTZTPlL0fL41udTwgTqtzu/KBL18zZM6BGQdWlBYju0IZilCR7QllmfGrQ
         ayMjoy22pC+EalEYpOGnBgz2JjKTh2EgOYoukq3Ljn7FZNfuBwx7h1LXQamAGa/DX4E1
         xYufVaCaqDzyRUrUBzua2fBmyflvs27euO1Gd5SWjsKJvwvFds9/tW9Kvf8VU37kdlH6
         yrHg==
X-Gm-Message-State: APjAAAWg6qwF6RLOYq7a2/RoVsnu+WL8PkUqF7LZYjsltzaQ28Kuj2yK
        xE56CdLmqU6iRZseGlkSMotd33ZrGnZG1V+kKI4d22Zh9fs=
X-Google-Smtp-Source: APXvYqwlbpKQgZt7YbEzc1L/5Ww9pbVccdcIs9Ct9sokgrcra17lWGIPXFBH954GXN+pQT0MKVRYRjoEYnn8WOMDXVg=
X-Received: by 2002:ab0:66:: with SMTP id 93mr15022541uai.135.1561062240901;
 Thu, 20 Jun 2019 13:24:00 -0700 (PDT)
MIME-Version: 1.0
From:   Ming Yang <minos.future@gmail.com>
Date:   Thu, 20 Jun 2019 13:23:50 -0700
Message-ID: <CAEVNDXsR03jGXKO5diQbjMQecS=wXxdEW5eGQAAL1PPOQ_RO6Q@mail.gmail.com>
Subject: sched_deadline sched_setattr fails after setting cpuset
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

sched_setattr for SCHED_DEADLINE fails if it is called after setting
cpuset that doesn't include all CPUs. The sched_deadline document
states that cgroup/cpuset should be used for task affinity.  But I got
errno EPERM when calling sched_setattr, after setting cpuset.

Section 5.1 example in sched_deadline document is broken. Not only
rt-app doesn't run in the way shown in the example anymore, but also
other sched_deadline program fails.

rt-tests deadline_test.c illustrated a working way to use cpuset for
sched_deadline tasks.  It sets cpuset *after* sched_setattr
(https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/sched_deadline/deadline_test.c?h=unstable/devel/latest).
I suppose this is the only way to assign CPUs for sched_dealine tasks
now.

Can anyone please explain why sched_setattr fails after setting
cpuset? Does the sched_deadline scheduler rejects both affinity mask
and cpuset now?
Does this mean admission test always assume all CPUs and no admission
test would be examined when setting the cpuset of the task?

Thanks,
Ming
