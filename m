Return-Path: <SRS0=uopo=Z2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D59C43603
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04AE20803
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Dec 2019 13:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfLDN6r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfLDN6r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Dec 2019 08:58:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2231B2073C;
        Wed,  4 Dec 2019 13:58:46 +0000 (UTC)
Date:   Wed, 4 Dec 2019 08:58:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.2.21-rt14
Message-ID: <20191204085843.5cfcfd25@gandalf.local.home>
In-Reply-To: <902943c5-9fee-ef45-2b5d-8baa6fa00685@manjaro.org>
References: <20191204095144.kvpbinxqptdszvqq@linutronix.de>
        <902943c5-9fee-ef45-2b5d-8baa6fa00685@manjaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 4 Dec 2019 12:37:34 +0100
Bernhard Landauer <bernhard@manjaro.org> wrote:

> Sorry if maybe I have missed any announcements here, but my I ask if you
> are planning on releasing patches for kernels >5,2 in the near future?
> Or is this project being faded out altogether?

Hopefully in the near future this project will be part of mainline.

-- Steve
