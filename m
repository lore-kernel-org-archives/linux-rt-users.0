Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10EC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Mar 2022 08:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiCRIt0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 04:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiCRItZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Mar 2022 04:49:25 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184BD1118
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Mar 2022 01:48:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 194F95CEC8;
        Fri, 18 Mar 2022 09:48:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647593284; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=znzJhQy8sgY4J3DL5G4c7W2c5WmSco2Vh0YYxnl5zdo=;
        b=X1gU+jo9tIyLC3JwgESLZxFd1PK/VsiYGUmnIvV0VyrcmR8j/T6hk9u1samk/Ur6BqZziz
        OcJsz3tiVuxn9GgvhdwzTvUCR1hQjiYrJZ3/ilGH9SDLH2RmP8MyybLY2nhLsyAO+suF5d
        zR1qDF48LH2vX2Rjz0xVYvp4wr3756BbOsNgDz4VLl72OKHLRaV+Ap7DComKoSoB8QoAlk
        f8B7JVM0SL0hdr9QwI15T/YJJQfBfJdtLl+H22RyVA0KhOszzRH+XyTkSXqLrLoPE2Thnf
        XuPkyVCnzU/n2GikEDOMFgxlLVXYJHfvCMUvUKqZSOF6TsWVMZ2wEotykQrj8A==
Date:   Fri, 18 Mar 2022 09:48:00 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] 4.19.233-rt105
Message-ID: <20220318084800.6f5xs4rnp5kw6lxo@carbon.lan>
References: <164698646082.13723.1987519373498826881@beryllium.lan>
 <20220318060151.411f6789@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318060151.411f6789@archlinux>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Mar 18, 2022 at 06:01:51AM +0100, Ralf Mardorf wrote:
> On Fri, 11 Mar 2022 09:19:04 +0100, Daniel Wagner wrote:
> >Signing key fingerprint:
> >
> >  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C
> 
> Hi,
> 
> where is actually the required key (E072D068B1F5703E) uploaded, to
> verify the patch?

Sorry, forgot to add this to the announce template. The key is
available on the korg keyring:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

FWIW, I have a TODO for this:

  https://github.com/igaw/stable-rt-tools/issues/11

HTH!
Daniel
