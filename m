Return-Path: <SRS0=mgec=B3=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF7EC433F2
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 21:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065DF2072E
	for <linux-rt-users@archiver.kernel.org>; Mon, 17 Aug 2020 21:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIKp3xkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgHQVzP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:55:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55525 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728803AbgHQVzN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 17 Aug 2020 17:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597701311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wEuNg9A/PxOCxOV9rx+u9NQKrDBUMgFivZS5nsOZF6k=;
        b=QIKp3xkPtxl+9IJMmtZl5ivpEuIT8Jom95TmqDb/AigpIrq3L5WV0goc6UKWxOoYpQxeRd
        0RHs1So99/FCJ3vUuTYmqYDxu477H1jwCbvrQhLteoypQ08enjXq4fQwBfMFQ0T/O105UP
        1mH7142qqzWwW8BbREv4/WKjgcTCsOY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-wD1yk16aMHWF4Y4QQlN5nA-1; Mon, 17 Aug 2020 17:55:09 -0400
X-MC-Unique: wD1yk16aMHWF4Y4QQlN5nA-1
Received: by mail-qt1-f199.google.com with SMTP id e11so3486136qth.21
        for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2020 14:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEuNg9A/PxOCxOV9rx+u9NQKrDBUMgFivZS5nsOZF6k=;
        b=EZZqb7pKVf99kEL93D8N/nLsrtVzYIRAzd01fzwkGe295UBnDUcS2RzUzcI0/uE7bU
         p4yMayAZgExOx/fGBl3XevmQred3evn5M1zdWtqrYuBezMH0c9dPcW58JNAItE82p3AE
         hWceigtoD5dq7crjmdAYFXGnDSfrSGaUo/uuCb+5OlNS7xohL58UhosYU4D4tgGqih7X
         08eMGgF+kzRXShD2dAqlQwpCaaPXH3qfsiKcNiTF8xJpHb0SW9axb2WHIve3CVpJSwWM
         cyB+akPAtZ28EO9TcTAwwqPhMKY+YzfWIckZokfeBsNPDM1u+kPRsGYZV6uqq9aV2OGV
         Y+ng==
X-Gm-Message-State: AOAM533yxjKw38N9vtFQbQcBdnjpakn4Uv0hOipjV76H0Yp0EjMKI0Kz
        cho/vZXAJJJQb6HkMzGf1VCLYMOgHpOofNaCq2KZK5KbP98eJ6VylJUWtfn705VrAub4m2DkEkE
        obX/Em8Dm92Px+qf/OzgJNf9NdpY=
X-Received: by 2002:a37:27cc:: with SMTP id n195mr14318497qkn.403.1597701308707;
        Mon, 17 Aug 2020 14:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwxqEVdrGbo5dlyZTmcJ2l44AubUAp+aOB/l3zZKDz7bjS8u/EqxfwG3B3GjptnKFFcecaeQ==
X-Received: by 2002:a37:27cc:: with SMTP id n195mr14318477qkn.403.1597701308442;
        Mon, 17 Aug 2020 14:55:08 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id d57sm21399826qte.91.2020.08.17.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:55:07 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, peterx@redhat.com,
        Andrew Theurer <atheurer@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 0/2] rt-tests: Port oslat in
Date:   Mon, 17 Aug 2020 17:55:03 -0400
Message-Id: <20200817215505.227046-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This series ported the oslat program [1] into rt-tests repo.=0D
=0D
Oslat is an userspace polling mode test to mimic DPDK apps.  It can be used=
 to=0D
identify RT issues besides the general timer based tests like cyclictest.=0D
=0D
The 1st patch is a cleanup for cyclictest to move some trace helpers into=0D
rt-utils.[ch] files so that oslat can use too.  The 2nd patch is the port.=
=0D
=0D
For more information on oslat, please either refer to [1] below, or please =
read=0D
the manual file in the 2nd patch.=0D
=0D
Please review, thanks.=0D
=0D
[1] https://github.com/xzpeter/oslat=0D
=0D
Peter Xu (2):=0D
  rt-tests: cyclictest: Move ftrace helpers into rt-utils.[ch]=0D
  rt-tests: oslat: Init commit=0D
=0D
 .gitignore                  |   1 +=0D
 Makefile                    |  10 +-=0D
 src/cyclictest/cyclictest.c |  90 +---=0D
 src/include/rt-utils.h      |   3 +=0D
 src/lib/rt-utils.c          |  82 ++++=0D
 src/oslat/oslat.8           |  66 +++=0D
 src/oslat/oslat.c           | 896 ++++++++++++++++++++++++++++++++++++=0D
 7 files changed, 1057 insertions(+), 91 deletions(-)=0D
 create mode 100644 src/oslat/oslat.8=0D
 create mode 100644 src/oslat/oslat.c=0D
=0D
-- =0D
2.26.2=0D
=0D

