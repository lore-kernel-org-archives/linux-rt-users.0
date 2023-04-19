Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D11C6FD18
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Apr 2023 20:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjDSUnI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDSUnH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Apr 2023 16:43:07 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA091171D
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Apr 2023 13:43:05 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 28DF041CD0
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Apr 2023 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681936984;
        bh=Wqvj0z/DD0J/HnfDVK2IOpPTUtZ21+BlrycJj3ZvEF8=;
        h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
        b=HzwX7jZkTEqf/GwKbBakpcjaQypm4JlMpNgTnzrkkgcFnR2lHA/pTMp30hsN21744
         dMJPa4C8kVXqEYLaJCUPr/EavEa/EuQqAFyBF2qx5c6p+j6z+Cvw7VW4xRjrNIem7m
         ywI+aM9velibJSe78JlR25/QjRKZRjub/xoyCeA1rZn2tJVya35b2jznj40xZXnrRr
         TP6TGXWnXwCjkib/mOkW2ETu/iMjyC0BPjr/SxJljmd7o6bAzMnKGxzaKomTAMuMnJ
         71UnmYbwhhdN8WnHrq4t1oxIWUKPURVjduw/K1/J1Y/c+jRO4YxHuVOxZvj9u3CehZ
         w+awPfMIdKMjg==
Message-ID: <b0ae28be-dd25-aec7-140e-a9464598799c@canonical.com>
Date:   Wed, 19 Apr 2023 16:43:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-rt-users@vger.kernel.org
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [ANNOUNCE] 5.15.107-rt62
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.107-rt62 stable release.

You can get this release via the git tree at:

git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

   branch: v5.15-rt
   Head SHA1: 22006998ccd16be9ba0365058877f008910e108e

Or to build 5.15.107-rt62 directly, the following patches should be applied:

   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.107.xz

https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.107-rt62.patch.xz

This email didn't pass the size restriction on linux-rt-users so this 
email does not have the entire diff.  The diff can be seen on lkml:
https://lkml.org/lkml/2023/4/19/987


Enjoy!
Joseph Salisbury

