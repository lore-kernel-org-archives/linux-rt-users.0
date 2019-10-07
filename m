Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D483ECE58D
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6132166E
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 08:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJGIaj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:30:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbfJGIaj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 04:30:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6C6BB1DE;
        Mon,  7 Oct 2019 08:30:37 +0000 (UTC)
Date:   Mon, 7 Oct 2019 10:30:37 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007083037.zu3n5gindvo7damg@beryllium.lan>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Fri, Oct 04, 2019 at 06:30:42PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-10-04 18:20:41 [+0200], Uladzislau Rezki wrote:
> > If we have migrate_disable/enable, then, i think preempt_enable/disable
> > should be replaced by it and not the way how it has been proposed
> > in the patch.
> 
> I don't think this patch is appropriate for upstream.

Yes, I agree. The discussion made this clear, this is only for -rt
trees. Initially I though this should be in mainline too.

Thanks,
Daniel
