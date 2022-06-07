Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E0CCA481
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Jun 2022 17:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347414AbiFGRq5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Jun 2022 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347802AbiFGRof (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Jun 2022 13:44:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5631312A0
        for <linux-rt-users@vger.kernel.org>; Tue,  7 Jun 2022 10:35:24 -0700 (PDT)
Date:   Tue, 7 Jun 2022 19:35:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654623321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5b6dFH+VNDXcWPKvtUIoFRoueze2L+uW/bK96tejcek=;
        b=z22sLxPhqt7ycDN6SLfpzfoUarW5/tPD+OGWZxNGmNDso8lxJOk731NKHKlfwzexSZKn71
        3M0x8mOqV4rlbGG3Gn65KBYSmOLZrVzxCnKSlxzHcTIACbSwJBo3w9cSzeoGK+aKXAc8dc
        bGqNSoOxECPzjNJR/WCxLvLsjL0Nr852lV48/AHEt4iVlpbm98jAa3fAYenW2kD5h7YsHC
        uHsheGjm4gkFY5RDL71a2AaOak8KAbOL1H5bFZMI/2CFaoPl7KdcretchdU894X4XBHx0p
        9oQpEytdCtC0bn0PPSC+O9xSM5855ZQCDHD30Oz5e+lhmiyrPzZ6984gGz24WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654623321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5b6dFH+VNDXcWPKvtUIoFRoueze2L+uW/bK96tejcek=;
        b=IGYdB4brjL5SV/w/y8ID2/4Sis1Y2f800pU9nX0FRvNFl5TsVZ8/1apQ4oOjwa0Y0cKtpB
        /rmDAEmsr16nI6Bw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     "Willett, Tony" <st20214513@outlook.cardiffmet.ac.uk>
Cc:     "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Subject: Re: Problems installing a real time kernel.
Message-ID: <Yp+MWLaEysfFrqaB@lx-t490>
References: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWXP265MB501198E1F104B6044E93E188A5A59@CWXP265MB5011.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 07, 2022, Willett, Tony wrote:
> Hello.
>
> I am trying to work with a Franka Emika Panda Robot Arm and to do so I
> need to run a real time kernel on my Linux PC.
>
> This tutorial/walkthrough is my primary source of information-
> https://frankaemika.github.io/docs/installation_linux.html#setting-up-the-real-time-kernel
>

This is not the primary/official documentation. The primary
documentation is at:

    https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

Please clone the linux-stable-rt git repo directly and switch to the
stable rt version you want, instead of manually applying the RT patch.

> Patch the kernel and set up .config file to choose Preemptable kernel (Real-Time).
> Then I compile it, it produces linux-upstream files which I did not expect.
> Making the kernel looked good and then fails with the following error-
> Initially it gives the following warnings-

Vendor patches or instructions cannot be supported here.

Please clone the repository earlier shown, switch to the stable rt
version you need (list of stable rt releases are in the aforementioned
link), mention the tag you've used, then show the exact build command
sequence you did.

Afterwards, hopefully I can provide some further help.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
