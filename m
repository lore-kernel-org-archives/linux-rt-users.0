Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE3C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Jul 2022 11:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbiGNLcM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiGNLcL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Jul 2022 07:32:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69D206;
        Thu, 14 Jul 2022 04:32:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DFB561FAD3;
        Thu, 14 Jul 2022 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657798327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EmuMePcQGuxM9heOQ2mK6cbP7+zHaIyLwtcEh4MAP1c=;
        b=AvC/B+2wk1WeXNFjl+3PLdV1OI8nMhJ87DzKbddyCNSSeFF7hcUtKUqqkDsb8GeOWlp+CJ
        BJNaz95C6xbnDPgE8dUcHEZiyoidqPAGZt4rE0xjLZKd4O9pHfq/5SfvTqQWIWBc35Cxua
        aJfk1y918cYCN+n1ok77HjixPWb74Wg=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6168E2C141;
        Thu, 14 Jul 2022 11:32:07 +0000 (UTC)
Date:   Thu, 14 Jul 2022 13:32:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Message-ID: <20220714113207.GD2737@pathway.suse.cz>
References: <20220630223258.4144112-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630223258.4144112-1-vschneid@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu 2022-06-30 23:32:56, Valentin Schneider wrote:
> Valentin Schneider (2):
>   kexec: Turn all kexec_mutex acquisitions into trylocks
>   panic, kexec: Make __crash_kexec() NMI safe

This version looks good to me. For both patches:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
