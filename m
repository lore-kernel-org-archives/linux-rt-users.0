Return-Path: <SRS0=+jQa=7J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D4C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 May 2020 17:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DE320663
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 May 2020 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfNxENM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbgE0RkV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 May 2020 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbgE0RkU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 May 2020 13:40:20 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6545EC03E97D
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2020 10:40:20 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c185so296070qke.7
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2020 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c8oaw0N6fdetP2NuOyPxkLrwPteO0Eq8MeHRLnh41/I=;
        b=YfNxENM0I/ABf1rC/j8FUuC81I+ju64ViUg1cI5jlUBSgdkj1B4Yf6PJr+gv0DzeYa
         oH5782W/em/KPa+48d8oyM6DHV1v1BoJTClGifrBObMgFMsCb0B6faPmPOn163MGsFyo
         +h+qzW02r4d1SGouG7jj5HGYa0MXk8QUDXKww2HOkjqfvcdJkYGa5ZpRU+YImyxS7fHa
         PoWXO48L77uJxd96VtwnWZc2HCFCzMeks2NKZFLRzIhrYMjZ0ImnELZ4fIeGhwYOIb0o
         2X0fL5mAF5MMU8fJ84P6YCet3GtdftyqSpKFd5iHdRvJz+91LfM4PuDbzS2whSONQ58c
         05vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=c8oaw0N6fdetP2NuOyPxkLrwPteO0Eq8MeHRLnh41/I=;
        b=ZDjrURjgDcPRoMvH6l3LmS7LYSZ9ZJbR1da26AiwYzokF6UARViOPqyIsY6j7RYUL1
         Iqc7b95RIykh4ulq9B8y44L3bd1Mpwqjsaa0wBIBcOnbASjGoM43XCmkkEX8W1iViO2C
         g/a42l/zr83wtUh1RJdCnGjQY/kO2EQ6vnP3AJqzht85SbOZrzsIIHP78G996zXoPiBK
         ERxd/e/TRJYmXe8gU0p2OisAkmxLN6+hUIfzbzElWW+bg0E3eLOhEhJF8fz89rIEHBTn
         lctQ5aD/yCbZ3n3e1c5C8+h366BgPORq805XkajWLFLZC02wvZ56+yKBhlSY4JzhmdLN
         Y79Q==
X-Gm-Message-State: AOAM533FQvEglTL3ItzpR6CyzPPeAV4xb6YAUBA0I81kzJEuJyPBXYCE
        x6OyDWpfzhUcy80CNeqG+VJuKSxZ
X-Google-Smtp-Source: ABdhPJzE9vYO02H86Rh6D+aSrRA87LSvAJex6A3sI1jfjfepQM/wukNaBP/XvE5bVL4w3gTLpnmYBw==
X-Received: by 2002:a05:620a:346:: with SMTP id t6mr5199032qkm.210.1590601219576;
        Wed, 27 May 2020 10:40:19 -0700 (PDT)
Received: from lclaudio.dyndns.org ([191.177.186.218])
        by smtp.gmail.com with ESMTPSA id c3sm2899718qtp.24.2020.05.27.10.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:40:18 -0700 (PDT)
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 580713C01F5; Wed, 27 May 2020 14:40:16 -0300 (-03)
Date:   Wed, 27 May 2020 14:40:16 -0300
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v5.6.4-rt3] rfcomm/bluetooth: avoid disabling interrupts
 on RT
Message-ID: <20200527174016.GZ5108@uudg.org>
References: <20200423193155.GD75343@uudg.org>
 <20200527094858.qqbctvdgr6bvjfqn@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200527094858.qqbctvdgr6bvjfqn@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 27, 2020 at 11:48:58AM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-23 16:31:55 [-0300], Luis Claudio R. Goncalves wrote:
> …
> > Replacing local_irq_save()/bh_lock_sock() by spin_lock_bh() keeps the semantics
> > and does the right thing under PREEMPT_RT.
> 
> Nope. The irq-off was introduced in commit
>    fad003b6c8e3d ("Bluetooth: Fix inconsistent lock state with RFCOMM")
> 
> It doesn't look right. Could you please revert that commit and check if
> lockdep still complains?

Thanks, Sebastian! I built a kernel with commit fad003b6c8e3d reverted and
the lockdep complaints are gone.

Luis

