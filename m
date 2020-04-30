Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B3BC47253
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD4C92082E
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588273060;
	bh=ncQu2X1hzEoE9xnuu6ERv/wPMSC/uOljmFXBkCOVoLI=;
	h=Subject:From:To:Date:In-Reply-To:References:List-ID:From;
	b=gXlzRhCGtpORjmOERX9hL51ENtclLbQA3Wj0fPG0brETaEQRkY9kUDZqC6qrIhDrb
	 myUxqxWTO/3OfvDUvjIZyivJfy47vHCo0tyIsAw192MIZsSPJ3hSpB/N55LQPtTVlS
	 bNbZseoyuUtjiKBA2BKbJAVWDPTu5tpvG6GykrDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD3S5h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD3S5h (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Apr 2020 14:57:37 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 805192073E;
        Thu, 30 Apr 2020 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588273057;
        bh=ncQu2X1hzEoE9xnuu6ERv/wPMSC/uOljmFXBkCOVoLI=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=TWZpZSpqsrHVi3ysnWg6EPsEFtWG97Svs9w3hlSmJVZONecuUknPYZMf5wUar5a7P
         yunZGkdQLa+1myGGz2ovWvm/wmJb+wdiTTD692xyG/ogNK1EUwgWV00bb1GeRkWmJd
         cKayXfz55c6KCnM6Z3U49ZVOHDydziCA0GuY2O3g=
Message-ID: <770a8588424739feca7e60067140e8d3decf3f21.camel@kernel.org>
Subject: Re: [PATCH RT 0/2] Linux v4.19.115-rt50-rc1
From:   Tom Zanussi <zanussi@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>
Date:   Thu, 30 Apr 2020 13:57:35 -0500
In-Reply-To: <d1aa0d63-d816-7945-e32c-bd1883489fdd@prevas.dk>
References: <cover.1588103561.git.zanussi@kernel.org>
         <d1aa0d63-d816-7945-e32c-bd1883489fdd@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-04-30 at 20:48 +0200, Rasmus Villemoes wrote:
> On 28/04/2020 21.52, zanussi@kernel.org wrote:
> > From: Tom Zanussi <zanussi@kernel.org>
> > 
> > Dear RT Folks,
> > 
> > This is the RT stable review cycle of patch 4.19.115-rt50-rc1.
> > 
> > Please scream at me if I messed something up. Please test the
> > patches
> > too.
> 
> For good measure, the customer reports that 4.19.115-rt50-rc1 indeed
> seems to fix the boot hang they saw.

OK, great, glad to hear that.

Thanks,

Tom
 
> 
> Thanks,
> Rasmus

