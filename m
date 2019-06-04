Return-Path: <SRS0=a75S=UD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24601C282CE
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B8124203
	for <linux-rt-users@archiver.kernel.org>; Tue,  4 Jun 2019 15:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfFDPFB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfFDPFB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 4 Jun 2019 11:05:01 -0400
Received: from oasis.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5147B24059;
        Tue,  4 Jun 2019 15:04:59 +0000 (UTC)
Date:   Tue, 4 Jun 2019 11:04:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Julien Grall <julien.grall@arm.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        julia@ni.com
Subject: Re: KVM Arm Device passthrough and linux-rt
Message-ID: <20190604110454.2b99ee6e@oasis.local.home>
In-Reply-To: <f2fbc06b-373f-ee2a-b111-ea40848dc1c5@arm.com>
References: <26832850-37ee-ae07-08ca-cc3e90978867@arm.com>
        <20190604091607.2e87eb36@oasis.local.home>
        <f2fbc06b-373f-ee2a-b111-ea40848dc1c5@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 4 Jun 2019 14:53:26 +0100
Marc Zyngier <marc.zyngier@arm.com> wrote:

> That's to prevent the injection of an interrupt firing on the same CPU
> while we're saving the corresponding vcpu interrupt context, among other
> things (the whole guest exit path runs with interrupt disabled in order
> to avoid this kind of thing).

Can't we use a per_cpu local lock for this?

-- Steve
