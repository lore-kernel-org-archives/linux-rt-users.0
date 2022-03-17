Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C485C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 17 Mar 2022 09:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiCQJEZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 17 Mar 2022 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCQJEY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Mar 2022 05:04:24 -0400
X-Greylist: delayed 170856 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 02:03:06 PDT
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97FF62F4
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2022 02:03:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B19F5CE54;
        Thu, 17 Mar 2022 10:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647507783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=yE8RhcudnCZqf5AV+GeQheTcuEKFODHKRghKR7d+TlE=;
        b=qGPqXmFXo3zM4lLYaAwEFhym4nQpr9ia/nuBvKTQ3oJpPrYk5JI8bDCzuaUsfIaUwgTs1Z
        kYzsKJMJpZGQHZax3qV8LE70YiNNI+jlnoxmE9kunXUIZ/RvadUaCkrRnda6fZBoY4VRIK
        zMtWzRyckW2+Jq7cxk/n76OrZZzofqsjDePegdHHg/0rUvH3LUyLRJ94+Bg8jVYc99E/rv
        IQ1AkYdhWfJHo8bIsrl+Q5wNDo5ES9cMaXxxLBTQ3fMdxQ5xqLdebObrNho4pdBxHx2FJb
        eQsl7iGgpYhXLiWvjUIrWVZKkTYQSDl+Gv6SFckI7V8iN+jT4lbqp/nEBz3biQ==
Date:   Thu, 17 Mar 2022 10:02:45 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     gene heskett <gheskett@shentel.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: found linux-stable-rt-4.19.233-rt105-rebase
Message-ID: <20220317090245.riqtsgncpegagvof@carbon.lan>
References: <2066930.VyunGXjrIA@coyote>
 <1680097.7vmoJTWvpf@coyote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680097.7vmoJTWvpf@coyote>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Mar 17, 2022 at 04:33:09AM -0400, gene heskett wrote:
> On Thursday, 17 March 2022 03:09:13 EDT you wrote:
> > Greetings rt-kernel-users;
> > 
> > I managed to trace thru git.kernel.org until I found the above rebase.
> > Downloaded it, moved it to the rpi4, and unpacked it.
> > 
> > But to build it on an rpi4b for armhf, needs a bcm2711-defconfig, and
> > it is not there in this tarball.

RPi4 was released in 2019, while v4.19 got released in October
2018. Hence the upstream v4.19 kernel never had support for the RPi4 as
far I can tell.

> And this one has also lost the bcm2711 support.
> Please advise.

It sounds very likely that you are running a downstream kernel for which
RPi4 support was retrofitted. Nothing lost in upstream stable or
stable-rt kernels.

If you want to run upstream kernels, I suggest you pick a newer kernel
which supports RPi4.
