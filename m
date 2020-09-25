Return-Path: <SRS0=gYFm=DC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3510C4363D
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DB621D42
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 17:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=imperialcapgroup.com header.i=@imperialcapgroup.com header.b="kyz2vG5E";
	dkim=pass (1024-bit key) header.d=imperialcapgroup.com header.i=@imperialcapgroup.com header.b="kyz2vG5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgIYRQs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:16:48 -0400
Received: from [46.166.185.98] ([46.166.185.98]:48840 "EHLO
        host.imperialcapgroup.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726990AbgIYRQs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Sep 2020 13:16:48 -0400
X-Greylist: delayed 24240 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 13:16:46 EDT
Received: from imperialcapgroup.com (unknown [185.236.203.204])
        by host.imperialcapgroup.com (Postfix) with ESMTPA id E2FFA1237E8
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Sep 2020 05:13:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.imperialcapgroup.com E2FFA1237E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imperialcapgroup.com; s=default; t=1601003613;
        bh=6CXuz3tZVwV0sLbV3HksYvK1Xzbh6nLYCrrWqAmLkHM=;
        h=Reply-To:From:To:Subject:Date:From;
        b=kyz2vG5ELVz8RWsKhGNdWmag/jA6LGb6tZNSuAjE4q7y1UPwBTUs80lbl44fV8v3M
         wYJkcLXl3MwXUVfYLwN082b0HHUfi1O4yh18zUo1sMAMY2N/NIS1VqH+etDvbYD+4F
         VNuws9afg5o5Hx1LQFp4Em4u0tgrF4XVH8hFmXkY=
DKIM-Filter: OpenDKIM Filter v2.11.0 host.imperialcapgroup.com E2FFA1237E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imperialcapgroup.com; s=default; t=1601003613;
        bh=6CXuz3tZVwV0sLbV3HksYvK1Xzbh6nLYCrrWqAmLkHM=;
        h=Reply-To:From:To:Subject:Date:From;
        b=kyz2vG5ELVz8RWsKhGNdWmag/jA6LGb6tZNSuAjE4q7y1UPwBTUs80lbl44fV8v3M
         wYJkcLXl3MwXUVfYLwN082b0HHUfi1O4yh18zUo1sMAMY2N/NIS1VqH+etDvbYD+4F
         VNuws9afg5o5Hx1LQFp4Em4u0tgrF4XVH8hFmXkY=
Reply-To: laghoulli22@secsuremail.com
From:   L A <laghoulli299@imperialcapgroup.com>
To:     linux-rt-users@vger.kernel.org
Subject: Co-Operation Required
Date:   24 Sep 2020 20:13:33 -0700
Message-ID: <20200924201333.8611C1F847BC93E4@imperialcapgroup.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello there,

I am Laghouili Abdellatif. I am contacting you because I have a=20
proposal that I think may be interested in. I represent the=20
interest of my brother in-law who was a minister in the Syrian=20
Government. As you probably know, there is a lot of crisis going=20
on currently in Syria and my brother in-law has fallen out with=20
the ruling Junta and the president because of his foreign=20
policies and the senseless war and killings that has been going=20
on for a while. Everybody in Syria is fed up and want a change=20
but the president is too powerfull and he simply kills anyone=20
that tries to oppose him. My brother in-law belives that he is at=20
risk and he is now very scared for the safety of his family=20
especially his kids. In order to ensure that his family is taken=20
care of and protected incase anything happens to him, he has=20
asked me to help him find a foreign investor who can help him=20
accommodate and invest 100 MUSD privately that he has secured in=20
Europe. He wants these funds safely invested so that the future=20
and safety of his family can be secured.

I am contacting you with the hope that you will be interested in=20
helping us. We need your help to accommodate the funds in the=20
banking system in your country and also invest it in lucrative=20
projects that will yeild good profits. We will handle all the=20
logistics involved in the movement of the funds to you. The funds=20
is already in Europe so you have nothing to worry about because=20
this transaction will be executed in a legal way. My brother in-=20
law has also promised to compensate you for your help. He wants=20
this to be done discretely so I will be acting as his eyes and=20
ears during the course of this transaction.

If this proposal interests you, please kindly respond so that I=20
can give you more details.

Regards,

Laghouili.
