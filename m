Return-Path: <SRS0=PXli=CE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F343C433DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Aug 2020 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5510206FA
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Aug 2020 09:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHZJFV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:05:21 -0400
Received: from mail.monom.org ([188.138.9.77]:46114 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbgHZJFV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Aug 2020 05:05:21 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id BC39350035A;
        Wed, 26 Aug 2020 11:05:18 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 65B64500103;
        Wed, 26 Aug 2020 11:05:18 +0200 (CEST)
Date:   Wed, 26 Aug 2020 11:05:18 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc2-rt1
Message-ID: <20200826090518.m6vblobggnfdjau5@beryllium.lan>
References: <20200824154605.v66t2rsxobt3r5jg@linutronix.de>
 <20200826080802.5lnnf5wh3kcwfykz@beryllium.lan>
 <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826081211.bvk5kfuzh4vlbh5k@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 26, 2020 at 10:12:11AM +0200, Sebastian Andrzej Siewior wrote:
> The RT patch replaced a local-irq-disable with a local-lock which broke.
> I intend to get rid of this local-irq-disable on RT, the local-lock is
> just duct-tape to make it look the same. If this works for everyone then
> I will think of something…

Yep, this patch helps. The system boots now. I give it a complete test
run, just to make sure.
