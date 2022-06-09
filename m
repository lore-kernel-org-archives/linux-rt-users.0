Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05BEC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Jun 2022 10:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiFIKdf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 06:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242376AbiFIKdW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Jun 2022 06:33:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A02109DF
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Jun 2022 03:33:20 -0700 (PDT)
Date:   Thu, 9 Jun 2022 12:33:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654770798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/OPr4TRtSgDE+TjCOlDFUsRdw2QMsvFx1PmA+H0D+c=;
        b=ejVjOos10jeUdNyC0Cf0kA6tM1y/GDNXL8xpmEMphXO2J9ZvRpQ8t4bOy88ldqCqH3rTYr
        xe8uGRSvtdtnkP5CGnmf2Wf9gyghphNocoP6bTV6ynYOz9R4tpz7kGbiFVA7HGM5F83y32
        JFdKUzc7mUOUypFL/Oxi34xC5/42dPJWPzg7dLKh8T6LgpA0YT1HQkKsRhyH/QsqpQIuy8
        v/86CjweNzklL3hC2WgvCkHtjRFwsmz3jRlyFImHCgOHJtIZ08y0tmkWOHGmKFU9WKPkE8
        wl0LtydDjF7KO66xQvGb0ZS6BFMkAPnGbFzUDSvADMr5152ZzW04T/pjOZR/5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654770798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/OPr4TRtSgDE+TjCOlDFUsRdw2QMsvFx1PmA+H0D+c=;
        b=yxD0eILasyrRdCxGRpyk07+HtDBYuzFbBmUthZ7fmxFp/RGlHbEsKo3FMGmsiVL5sS7s1g
        vUWVjVf4m8APgZAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Gautam Thaker <ghthaker@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: using a "-M" option on cyclictest defeats the "-D 30" option
Message-ID: <YqHMbD6AKwNZBGvc@linutronix.de>
References: <CA+1+E3Wj9Aw7VP1955XhxNd7YOXO+4VM0tQ_z+z8n08GKirwSg@mail.gmail.com>
 <CA+1+E3WHxbcZtHLPueffS1B4K3W3=_dcvg1PYfR5sY3To2YXOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+1+E3WHxbcZtHLPueffS1B4K3W3=_dcvg1PYfR5sY3To2YXOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-04 10:48:21 [-0400], Gautam Thaker wrote:
> I have noticed that
> 
> sudo time ./cyclictest -S -D 30
> 
> properly completes the test and exits in 30 seconds. However,
> 
> doing:
> 
> sudo time ./cyclictest -S -D 30 -M
> 
> the test never stops, I have to control-C out of it. Is this intended
> behavior? The man page did not say anything about this. I would like
> to use both -D <many_hours>   and -M together.

It works for v2.2. What version do you have? I tested it with 5 secs but
I would expect that it behaves the same way for 30 secs.

> Thanks for any comments.

Sebastian
