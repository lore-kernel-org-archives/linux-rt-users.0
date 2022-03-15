Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315FC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Mar 2022 09:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbiCOJgq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Mar 2022 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbiCOJgo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Mar 2022 05:36:44 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2D4A3E9
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Mar 2022 02:35:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF3F85D199;
        Tue, 15 Mar 2022 10:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647336928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=zH3ZvybPMEnCK2DCHE1ydSiFcFB0RRNNWajDZSKVU6g=;
        b=xQGyU5TkA1I9TrlEAmF3M6/PHRGl5eXEi9pSUDOoHe2rKG6ag5e2xgeqoGb6JTodxntkB/
        Hs2roXPhV3vxvag1zB1UNXuXDzzBwUtVfnp+FtsWQXKRRQuLHoOntLqoglvYqlGRAtEWlh
        UvLBc8r6xRbPyRIgGLpsSQpsdGvp+T71P5EKNJxvQDgMcEAwrmJe5CwwdkAptiNg5LiHN8
        PiJzE4bBybfyKAXMMWcbdHpk8kMc7GL9BD4T1mVt0YupQoEqfbuCci+6Ve5zMHs2eTCaRz
        3V+vGvaVBDuHgVu1lICm7ThzXNFkYLK+jZX402HYBh6LxLawKGSIwyuQi0njzQ==
Date:   Tue, 15 Mar 2022 10:35:20 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     gene heskett <gheskett@shentel.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: dirty-pipe ?
Message-ID: <20220315093520.c3brtsex6qnax7uy@carbon.lan>
References: <2658635.4HAHC1xCac@coyote>
 <CAJjrzcUo_30mZAuWVN4W2WK=WcoFC_55_Lq5y7YxdjD37US_YA@mail.gmail.com>
 <20220314180200.dgp3w3clar4ruuwy@carbon.lan>
 <1752976.GyQ78RL1t7@coyote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752976.GyQ78RL1t7@coyote>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Mar 14, 2022 at 07:02:12PM -0400, gene heskett wrote:
> For armhf, thats probably best addressed with a quilt command in my 
> present rpi4 working kernel for buster. Is it possible to autogenerate 
> that quilt file?

quilt series are just a file containing one file name per line, so you
can generate the quilt series by something like

  ls -1 *.patch > quilt-series

The patches you can get via 'git format-patch
v4.19.233..v4.19.233-rt105' from the v4.19-rt-rebase branch. Note my
instruction might not work out of the box, you need to adapt your local
setup.

> And what quilt stuff do I need to install on the rpi4?

The compile toolchain, git and quilt?

