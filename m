Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD330C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 21:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8061460E09
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 21:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhHJVGl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:06:41 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60869 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233780AbhHJVGk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 17:06:40 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 8D8843200681
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Aug 2021 17:06:17 -0400 (EDT)
Received: from imap4 ([10.202.2.54])
  by compute2.internal (MEProxy); Tue, 10 Aug 2021 17:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=mime-version:message-id:date:from:to:subject
        :content-type; s=fm1; bh=E0z9rz0mOm4PtprrITgmwvN/tiszsQ65w02qWb6
        A7lw=; b=iZjOWoCQDIshxNqvVyihiIHLmtTw9f8N8DAb1/TfGfLDjIWUcqX/s65
        JevSCgsqyBGDNKZPhTXUWgDN9z2nWG3ECv5FUDIFJ9owSKGTIkS1VEG9IewxNxY1
        xRg3128owyA76UVbiYkj36ld5ujjTCEIgwaMhKxL/bVynUri/d2ZK+GV+MayhYiZ
        5yqCMDE5O2mPceRlBVdFzgRjkr9Oq28TNqhbFjLehikAsPElMBAHAeuRFJrLFOUm
        VevmLJ1rwWWelYEHq0Jd4IUwx3oeBg7FwxvyPxB+binP6zlBH1GSaZbtjLS2k6DX
        gXJI7wGHfM09h+SVn7nDbBaggTcVP6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=E0z9rz0mOm4PtprrITgmwvN/tiszs
        Q65w02qWb6A7lw=; b=PKrI0solJbxLMudQZHUdK1+wT6NaXA96hqvdICgyEmZYi
        fV6sUXk6eZlP/DamCWKzwP+k43l0ycwj/rDhGvlBuBNHKiJnRiRuQzDXVpE3jFoC
        EaacC+62KCYnZmrWYTsEBnJO7p6IFC92xgyMTqiasKBXNYlB7q+BIu2Q8qw9zJHl
        GMXkyINdMnI9asfhKE7KfuXkgfr5yiNHBwJiN5R3UtMoc+yIFRXfmEYkoYt0ODRu
        s/s9GluKIpLHu/87dy7JR4rd1ztd+gC9cIMIlQcj6HYA+687qSg+ai6IMfG04A4P
        oZkQ7p0sPerUZeHbc96Fcn0Ht3nkk1HqX+sRVjPkQ==
X-ME-Sender: <xms:SeoSYX3x-S-2XT_orQv_IGZ3JCqBfoU6hZx19-UVzij2FwbUyze2vQ>
    <xme:SeoSYWE8lEmLrBDtZex9aakxzLMO4gXpAgvQWlKcnMKh9aHkfGv3CcfN_MTz7rZ0N
    rH-4lQd_oaGQBuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeelgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfufgvrghnucggucfmvghllhgvhidfuceoshgvrghnvhhkrdgu
    vghvsehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepffetgf
    ejgfduveevgfefhedtfeffgfelteeugeeihfdufedttedttdetheeuvdeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvg
    hvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:SeoSYX4zKUGkLRyLSev8M9KnOB1F2Nd1UHwtvcCcbJ6uQ-Zae9kX3A>
    <xmx:SeoSYc2M2cPnQRA3AjMkAfhatbk_TBDpAzRjOe5rJ29vlQTV9pGGRg>
    <xmx:SeoSYaHlYKd6Pp8s3ODxM0oW36T2ihk9Sh6MHQnTXx4sIclVurj3ww>
    <xmx:SeoSYeQuloIVIUxmGP9VBQGNHS5_1z-nB_QrSDQ-u2YK_IotclWLlA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9068160112; Tue, 10 Aug 2021 17:06:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1073-g87597c2717-fm-ubox-20210805.001-g87597c27
Mime-Version: 1.0
Message-Id: <aba98bf7-a61c-48b5-bde9-06ef31a0aad9@www.fastmail.com>
Date:   Tue, 10 Aug 2021 14:05:56 -0700
From:   "Sean V Kelley" <seanvk.dev@oregontracks.org>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Capacity Aware Scheduling
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm trying to better understand how Capacity Aware Scheduling works by artificially defining some cores with a lower per core FMax so as to simulate asymmetric topology.  My understanding is that the topology itself is either set by Device Tree or via ACPI / CPPC.  What I'm doing is selecting a subset of cores to have the true per core FMax and lowering the per core FMax on the other cores.

What is the best way to artificially change the topology so that the either CFS or say SCHED_DEADLINE make use of my artificial asymmetric topology?  I'm working in an ACPI / CPPC environment so not using Device Tree.

Thanks,

Sean

-- 
  Sean V Kelley
  seanvk.dev@oregontracks.org
