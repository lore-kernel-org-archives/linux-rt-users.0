Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3861C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun,  6 Mar 2022 12:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiCFMMz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 6 Mar 2022 07:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCFMMy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 6 Mar 2022 07:12:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA11A833;
        Sun,  6 Mar 2022 04:12:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0873A60E09;
        Sun,  6 Mar 2022 12:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB2C340EC;
        Sun,  6 Mar 2022 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646568721;
        bh=RdsMn1NV+ee2cT77H5I6utiQ+VayosQE+GCEI/twxPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USMK8bgQ4mCYGXENDtJjq8OiU1m843+JH8xGKlAI4ebgctv2drHgEq9JZKGcUypGm
         Ee7k+sZGvkJte1T7vY9omjdxfGBoCmLiW+tXm0EGX21v/Qw7EKASYbIgBCIwQpeu/u
         Wyom0/8V4z0eXZH1uQIzHlixzdkh8rUNAXzx6Tv0=
Date:   Sun, 6 Mar 2022 13:11:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yunhao Tian <t123yh.xyz@gmail.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: PREEMPT_RT causes scheduling errors with f_rndis USB gadget
Message-ID: <YiSlDqqk0gnUouWd@kroah.com>
References: <CAFQXTv2B10=i6DMV1iJpOT-Mj9F93hOi_415cn49N6X_yDFw2g@mail.gmail.com>
 <YiSOjGLzMCvKOm0G@kroah.com>
 <CAFQXTv1CACLRB-Tx07pR4xFNQncdq=i7Q7=vQzgD3hpdehr7cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXTv1CACLRB-Tx07pR4xFNQncdq=i7Q7=vQzgD3hpdehr7cQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Mar 06, 2022 at 06:57:08PM +0800, Yunhao Tian wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2022年3月6日周日 18:36写道：
> >
> > On Sun, Mar 06, 2022 at 06:17:54PM +0800, Yunhao Tian wrote:
> > > Hi everyone,
> > >
> > > I'm using Linux 5.15.24-rt31 kernel with PREEMPT_RT enabled, on my
> > > RK3308 board. I set up f_rndis gadget with the following script, and
> > > plugged my board to a x86 Linux computer running 5.15.25 kernel:
> >
> > Does the same thing happen with the non-rt kernel?
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg,
> 
> Thanks for your reply!
> 
> This doesn't happen to non-rt kernel. It will only happen when
> PREEMPT_RT is turned on, with rt kernel.

Great, thanks for letting us know.  I'll let you work this out with the
-rt developers :)
